//
//  TranslationService.swift
//  newChattyTranslator
//
//  Created by Александр Ополовников on 07/04/2019.
//  Copyright © 2019 evergreenmouse. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class TranslationService {
    
    static let instance = TranslationService()
    var currentSessionArray = [Message]()
    
    func getTranslation(textToTranslate: String, completion: @escaping CompletionHandler) {
 
        let PARAMETERS = [
            "text": textToTranslate,
            "key": API_KEY,
            "lang": "ru-en"]
        
        Alamofire.request(BASE_URL, method: .post, parameters: PARAMETERS, encoding: URLEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                let json = try? JSON(data: data)
                let textArray = json?["text"].arrayObject ?? ["Что-то пошло не так :("]
                let text = textArray[0] as! String
                let message = Message(messageText: text, isIncoming: true)
                self.currentSessionArray.append(message)
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    
    
}
