//
//  ChatUser.swift
//  AITOH
//
//  Created by Jerry Kwok on 31/3/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//
import MessengerKit

struct ChatUser: MSGUser {
    
    var displayName: String
    
    var avatar: UIImage?
    
    var avatarUrl: URL?
    
    var isSender: Bool
    
    
    
}
