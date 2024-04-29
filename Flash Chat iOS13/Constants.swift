//
//  Constants.swift
//  Flash Chat iOS13
//
//  Created by Gustavo Mendonca on 29/04/24.
//  Copyright © 2024 Angela Yu. All rights reserved.
//
struct Constants{
    static let appName = "⚡️FlashChat"
    static let registerSegue = "registerToChat"
    static let loginSegue = "loginToChat"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }

    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}

