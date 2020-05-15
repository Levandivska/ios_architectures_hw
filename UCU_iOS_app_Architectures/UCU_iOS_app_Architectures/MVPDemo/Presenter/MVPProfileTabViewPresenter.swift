//
//  MVPProfileTabViewPresenter.swift
//  UCU_iOS_app_Architectures
//
//  Created by оля on 12.05.2020.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import Foundation
import UIKit

protocol MVPProfileTabViewDelegate: NSObjectProtocol {
    func displayUserName(name: String?)
    func displayUserImg(img: UIImage?)
    func displayUserDesc(text: String?)
}

class MVPProfileTabViewPresenter{
    
    let userAPIClient = UserAPIClient()
    let imageAPIClient = ImageAPIClient()
    
    var name: String? = nil
    
    var user: User? = nil
    
    weak private var mVPProfileTabViewDelegate: MVPProfileTabViewDelegate?
    
    init(){
        
        userAPIClient.getMe { [weak self] (user) in
            self?.user = user
        }
    }
    
    func setViewDelegate(mVPProfileTabViewDelegate: MVPProfileTabViewDelegate){
        self.mVPProfileTabViewDelegate = mVPProfileTabViewDelegate
    }
    
    func userName() -> String{
        
        userAPIClient.getMe { [weak self] (user) in
            self?.user = user
            
            
        }
        
        return (user?.firstName ?? "") + " " + (user?.lastName ?? "")
    
    }
    
    func userImg() -> UIImage?{
        // force
        var img: UIImage? =  nil

        self.imageAPIClient.loadImage(url: user!.avatarURL) { image in
            img = image
        }

        return img
    }
    
    func userDesc() -> String{
        var desc: String = ""
        
        userAPIClient.getMe { [weak self] (user) in
            self?.user = user
            
            desc = "\((user.firstName ?? "") + " " + (user.lastName ?? "")) was born in \(user.city ?? ""), \(user.country ?? "")"
            
        }
        
        return desc
    }
    
}

