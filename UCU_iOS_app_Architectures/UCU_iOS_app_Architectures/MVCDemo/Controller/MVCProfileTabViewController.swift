//
//  ProfileTabViewController.swift
//  UCU_iOS_app_Architectures
//
//  Created by Roxane Gud on 4/27/20.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import UIKit

// MVC: Controller
// -----------------
class MVCProfileViewController: UIViewController {
    
    let userAPIClient = UserAPIClient()
    let imageAPIClient = ImageAPIClient()
    
    @IBOutlet weak var headerView: MVCProfileTabHeaderView!
    
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
    
    private func setupUI() {
        descriptionLabel.textColor = .iris
        descriptionLabel.font = UIFont(name: "AvenirNext-Regular", size: 14.0)
        
        //headerView
        headerView.nameLabel.textColor = .iris
        headerView.nameLabel.font = UIFont(name: "AvenirNext-Bold", size: 16.0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMVCEditProfileViewController", let editProfileVC = segue.destination as? MVCEditProfileViewController {
            
            editProfileVC.user = user
            editProfileVC.delegate = self
        }
    }
}

extension MVCProfileViewController: MVCEditProfileViewControllerDelegate {
    func editProfileViewControllerDidSave(_ editProfileVC: MVCEditProfileViewController) {
        self.user = editProfileVC.user
        
        headerView.nameLabel.text = (user?.firstName ?? "") + " " + (user?.lastName ?? "")

        descriptionLabel.text = "\((user?.firstName ?? "") + " " + (user?.lastName ?? "")) was born in \(user?.city ?? ""), \(user?.country ?? "")"
    }
}
