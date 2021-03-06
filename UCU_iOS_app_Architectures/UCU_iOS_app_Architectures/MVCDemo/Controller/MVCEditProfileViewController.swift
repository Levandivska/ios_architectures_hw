//
//  EditProfileViewController.swift
//  UCU_iOS_app_Architectures
//
//  Created by Roxane Gud on 4/27/20.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import UIKit

protocol MVCEditProfileViewControllerDelegate: class {
    func editProfileViewControllerDidSave(_ editProfileVC: MVCEditProfileViewController)
}

class MVCEditProfileViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var countryNameTextField: UITextField!
    
    weak var delegate: MVCEditProfileViewControllerDelegate?
    
    var user: User? = nil
    
    override func viewDidLoad() {
        firstNameTextField.text = user?.firstName
        lastNameTextField.text = user?.lastName
        
        cityNameTextField.text = user?.city
        countryNameTextField.text = user?.country
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }

    @IBAction private func cancelButtonDidTap() {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction private func saveButtonDidTap() {
              
        var emptyFields: [String] = []
 
        if firstNameTextField.text?.isEmpty ?? true {
            emptyFields += ["'First name'"]
        }
        
        if lastNameTextField.text?.isEmpty ?? true {
            emptyFields += ["'Last name'"]
        }
        
        if cityNameTextField.text?.isEmpty ?? true {
           emptyFields += ["'City'"]
        }
        
        if countryNameTextField.text?.isEmpty ?? true {
            emptyFields += ["'Country'"]
        }

        // disappears
        if let alertObj = EmptyFieldsAlert(emptyFields){
            alertObj.addAlertAction()
            self.present(alertObj.alert, animated: true, completion: nil)
        }
        
        user?.firstName = firstNameTextField.text
        user?.lastName = lastNameTextField.text
        
        user?.city = cityNameTextField.text
        user?.country = countryNameTextField.text
        
        delegate?.editProfileViewControllerDidSave(self)
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        view?.endEditing(true)
    }
}

