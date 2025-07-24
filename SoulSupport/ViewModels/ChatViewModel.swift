//
//  ChatViewModel.swift.swift
//  SoulSupport
//
//  Created by Nikita on 21/07/2025.
//

import SwiftUI

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var isTyping: Bool = false

    func sendMessage(_ text: String) {
        let userMessage = Message(sender: .user, text: text)
        messages.append(userMessage)

        isTyping = true

        NetworkManager.shared.sendMessage(message: text) { [weak self] responseText in
            DispatchQueue.main.async {
                let aiMessage = Message(sender: .ai, text: responseText)
                self?.messages.append(aiMessage)
                self?.isTyping = false
            }
        }
    }
}

