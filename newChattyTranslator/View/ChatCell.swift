//
//  ChatCell.swift
//  newChattyTranslator
//
//  Created by Александр Ополовников on 07/04/2019.
//  Copyright © 2019 evergreenmouse. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {
    
    let chatLabel = ChatLabel()
    let bubbleView = BubbleView()
    
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    
    var chatMessage: Message! {
        didSet {
            bubbleView.isIncoming = chatMessage.isIncoming
            chatLabel.chatMessage = chatMessage
            if chatMessage.isIncoming {
                leadingConstraint.isActive = true
                trailingConstraint.isActive = false
            } else {
                leadingConstraint.isActive = false
                trailingConstraint.isActive = true
            }
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubview(bubbleView)
        
        addSubview(chatLabel)
        
        let constraints = [chatLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
                           chatLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
                           chatLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
                           
                           bubbleView.topAnchor.constraint(equalTo: chatLabel.topAnchor, constant: -8),
                           bubbleView.bottomAnchor.constraint(equalTo: chatLabel.bottomAnchor, constant: 8),
                           bubbleView.leadingAnchor.constraint(equalTo: chatLabel.leadingAnchor, constant: -8),
                           bubbleView.trailingAnchor.constraint(equalTo: chatLabel.trailingAnchor, constant: 8)]
        
        NSLayoutConstraint.activate(constraints)
        
        leadingConstraint = chatLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        leadingConstraint.isActive = false
        
        trailingConstraint = chatLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        trailingConstraint.isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
