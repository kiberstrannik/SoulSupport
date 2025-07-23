//
//  ChatViewModel.swift.swift
//  SoulSupport
//
//  Created by Nikita on 21/07/2025.
//

import SwiftUI

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []

    func sendMessage(_ text: String) {
        // Добавляем сообщение пользователя
        let userMessage = Message(sender: .user, text: text)
        messages.append(userMessage)

        // Отправляем сообщение в нейросеть через NetworkManager
        NetworkManager.shared.sendMessage(message: text) { [weak self] responseText in
            DispatchQueue.main.async {
                let aiMessage = Message(sender: .ai, text: responseText)
                self?.messages.append(aiMessage)
            }
        }
    }
}

