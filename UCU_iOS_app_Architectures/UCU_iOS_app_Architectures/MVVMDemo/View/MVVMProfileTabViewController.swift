//
//  ProfileTabViewController.swift
//  UCU_iOS_app_Architectures
//
//  Created by Roxane Gud on 4/27/20.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import UIKit

// MVVM: Controller
// -----------------
class MVVMProfileViewController: UIViewController {
    
    let userAPIClient = UserAPIClient()
    let imageAPIClient = ImageAPIClient()
    
    @IBOutlet weak var headerView: MVVMProfileTabHeaderView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        userAPIClient.getMe { [weak self] (user) in
            self?.user = user
            
            self?.headerView.nameLabel.text = (user.firstName ?? "") + " " + (user.lastName ?? "")
            
            self?.imageAPIClient.loadImage(url: user.avatarURL) { image in
                self?.headerView.avatarImageView.image = image
            }
            
            self?.descriptionLabel.text = "\((user.firstName ?? "") + " " + (user.lastName ?? "")) was born in \(user.city ?? ""), \(user.country ?? "")"
        }
    }
    
    func setupUI() {
        descriptionLabel.textColor = .iris
        descriptionLabel.font = UIFont(name: "AvenirNext-Regular", size: 14.0)
        
        //headerView
        headerView.nameLabel.textColor = .iris
        headerView.nameLabel.font = UIFont(name: "AvenirNext-Bold", size: 16.0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMVVMEditProfileViewController", let editProfileVC = segue.destination as? MVVMEditProfileViewController {
            
            editProfileVC.user = user
            editProfileVC.delegate = self
        }
    }
}

extension MVVMProfileViewController: MVVMEditProfileViewControllerDelegate {
    func editProfileViewControllerDidSave(_ editProfileVC: MVVMEditProfileViewController) {
        self.user = editProfileVC.user
        
        headerView.nameLabel.text = (user?.firstName ?? "") + " " + (user?.lastName ?? "")

        descriptionLabel.text = "\((user?.firstName ?? "") + " " + (user?.lastName ?? "")) was born in \(user?.city ?? ""), \(user?.country ?? "")"
    }
}
