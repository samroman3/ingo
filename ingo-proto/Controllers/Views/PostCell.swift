//
//  PostTableViewCell.swift
//  ingo-proto
//
//  Created by Sam Roman on 12/11/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class PostCell: UICollectionViewCell {
    
    lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        label.text = "Testing Body Label"
        label.font = label.font.withSize(18)
        
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
    
    lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "send"), for: .normal)
        return button
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        button.showsTouchWhenHighlighted = true
        return button
    }()
    
   lazy var commentButton: UIButton = {
          let button = UIButton()
          button.setBackgroundImage(UIImage(named: "chat"), for: .normal)
          return button
      }()
    
    
    private func setUpCell(){
        constrainProfileImage()
        constrainBodyLabel()
        constrainLikeButton()
        contentView.addSoftUIEffectForView(cornerRadius: 25, themeColor: UIColor(red: 238, green: 238, blue: 238, alpha: 1))
        
    }
    
    
    private func constrainProfileImage(){
        contentView.addSubview(profileImage)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            profileImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2),
            profileImage.heightAnchor.constraint(equalToConstant: 50),
            profileImage.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    

    
    private func constrainBodyLabel(){
        contentView.addSubview(bodyLabel)
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            bodyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            bodyLabel.trailingAnchor.constraint(equalTo: profileImage.leadingAnchor, constant: 4)
            //            bodyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
    

    
    private func constrainLikeButton(){
        contentView.addSubview(likeButton)
        NSLayoutConstraint.activate([
            likeButton.heightAnchor.constraint(equalToConstant: 35),
            likeButton.widthAnchor.constraint(equalToConstant: 35),
            likeButton.trailingAnchor.constraint(equalTo: profileImage.trailingAnchor),
            likeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5 )])
    }
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCell()
        profileImage.layer.cornerRadius = 25
        profileImage.clipsToBounds = true
        profileImage.layer.borderWidth = 0.5
        profileImage.layer.borderColor = UIColor.white.cgColor
        contentView.backgroundColor = UIColor(red: 238, green: 238, blue: 238, alpha: 1)
        
    }
    
    
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
