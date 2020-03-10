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
    
    var imageURL: String? = nil
    
    
    
    
    lazy var profileTableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .init(white: 0.1, alpha: 0.8)
        return tv
    }()
    
    
    lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .lightGray
        image.image = UIImage(systemName: "person")
        image.tintColor = .white
        return image
    }()
    lazy var userName: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.backgroundColor = .clear
        label.text = "TestUsername"
        return label
    }()
    lazy var totalPost: UILabel = {
        let label = UILabel()
        label.text = "0 \n Posts"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    lazy var logOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log Out", for: .normal)
        button.tintColor = .orange
        button.backgroundColor = .init(white: 0.4, alpha: 0.8)
        button.addTarget(self, action: #selector(editAction), for: .touchUpInside)
        return button
    }()
    
    
    

    @objc private func editAction(){
        let editVC = ProfileEditViewController()
        editVC.modalPresentationStyle = .fullScreen
        present(editVC, animated: true, completion: nil)
    }
    
    //MARK: Lifecycle Methods
    
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(true)
          setUpVC()
        profileImage.layer.cornerRadius = 75
              profileImage.clipsToBounds = true
              profileImage.layer.borderWidth = 3.0
              profileImage.layer.borderColor = UIColor.white.cgColor
      }
      
      override func viewDidLoad() {
          super.viewDidLoad()
          setUpVC()
        navigationController?.navigationBar.isHidden = true
          profileTableView.delegate = self
          profileTableView.dataSource = self
         }
    
    
    
    
    //MARK: Private Methods
    private func setUserName() {
           if let displayName = FirebaseAuthService.manager.currentUser?.displayName {
               userName.text = displayName
           }
       }
       private func setProfileImage() {
           if let pictureUrl = FirebaseAuthService.manager.currentUser?.photoURL {
               FirebaseStorageService.profileManager.getUserImage(photoUrl: pictureUrl) { (result) in
                   switch result {
                   case .failure(let error):
                       print(error)
                   case .success(let image):
                       self.profileImage.image = image
                   }
               }
           }
       }
    
    
    private func setUpVC(){
        setUpSubViews()
        constrainProfileTableView()
//        setUserName()
//        constrainLogOutButton()
    }
    
    private func setUpSubViews(){
        view.addSubview(profileTableView)
//        view.addSubview(profileImage)
//        view.addSubview(userName)
    }
   
    

//    private func constrainProfileImage(){
//           profileImage.translatesAutoresizingMaskIntoConstraints = false
//           NSLayoutConstraint.activate([
//               profileImage.leadingAnchor.constraint(equalTo: profileTableView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
//               profileImage.heightAnchor.constraint(equalToConstant: 150),
//               profileImage.widthAnchor.constraint(equalToConstant: 150),
//               profileImage.topAnchor.constraint(equalTo: profileTableView.topAnchor, constant: -175)
//
//           ])
//       }
//
       
    
//    private func constrainUserName(){
//           userName.translatesAutoresizingMaskIntoConstraints = false
//           NSLayoutConstraint.activate([
//               userName.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10),
//               userName.heightAnchor.constraint(equalToConstant: 30),
//               userName.topAnchor.constraint(equalTo: profileImage.topAnchor, constant: 25),
//               userName.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -10)
//           ])
//       }
//
//    private func constrainLogOutButton(){
//        view.addSubview(logOutButton)
//        logOutButton.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            logOutButton.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor, constant: 0),
//            logOutButton.heightAnchor.constraint(equalToConstant: 30),
//            logOutButton.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 5),
//            logOutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
//        ])
//    }
    
    

    func constrainProfileTableView() {
        profileTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileTableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
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
        return 140
    }
    
}
