//
//  AllModel.swift
//  Messager
//
//  Created by Frédéric Helfer on 12/12/22.
//

import Foundation

class Message {
    var text: String?
    var userId: String?
    
    init(dictionary: [String : Any]) {
        self.text = dictionary["text"] as? String
        self.userId = dictionary["userId"] as? String
    }
}

class Conversation {
    var name: String?
    var lastMessage: String?
    var destinationId: String?
    
    init(dictionary: [String : Any]) {
        self.name = dictionary["name"] as? String
        self.lastMessage = dictionary["lastMessage"] as? String
        self.destinationId = dictionary["destinationId"] as? String
    }
}

class User {
    var name: String?
    var email: String?
    
    init(dictionary: [String : Any]) {
        self.name = dictionary["name"] as? String
        self.email = dictionary["email"] as? String
    }
}


class Contact {
    var id: String?
    var name: String?
    
    init(dictionary: [String : Any]?) {
        self.name = dictionary?["name"] as? String
        self.id = dictionary?["id"] as? String
    }
    
    convenience init(id: String?, name: String?) {
        self.init(dictionary: nil)
        self.id = id
        self.name = name
    }
}
