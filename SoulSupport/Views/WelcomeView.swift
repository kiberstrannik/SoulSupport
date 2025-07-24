//
//  WelcomeView.swift
//  SoulSupport
//
//  Created by Nikita on 23/07/2025.
//

import SwiftUI

struct WelcomeView: View {
    @State private var animate = false
    @State private var showChat = false

    var body: some View {
        if showChat {
            TopicSelectionView() // ← твой готовый чат, всё подхватится
        } else {
            ZStack {
                Color.white.ignoresSafeArea()
                
                VStack(spacing: 30) {
                    Spacer()
                    
                    Text("🧠 SoulSupport")
                        .font(.largeTitle)
                        .bold()
                        .opacity(animate ? 1 : 0)
                        .scaleEffect(animate ? 1 : 0.5)
                        .animation(.easeInOut(duration: 1.2), value: animate)
                    
                    Text("Your AI companion for emotional support")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                        .opacity(animate ? 1 : 0)
                        .animation(.easeInOut.delay(0.5), value: animate)

                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            showChat = true
                        }
                    }) {
                        Text("Start Session")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .padding(.horizontal)
                    }
                    .opacity(animate ? 1 : 0)
                    .animation(.easeInOut.delay(1.0), value: animate)
                    
                    Spacer()
                }
                .onAppear {
                    animate = true
                }
            }
        }
    }
}
