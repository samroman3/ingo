//
//  UIViewController.swift
//  ingo-proto
//
//  Created by Sam Roman on 11/13/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit
import CoreLocation
import CircleMenu

class FeedViewController: UIViewController {

    override func viewDidLoad() {
        view.backgroundColor = .white
        setUpVC()
        locationAuthorization()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewWillLayoutSubviews() {
        menuButton.layer.cornerRadius = (menuButton.frame.size.width) / 2
        menuButton.clipsToBounds = true

    }
    
    var currentLocation = CLLocationCoordinate2D.init(latitude: 40.6782, longitude: -73.9442) 

    private let locationManager = CLLocationManager()

    lazy var feedTableView: UITableView = {
          let tv = UITableView()
          tv.backgroundColor = .init(white: 1, alpha: 1)
          return tv
      }()
    
    lazy var menuButton: CircleMenu = {
        let menu = CircleMenu(frame: CGRect(x: 200, y: 200, width: 50, height: 50), normalIcon: "cross", selectedIcon: "list" )
        
        menu.buttonsCount = 2
        menu.setBackgroundImage(UIImage(systemName: "plus"), for: .normal)
//        menu.setBackgroundImage(UIImage(systemName: "xmark"), for: .selected)
        menu.tintColor = .white
        menu.duration = 0.4
        menu.distance = 120
        menu.backgroundColor = .systemIndigo
        menu.delegate = self
        menu.showsTouchWhenHighlighted = true
        return menu
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
    
    private func constrainMenu(){
        view.addSubview(menuButton)
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            menuButton.heightAnchor.constraint(equalToConstant: 55),
            menuButton.widthAnchor.constraint(equalToConstant: 50)])
        menuButtonBottom.isActive = true
    }
    
    lazy var menuButtonBottom: NSLayoutConstraint = {
        self.menuButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    }()
    

    
    private func setUpVC(){
        constrainFeedTableView()
        constrainMenu()
        locationManager.delegate = self
    }
    
    private func locationAuthorization(){
           let status = CLLocationManager.authorizationStatus()
           
           switch status {
           case .authorizedAlways, .authorizedWhenInUse:
               locationManager.requestLocation()
               locationManager.startUpdatingLocation()
               locationManager.desiredAccuracy = kCLLocationAccuracyBest
           default:
               locationManager.requestWhenInUseAuthorization()
           }
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


extension FeedViewController: CLLocationManagerDelegate {
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("new locations \(locations)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("an error occurred: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("Authorization status changed to \(status.rawValue)")
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        //call a function to get current location
        default:
            break
        }
    }
}

extension FeedViewController: CircleMenuDelegate {
    
    func menuOpened(_ circleMenu: CircleMenu) {
        UIImageView.animate(withDuration: 0.3, animations: {
                self.menuButtonBottom.constant = -self.view.frame.height / 2
                self.view.layoutIfNeeded()
            }, completion: nil)
        
        }
    
    func menuCollapsed(_ circleMenu: CircleMenu) {
        UIImageView.animate(withDuration: 0.3, animations: {
            self.menuButtonBottom.constant = 0
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func circleMenu(_ circleMenu: CircleMenu, buttonDidSelected button: UIButton, atIndex: Int) {
        UIImageView.animate(withDuration: 0.5, animations: {
            self.menuButtonBottom.constant = 0
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        switch atIndex {
        case 0:
            let createVC = CreatePostViewController()
            createVC.modalPresentationStyle = .overCurrentContext
            createVC.currentLocation = self.currentLocation
            present(createVC, animated: true)
        case 1:
            return
        default:
            break
        }
    }
    
    func circleMenu(_ circleMenu: CircleMenu, willDisplay button: UIButton, atIndex: Int) {
        switch atIndex {
        case 0:
            button.backgroundColor = .systemGreen
            button.setImage(UIImage(systemName: "textformat.alt"), for: .normal)
            button.tintColor = .white
        case 1:
            return
        default:
            break
        }
    }
    
    }
    

