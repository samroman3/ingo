//
//  PostTableViewCell.swift
//  ingo-proto
//
//  Created by Sam Roman on 12/11/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
         let label = UILabel()
           label.textAlignment = .left
           label.textColor = .black
           label.numberOfLines = 2
           label.text = "Testing Title Label"
           return label
       }()

       lazy var bodyLabel: UILabel = {
         let label = UILabel()
           label.textAlignment = .left
           label.textColor = .black
           label.numberOfLines = 0
           label.text = "Testing Body Label"

           return label
       }()
       
    
    private func setUpCell(){
       constrainTitleLabel()
       constrainBodyLabel()
    }
    
    
    private func constrainTitleLabel(){
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 40)])
    }
    
    private func constrainBodyLabel(){
        contentView.addSubview(bodyLabel)
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 2),
            bodyLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            bodyLabel.heightAnchor.constraint(equalToConstant: bodyLabel.frame.height)])
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
           contentView.backgroundColor = .white

        }
       required init(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
    

}
