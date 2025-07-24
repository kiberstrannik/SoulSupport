//
//  TopicSelectionView.swift
//  SoulSupport
//
//  Created by Nikita on 24/07/2025.
//

import SwiftUI

struct TopicSelectionView: View {
    @State private var selectedTopic: String? = nil
    @State private var navigateToChat = false

    let topics = [
        "Anxiety",
        "Loneliness",
        "Motivation",
        "Self-esteem",
        "Stress"
    ]

    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                Text("What would you like to talk about?")
                    .font(.title2)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding()

                ForEach(topics, id: \.self) { topic in
                    Button(action: {
                        selectedTopic = topic
                        navigateToChat = true
                    }) {
                        Text(topic)
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue.opacity(0.2))
                            .foregroundColor(.blue)
                            .cornerRadius(10)
                    }
                }

                Spacer()
            }
            .padding()
            .background(
                NavigationLink(
                    destination: ChatView(initialTopic: selectedTopic ?? ""),
                    isActive: $navigateToChat
                ) {
                    EmptyView()
                }
                .hidden()
            )
        }
    }
}
