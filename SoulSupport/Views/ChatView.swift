//
//  ChatView.swift
//  SoulSupport
//
//  Created by Nikita on 21/07/2025.
//

import SwiftUI

struct ChatView: View {
    let initialTopic: String

    @StateObject var viewModel = ChatViewModel()
    @State private var inputText = ""

    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(viewModel.messages) { message in
                            ChatBubbleView(message: message)
                                .id(message.id)
                        }

                        if viewModel.isTyping {
                            HStack {
                                Spacer()
                                Text("Typing...")
                                    .italic()
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                            .padding(.top, 4)
                        }
                    }
                    .padding(.top)
                }
                .onChange(of: viewModel.messages.count) { _ in
                    if let last = viewModel.messages.last {
                        withAnimation {
                            proxy.scrollTo(last.id, anchor: .bottom)
                        }
                    }
                }
            }

            // Ввод сообщения + кнопка
            HStack {
                TextField("Write your message...", text: $inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.vertical, 10)

                Button(action: {
                    guard !inputText.isEmpty else { return }
                    viewModel.sendMessage(inputText)
                    inputText = ""
                }) {
                    Text("Send")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(Color.cyan)
                        .cornerRadius(10)
                        .shadow(color: Color.cyan.opacity(0.3), radius: 4, x: 0, y: 2)
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .navigationTitle("SoulSupport")
        .onAppear {
            if !initialTopic.isEmpty {
                viewModel.sendMessage("I want to talk about \(initialTopic.lowercased()).")
            }
        }
    }
}
