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
        view.backgroundColor = .systemTeal
        setUpVC()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var currentLocation = CLLocationCoordinate2D.init(latitude: 40.6782, longitude: -73.9442) 

    private let locationManager = CLLocationManager()

    lazy var feedTableView: UITableView = {
          let tv = UITableView()
        tv.backgroundColor = .init(white: 0.8, alpha: 1)
          return tv
      }()
    
    lazy var menuButton: CircleMenu = {
        let menu = CircleMenu(frame: CGRect(x: 200, y: 200, width: 50, height: 50), normalIcon: "icon_menu", selectedIcon: "icon_close")
        menu.buttonsCount = 4
        menu.duration = 0.4
        menu.distance = 120
        menu.backgroundColor = .green
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
            menuButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            menuButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            menuButton.heightAnchor.constraint(equalToConstant: 50),
            menuButton.widthAnchor.constraint(equalToConstant: 50)])
    }

    
    private func setUpVC(){
//        constrainFeedTableView()
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
