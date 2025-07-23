//
//  ChatView.swift
//  SoulSupport
//
//  Created by Nikita on 21/07/2025.
//

import SwiftUI

struct ChatView: View {
    @StateObject var viewModel = ChatViewModel()
    @State private var inputText = ""
    
    var body: some View {
        VStack {
            if viewModel.messages.isEmpty {
                Spacer()
                
                VStack(spacing: 16) {
                    Text("Start a conversation")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    inputField
                }
                .padding()
                .transition(.move(edge: .bottom).combined(with: .opacity))
                
                Spacer()
            } else {
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(spacing: 8) {
                            ForEach(viewModel.messages) { message in
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
                                .id(message.id)
                            }
                        }
                        .padding(.vertical)
                    }
                    .onChange(of: viewModel.messages.count) { _ in
                        if let last = viewModel.messages.last {
                            withAnimation {
                                proxy.scrollTo(last.id, anchor: .bottom)
                            }
                        }
                    }
                }
                
                inputField
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .padding(.bottom)
            }
        }
        .animation(.easeInOut(duration: 0.35), value: viewModel.messages.count)
    }
    
    private var inputField: some View {
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
                    .background(Color.blue.opacity(0.8))
                    .cornerRadius(10)
                    .shadow(color: Color.blue.opacity(0.3), radius: 4, x: 0, y: 2)
            }
        }
        .padding(.horizontal)
    }
    
}
