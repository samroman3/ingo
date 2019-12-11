//
//  UIViewController.swift
//  ingo-proto
//
//  Created by Sam Roman on 11/13/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit
import CoreLocation

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
