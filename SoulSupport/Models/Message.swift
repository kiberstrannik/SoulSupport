//
//  Message.swift.swift
//  SoulSupport
//
//  Created by Nikita on 21/07/2025.
//

import Foundation

struct Message: Identifiable {
    let id = UUID()
    let sender: Sender
    let text: String

    enum Sender {
        case user
        case ai
    }
}
