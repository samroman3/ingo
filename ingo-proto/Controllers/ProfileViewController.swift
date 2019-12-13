//
//  ProfileViewController.swift
//  ingo-proto
//
//  Created by Sam Roman on 11/13/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    
    var user: AppUser!
    
    var isCurrentUser = false
   
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.isScrollEnabled = true
        sv.backgroundColor = .gray
        sv.showsVerticalScrollIndicator = true
        sv.decelerationRate = .fast
    
        return sv
    }()
    
    
    
    
    lazy var profileTableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .blue
        tv.isScrollEnabled = false
        return tv
    }()
    

    
    
    func constrainScrollView(){
    scrollView.translatesAutoresizingMaskIntoConstraints = false
       scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
       scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
       scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    
    func constrainOtherView() {
        profileTableView.translatesAutoresizingMaskIntoConstraints = false
        profileTableView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        profileTableView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
//        otherView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0).isActive = true
        profileTableView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 200).isActive = true
        profileTableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    

    override func viewDidLoad() {
        view.addSubview(scrollView)
        scrollView.addSubview(profileTableView)
        profileTableView.delegate = self
        profileTableView.dataSource = self
        super.viewDidLoad()
        
       }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        constrainScrollView()
        constrainOtherView()
        self.scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height + profileTableView.frame.width )
    }

}


extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}
