//
//  ChatVC.swift
//  ChatApp
//
//  Created by Rituraj Mishra on 14/02/22.
//  Copyright © 2022 rtrjmishra. All rights reserved.
//

import UIKit
import MessageKit

struct Sender: SenderType
{
    var senderId: String
    var displayName: String
    
    
}
struct Message: MessageType
{
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}

class ChatVC: MessagesViewController
{
    let userOne = Sender(senderId: "self", displayName: "User 1")
    let userTwo = Sender(senderId: "other", displayName: "User 2")
    
    var messages = [MessageType]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 217.0/255.0, green: 217.0/255.0, blue: 217.0/255.0, alpha: 1.0)
        
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.isOpaque = true
        navigationController?.navigationBar.barTintColor = .lightGray
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        messagesCollectionView.backgroundColor = .white
        
        messages.append(Message(sender: userOne, messageId: "1", sentDate: Date(), kind: .text("Hello User 1 here.")))
        messages.append(Message(sender: userTwo, messageId: "2", sentDate: Date(), kind: .text("Hello again User 2 here.")))
        messages.append(Message(sender: userOne, messageId: "3", sentDate: Date(), kind: .text("Hello watsup?")))
        messages.append(Message(sender: userTwo, messageId: "4", sentDate: Date(), kind: .text("Nothing Much you tell.")))
        messages.append(Message(sender: userOne, messageId: "5", sentDate: Date(), kind: .text("Same here.")))
        messages.append(Message(sender: userTwo, messageId: "6", sentDate: Date(), kind: .text("Oh okay:)")))
    }
    
}

extension ChatVC: MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate
{
    func currentSender() -> SenderType
    {
        return userOne
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType
    {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int
    {
        return messages.count
    }
    
    
}
