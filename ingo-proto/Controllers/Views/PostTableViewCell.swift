//
//  PostTableViewCell.swift
//  ingo-proto
//
//  Created by Sam Roman on 12/11/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    lazy var usernameLabel: UILabel = {
         let label = UILabel()
           label.textAlignment = .left
           label.textColor = .black
           label.numberOfLines = 0
           label.text = "usernameLabel"
        label.font = label.font.withSize(15)
           return label
       }()

       lazy var bodyLabel: UILabel = {
         let label = UILabel()
           label.textAlignment = .left
           label.textColor = .black
           label.numberOfLines = 0
           label.text = "Testing Body Label"
         label.font = label.font.withSize(13)

           return label
       }()
       

     lazy var profileImage: UIImageView = {
           let image = UIImageView()
           image.backgroundColor = .lightGray
           image.image = UIImage(systemName: "person")
           image.tintColor = .white
           return image
       }()
    
    lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.text = "Likes:"
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        label.font = label.font.withSize(12)
        return label
    }()
    
//    lazy var dislikesLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Down:"
//        label.textAlignment = .left
//        label.textColor = .black
//        label.numberOfLines = 0
//        label.font = label.font.withSize(12)
//        return label
//    }()
    
    
    private func setUpCell(){
       constrainProfileImage()
       constrainUserLabel()
       constrainBodyLabel()
        constrainLikesLabel()
        
    }
    
    private func constrainProfileImage(){
        contentView.addSubview(profileImage)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            profileImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
            profileImage.heightAnchor.constraint(equalToConstant: 40),
            profileImage.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
   
    private func constrainUserLabel(){
        contentView.addSubview(usernameLabel)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: profileImage.topAnchor, constant: 0),
            usernameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 5),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)])
    }
    
    private func constrainBodyLabel(){
        contentView.addSubview(bodyLabel)
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 0),
            bodyLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor, constant: 0),
            bodyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50)
//            bodyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
    
    private func constrainLikesLabel(){
        contentView.addSubview(likesLabel)
        likesLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
               likesLabel.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 5),
//               likesLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor, constant: 145),
               likesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
               likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
               likesLabel.heightAnchor.constraint(equalToConstant: 30)
               ])
    }
    
 

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCell()
        profileImage.layer.cornerRadius = 20
        profileImage.clipsToBounds = true
        profileImage.layer.borderWidth = 0.5
        profileImage.layer.borderColor = UIColor.white.cgColor
        contentView.backgroundColor = .white

        }
       required init(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
    

}
