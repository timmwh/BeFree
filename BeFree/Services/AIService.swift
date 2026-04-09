//
//  AIService.swift
//  BeFree
//
//  Created by Tim Meiwirth on 09.04.26.
//

import Foundation

class AIService {
    static let shared = AIService()

    private init() {}

    private let endpoint = URL(string: "https://api.openai.com/v1/chat/completions")!
    private let model = "gpt-4o-mini"

    var isConfigured: Bool {
        !Config.openAIApiKey.isEmpty && Config.openAIApiKey != "your-openai-api-key-here"
    }

    // MARK: - System Prompt

    func systemPrompt(for step: Step, businessModel: BusinessModel?) -> String {
        let modelName = businessModel?.name ?? "online business"
        return """
        You are a concise, practical business coach inside the BeFree app.
        The user is currently working on this step of their \(modelName) journey:

        Step: \(step.title)
        Description: \(step.description.components(separatedBy: "\n\n").first ?? step.description)

        Your role:
        - Answer their questions about this specific step clearly and directly
        - Give actionable, specific advice — not generic motivational talk
        - Be encouraging but honest
        - Keep each response to 2–4 sentences maximum
        - If they ask something off-topic, gently redirect to the current step
        """
    }

    // MARK: - Non-streaming send (simple, reliable)

    func sendMessage(
        _ userMessage: String,
        history: [ChatMessage],
        step: Step,
        businessModel: BusinessModel?,
        completion: @escaping (Result<String, AIError>) -> Void
    ) {
        guard isConfigured else {
            completion(.failure(.notConfigured))
            return
        }

        var messages: [[String: String]] = [
            ["role": "system", "content": systemPrompt(for: step, businessModel: businessModel)]
        ]

        for msg in history {
            messages.append(["role": msg.role.rawValue, "content": msg.content])
        }
        messages.append(["role": "user", "content": userMessage])

        let body: [String: Any] = [
            "model": model,
            "messages": messages,
            "max_tokens": 300,
            "temperature": 0.7
        ]

        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(Config.openAIApiKey)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(.networkError(error.localizedDescription)))
                    return
                }

                guard let data = data,
                      let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                      let choices = json["choices"] as? [[String: Any]],
                      let first = choices.first,
                      let message = first["message"] as? [String: Any],
                      let content = message["content"] as? String else {
                    if let data = data,
                       let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                       let errorObj = json["error"] as? [String: Any],
                       let errorMessage = errorObj["message"] as? String {
                        completion(.failure(.apiError(errorMessage)))
                    } else {
                        completion(.failure(.invalidResponse))
                    }
                    return
                }

                completion(.success(content.trimmingCharacters(in: .whitespacesAndNewlines)))
            }
        }.resume()
    }
}

// MARK: - Chat Message Model

struct ChatMessage: Identifiable {
    let id = UUID()
    let role: MessageRole
    let content: String
    let timestamp = Date()

    enum MessageRole: String {
        case user
        case assistant
    }
}

// MARK: - Error Types

enum AIError: LocalizedError {
    case notConfigured
    case networkError(String)
    case apiError(String)
    case invalidResponse

    var errorDescription: String? {
        switch self {
        case .notConfigured:
            return "API key not set. Add your OpenAI key to Config.swift."
        case .networkError(let msg):
            return "Network error: \(msg)"
        case .apiError(let msg):
            return "API error: \(msg)"
        case .invalidResponse:
            return "Unexpected response from the AI. Please try again."
        }
    }
}
