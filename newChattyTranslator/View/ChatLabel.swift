//
//  ChatLabel.swift
//  newChattyTranslator
//
//  Created by Александр Ополовников on 07/04/2019.
//  Copyright © 2019 evergreenmouse. All rights reserved.
//

import UIKit

class ChatLabel: UILabel {

    var chatMessage: Message!{
        didSet {
            text = chatMessage.messageText
            textColor = chatMessage.isIncoming ? .black : .white
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        numberOfLines = 0
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
