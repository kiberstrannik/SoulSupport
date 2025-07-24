//
//  NetworkManager.swift
//  SoulSupport
//
//  Created by Nikita on 22/07/2025.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
   
    private var apiKey: String {
        guard let filePath = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: filePath),
              let key = plist["API_KEY"] as? String else {
            fatalError("API key not found in Secrets.plist")
        }
        return key
    }
    
    func sendMessage(message: String, completion: @escaping (String) -> Void) {
        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [
                ["role": "system", "content": "You are a helpful psychological assistant."],
                ["role": "user", "content": message]
            ],
            "temperature": 0.7
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion("Error: No data received from server.")
                }
                return
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("Full response from OpenAI: \(responseString)")
            }
            
            do {
                if let result = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    if let error = result["error"] as? [String: Any],
                       let code = error["code"] as? String,
                       code == "insufficient_quota" {
                        // Специальное сообщение для превышения квоты
                        DispatchQueue.main.async {
                            completion("Error: You exceeded your current quota. Please check your OpenAI plan and billing details.")
                        }
                        return
                    }
                    
                    if let choices = result["choices"] as? [[String: Any]],
                       let message = choices.first?["message"] as? [String: Any],
                       let content = message["content"] as? String {
                        DispatchQueue.main.async {
                            completion(content.trimmingCharacters(in: .whitespacesAndNewlines))
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion("Error: Unexpected JSON structure.")
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        completion("Error: Failed to parse response.")
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    completion("Error parsing JSON: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
}
