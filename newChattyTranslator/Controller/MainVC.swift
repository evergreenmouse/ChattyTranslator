//
//  ViewController.swift
//  newChattyTranslator
//
//  Created by Александр Ополовников on 07/04/2019.
//  Copyright © 2019 evergreenmouse. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    


    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    var bottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        tableView.separatorStyle = .none
        
        tableView.register(ChatCell.self, forCellReuseIdentifier: "chatCell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
        
        bottomConstraint = NSLayoutConstraint(item: inputTextField as Any, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraint(bottomConstraint!)

    }
    
    @objc func handleKeyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            
            bottomConstraint?.constant = isKeyboardShowing ? -keyboardFrame!.height-8 : -8
            
            UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }) { (comleted) in
                if TranslationService.instance.currentSessionArray.count-1 >= 0 {
                    self.tableView.scrollToRow(at: IndexPath(row: TranslationService.instance.currentSessionArray.count-1, section: 0), at: .bottom, animated: true)
                }
            }
        }
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }

    @IBAction func sendButtonPressed(_ sender: Any) {
        if inputTextField.text != "" || inputTextField.text != nil {
            
            getTranslation(text: inputTextField.text!)
            view.endEditing(true)
            inputTextField.text = nil
        }
    }
    
    func getTranslation(text: String) {
        TranslationService.instance.currentSessionArray.append(Message(messageText: text, isIncoming: false))
        self.tableView.reloadData()
        TranslationService.instance.getTranslation(textToTranslate: text) { (success) in
            if success {
                self.tableView.reloadData()
                self.tableView.scrollToRow(at: IndexPath(row: TranslationService.instance.currentSessionArray.count-1, section: 0), at: .bottom, animated: true)
            }
        }
    }
    
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TranslationService.instance.currentSessionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as! ChatCell
        let message = TranslationService.instance.currentSessionArray[indexPath.row]
        cell.chatMessage = message
        return cell
    }
    
    
}

