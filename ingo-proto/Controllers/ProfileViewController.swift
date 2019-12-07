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
        sv.backgroundColor = .white
        sv.showsVerticalScrollIndicator = true
        sv.decelerationRate = .fast
        
        return sv
    }()
    
    
    
    
    lazy var otherView: UIView = {
        let ov = UIView()
        ov.backgroundColor = .blue
        return ov
    }()
    
    
    
    
    func constrainScrollView(){
    scrollView.translatesAutoresizingMaskIntoConstraints = false
       scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
       scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
       scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    
//    func constrainOtherView() {
//        otherView.translatesAutoresizingMaskIntoConstraints = false
//        otherView.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        otherView.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        otherView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0).isActive = true
//        otherView.centerYAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: 900).isActive = true
//    }
    

    override func viewDidLoad() {
        view.addSubview(scrollView)
//        scrollView.addSubview(otherView)
        super.viewDidLoad()
        
       }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        constrainScrollView()
//        constrainOtherView()
        self.scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height + 500 )
    }

}
