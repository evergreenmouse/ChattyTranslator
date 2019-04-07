//
//  BubbleView.swift
//  newChattyTranslator
//
//  Created by Александр Ополовников on 07/04/2019.
//  Copyright © 2019 evergreenmouse. All rights reserved.
//

import UIKit

class BubbleView: UIView {

    var isIncoming: Bool! {
        didSet {
            backgroundColor = isIncoming ? .green : .darkGray
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 8
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
