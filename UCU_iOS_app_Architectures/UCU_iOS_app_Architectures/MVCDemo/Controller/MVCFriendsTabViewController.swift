//
//  FriendsTabViewController.swift
//  UCU_iOS_app_Architectures
//
//  Created by Roxane Gud on 4/27/20.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import UIKit

// MVC: Controller
// -----------------
final class MVCFriendsViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
        }
    }

    private let userAPIClient = UserAPIClient()
    private let imageAPIClient = ImageAPIClient()
    
    private var friends = [User]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFriends()
    }
    
    private func loadFriends() {
        
        userAPIClient.getFriends { (users) in
            self.friends = users
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(MVCFriendTableViewCell.self, for: indexPath)
        
        let user = friends[indexPath.row]
        cell.nameLabel?.text = (user.firstName ?? "") + " " + (user.lastName ?? "")
        
        imageAPIClient.loadImage(url: user.avatarURL) { image in
            cell.avatarImageView.image = image
        }
        
        return cell
    }
}
