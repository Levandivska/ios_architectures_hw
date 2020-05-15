//
//  ProfileTabViewController.swift
//  UCU_iOS_app_Architectures
//
//  Created by Roxane Gud on 4/27/20.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import UIKit

// MVP: Controller
// -----------------

class MVPProfileViewController: UIViewController, MVPProfileTabViewDelegate{
    
    private let profileViewPresenter = MVPProfileTabViewPresenter()
    
    @IBOutlet private weak var headerView: MVPProfileTabHeaderView!
    
    @IBOutlet private weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.applyBodyStyle()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()

        self.profileViewPresenter.setViewDelegate(mVPProfileTabViewDelegate: self)
        
        displayUserName(name: self.profileViewPresenter.userName())
        
        displayUserImg(img: profileViewPresenter.userImg() )
    
        displayUserDesc(text: self.profileViewPresenter.userDesc())
    }
        
    
    func displayUserName(name: String?){
        self.headerView.nameLabel.text = name
    }
    
    func displayUserImg(img: UIImage?){
        self.headerView.avatarImageView.image = img
    }
    
    func displayUserDesc(text: String?){
        self.descriptionLabel.text = text
    }
       
    func setupUI() {
        descriptionLabel.textColor = .iris
        descriptionLabel.font = UIFont(name: "AvenirNext-Regular", size: 14.0)
        
        //headerView
        headerView.nameLabel.textColor = .iris
        headerView.nameLabel.font = UIFont(name: "AvenirNext-Bold", size: 16.0)
    }
}

//extension MVPProfileViewController: MVPEditProfileViewControllerDelegate {
//    func editProfileViewControllerDidSave(_ editProfileVC: MVPEditProfileViewController) {
//        self.user = editProfileVC.user
//
//        headerView.nameLabel.text = (user?.firstName ?? "") + " " + (user?.lastName ?? "")
//
//        descriptionLabel.text = "\((user?.firstName ?? "") + " " + (user?.lastName ?? "")) was born in \(user?.city ?? ""), \(user?.country ?? "")"
//    }
//}
