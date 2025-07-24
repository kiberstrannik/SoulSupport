//
//  ChatBubbleView.swift
//  SoulSupport
//
//  Created by Nikita on 24/07/2025.
//

import SwiftUI

struct ChatBubbleView: View {
    let message: Message

    var body: some View {
        HStack {
            if message.sender == .ai {
                Spacer()
                Text(message.text)
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(10)
                    .frame(maxWidth: 250, alignment: .trailing)
            } else {
                Text(message.text)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .frame(maxWidth: 250, alignment: .leading)
                Spacer()
            }
        }
        .padding(.horizontal)
    }
}
