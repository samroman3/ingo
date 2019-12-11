//
//  UIViewController.swift
//  ingo-proto
//
//  Created by Sam Roman on 11/13/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    override func viewDidLoad() {
        view.backgroundColor = .systemTeal
        setUpVC()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    lazy var feedTableView: UITableView = {
          let tv = UITableView()
        tv.backgroundColor = .init(white: 0.8, alpha: 1)
          return tv
      }()
      

    
    private func constrainFeedTableView() {
        view.addSubview(feedTableView)
        feedTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        feedTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            feedTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            feedTableView.widthAnchor.constraint(equalToConstant: view.frame.width),
            feedTableView.heightAnchor.constraint(equalToConstant: view.frame.height)
        ])
       
    }

    
    private func setUpVC(){
        constrainFeedTableView()
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
