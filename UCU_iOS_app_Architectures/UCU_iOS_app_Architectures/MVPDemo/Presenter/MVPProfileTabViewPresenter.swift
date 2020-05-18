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
    
    // rox-tip: the connection might resemble a delegate connection, but it is not - the delegate pattern has entirely different role and responsibilities, so the name is higly misleading
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

        // rox-fix: I've got a crash here because of force unwrap :(
        // what happens is, the View loads faster than the presenter gets it's user. That is why the responsibility to update the View falls onto presenter - it only sends the View it's data when it's ready. What you have here is the View ASKS presenter for data, which happens not to be ready yet.
        self.imageAPIClient.loadImage(url: user?.avatarURL) { image in
            img = image
        }

        return img
    }
    
    func userDesc() -> String{
        var desc: String = ""
        
        // rox-fix: duplication of calling `getMe`
        // also, the complition would assign it's result far later than the func is returned. Which means that the View will get only an empty string initialized above.
        userAPIClient.getMe { [weak self] (user) in
            self?.user = user
            
            // rox-tip: good thinking moving formatting logic to presenter!
            desc = "\((user.firstName ?? "") + " " + (user.lastName ?? "")) was born in \(user.city ?? ""), \(user.country ?? "")"
            
        }
        
        return desc
    }
    
}

