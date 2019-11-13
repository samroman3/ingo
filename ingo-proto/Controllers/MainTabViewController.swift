//
//  MainTabViewController.swift
//  ingo-proto
//
//  Created by Sam Roman on 11/13/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class MainTabViewController: UITabBarController {
    
    
    lazy var feedVC = UINavigationController(rootViewController: FeedViewController())

//    lazy var usersVC = UINavigationController(rootViewController: ProfileViewController())

    lazy var profileVC: UINavigationController = {
        let userProfileVC = ProfileViewController()
        userProfileVC.user = AppUser(from: FirebaseAuthService.manager.currentUser!)
        userProfileVC.isCurrentUser = true
        return UINavigationController(rootViewController: userProfileVC)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedVC.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "list.dash"), tag: 0)
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.square"), tag: 1)
        self.viewControllers = [feedVC, profileVC]
    }


        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


