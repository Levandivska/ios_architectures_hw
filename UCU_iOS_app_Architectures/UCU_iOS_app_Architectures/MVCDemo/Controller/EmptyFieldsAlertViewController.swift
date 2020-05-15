//
//  EmptyFieldsAlertViewController.swift
//  UCU_iOS_app_Architectures
//
//  Created by оля on 15.05.2020.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import Foundation
import UIKit

class EmptyFieldsAlert{
    var alert: UIAlertController
    private let title = "alert"

    init?(_ emptyFields: [String]){
        
        if emptyFields.isEmpty {return nil}
        
        var fieldsStr = ""
        
        emptyFields.forEach { field in
            fieldsStr += " " + field + ","
        }
        
        let emptyFieldsStr = String(fieldsStr.dropLast())
                
        let message = EmptyFieldsAlert.createMessage(emptyFields: emptyFieldsStr, numEmptyFields:emptyFields.count)
        
        alert = UIAlertController(title: self.title, message: message, preferredStyle: .alert)

    }

    static private func createMessage(emptyFields: String, numEmptyFields: Int) -> String{
        var msg = "Input field"
                
        if numEmptyFields > 1{
            msg += "s"
        }
           
        msg += emptyFields
                
        if numEmptyFields > 1{
            msg += " are "
        } else{ msg += " is "}
                
        msg += "empty"
        return msg
    }
    
    func addAlertAction(){
        self.alert.addAction(UIAlertAction(title: "Yes, save", style: .default, handler: { _ in
            print("yes")
        }))
        self.alert.addAction(UIAlertAction(title: "No, go back", style: .cancel, handler: {(_: UIAlertAction!) in
                print("no")
               }))
    }
}
