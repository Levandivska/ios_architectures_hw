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

// rox-fix: final
class MVCEditProfileViewController: UIViewController {
    
    // rox-fix: could be private
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var countryNameTextField: UITextField!
    
    weak var delegate: MVCEditProfileViewControllerDelegate?
    
    // rox-tip: there is no need to assign nil to optional properties; they are initialized with nil by default
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
 
        // rox-fix: DRY violation. This could be moved to a private UITextField extension,
        // (see example at the end of file)
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

        // rox-tip: very nice moving the alert logic to a separate class! Way to go, Single responsibility ;)
        // disappears
        //
        // rox: oh yes, I can see that it disappears, and here is why:
        // when you are showing the alert here ( `self.present(alert.alert, animated: true, completion: nil)`) the execution does not stop, but goes to the next lines:
        //`user?.firstName = firstNameTextField.text`
        //`user?.lastName = lastNameTextField.text`
        // and so on.
        // And then - the dismiss line `dismiss(animated: true, completion: nil)` which actually does not dismisses itself (aka MVCEditProfileViewController) but the controller on top of it (aka AlertController)
        // So what you want to do is either add an explicit `return` after `self.present(alert.alert, animated: true, completion: nil)` to stop the execution of the func, or move all the lines below into an `else` clause.
        // Hope that helps ;)
        
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
    
    // rox-fix: could also be private
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        view?.endEditing(true)
    }
}

// rox-fix: DRY violation fix suggestion
private extension UITextField {
    var isBlank: Bool {
        return text?.isEmpty ?? true
    }
}

