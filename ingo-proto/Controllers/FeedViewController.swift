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
    
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpVC()
        locationAuthorization()
        setNeighborhood()
       
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        setNeighborhood()
    }
    
    
    override func viewWillLayoutSubviews() {
        menuButton.layer.cornerRadius = (menuButton.frame.size.width) / 2
        menuButton.clipsToBounds = true
        self.feedTableView.estimatedRowHeight = 180
               self.feedTableView.rowHeight = UITableView.automaticDimension
               self.feedTableView.setNeedsLayout()
               self.feedTableView.layoutIfNeeded()
               self.feedTableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        setNeighborhood()
        
    }
    
    
    //MARK: Private Properties
    private var currentLocation = CLLocationCoordinate2D.init(latitude: 40.756523, longitude: -73.974152) {
        didSet {
            setNeighborhood()
        }
    }
    
    private let locationManager = CLLocationManager()
    
    var posts = [Post]() {
        didSet {
            self.feedTableView.reloadData()
        }
    }
    
    var dataForLocation: LocationData? {
        didSet {
            
            navigationItem.title = dataForLocation?.address?.neighbourhood
            self.neighborhood = (dataForLocation?.address?.neighbourhood)!
            getPostsForLocation(neighborhood: neighborhood)
        }
    }
    
    var neighborhood = ""
    
    
   
    
    
    
     //MARK: Private Methods
    
    private func getAllPosts() {
        FirestoreService.manager.getAllPosts() { (result) in
            DispatchQueue.main.async {
            switch result {
            case .failure(let error):
                print(error)
            case .success(let postsFromFirebase):
                    self.posts = postsFromFirebase
                }
            }
        }
    }
    
    private func getPostsForLocation(neighborhood: String){
        FirestoreService.manager.getPostsForNeighborhood(location: neighborhood) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let postsFromLocation):
                    self.posts = postsFromLocation
                    self.feedTableView.reloadData()
                }
            }
        }
    }
    
    private func setNeighborhood(){
        LocationAPIClient.shared.getLocationDataFrom(lat: currentLocation.latitude, long: currentLocation.longitude) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    self.dataForLocation = data
                }
            }
        }
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
    
    
    private func setUpVC(){
        constrainFeedTableView()
        constrainMenu()
        constrainTopCollectionView()
        topCollectionView.delegate = self
        topCollectionView.dataSource = self
        self.locationManager.delegate = self
        view.backgroundColor = .init(white: 0.2, alpha: 0.8)
        self.feedTableView.register(PostTableViewCell.self, forCellReuseIdentifier: "FeedCell")
       
        
    }
    
    
    //MARK: UI Elements
    
    lazy var feedTableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .clear
        return tv
    }()
    
    lazy var topCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.isScrollEnabled = true
        cv.showsHorizontalScrollIndicator = true
        cv.register(TopCollectionViewCell.self, forCellWithReuseIdentifier: "topCell")
        return cv
    }()
    
    lazy var menuButton: CircleMenu = {
        let menu = CircleMenu(frame: CGRect(x: 200, y: 200, width: 50, height: 50), normalIcon: "cross", selectedIcon: "list" )
        
        menu.buttonsCount = 2
        menu.setBackgroundImage(UIImage(systemName: "line.horizontal.3.decrease.circle"), for: .normal)

        //        menu.setBackgroundImage(UIImage(systemName: "xmark"), for: .selected)
        menu.tintColor = .white
        menu.duration = 0.4
        menu.distance = 120
        menu.backgroundColor = .systemPurple
        menu.delegate = self
        menu.showsTouchWhenHighlighted = true
        return menu
    }()
    
    
    
    //MARK: Constraint Methods
    private func constrainFeedTableView() {
        view.addSubview(feedTableView)
        feedTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            feedTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            feedTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            feedTableView.widthAnchor.constraint(equalToConstant: view.frame.width),
            feedTableView.heightAnchor.constraint(equalToConstant: view.frame.height)
        ])
        
    }
    
    
    
    private func constrainMenu(){
        view.addSubview(menuButton)
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuButtonTrailing,
            menuButton.heightAnchor.constraint(equalToConstant: 50),
            menuButton.widthAnchor.constraint(equalToConstant: 50)])
        menuButtonBottom.isActive = true
    }
    
    lazy var menuButtonBottom: NSLayoutConstraint = {
        self.menuButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    }()
    
    lazy var menuButtonTrailing: NSLayoutConstraint = {
        self.menuButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 4)
    }()
    
    
    private func constrainTopCollectionView(){
        view.addSubview(topCollectionView)
        topCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 2),
            topCollectionView.bottomAnchor.constraint(equalTo: feedTableView.topAnchor, constant: -2),
            topCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
    }
    
    
    
}
    
    
   



    //MARK: TableView Extension
extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
       }

       // Set the spacing between sections
       func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
       }

       // Make the background color show through
       func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           let headerView = UIView()
           headerView.backgroundColor = UIColor.clear
           return headerView
       }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! PostTableViewCell
        let post = posts[indexPath.section]
        cell.bodyLabel.text = post.body
        
        //sets username in postcell
        FirestoreService.manager.getUserFromPost(creatorID: post.creatorID) { (result) in
          DispatchQueue.main.async {
            switch result {
            case .failure(let error):
                print(error)
              return
            case .success(let user):
                cell.usernameLabel.text = user.userName!
                FirebaseStorageService.profileManager.getUserImage(photoUrl: URL(string: user.photoURL!)!) { (result) in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let image):
                    cell.profileImage.image = image
                }
                }
            }
        }
          }
        
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 150
//    }
//
}

    //MARK: LocationManager Delegate
extension FeedViewController: CLLocationManagerDelegate {
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("new locations \(locations)")
        self.currentLocation = locations[0].coordinate
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



    //MARK: CircleMenu Delegate
extension FeedViewController: CircleMenuDelegate {
    
    //Logout function
    func logout(){
    let alert = UIAlertController(title: "Log Out?", message: nil, preferredStyle: .alert)
           let action = UIAlertAction.init(title: "Yup!", style: .destructive, handler: .some({ (action) in
                DispatchQueue.main.async {
                          FirebaseAuthService.manager.logOut { (result) in
                          }
                          guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                              let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window
                              else {
                                  return
                          }
                          UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromBottom, animations: {
                              window.rootViewController = LoginViewController()
                          }, completion: nil)
                      }
           }))
           let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
           alert.addAction(action)
           alert.addAction(cancel)
           present(alert, animated:true)
    }
    
    func menuOpened(_ circleMenu: CircleMenu) {
        UIImageView.animate(withDuration: 0.3, animations: {
            self.menuButtonBottom.constant = -self.view.frame.height / 3
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
            createVC.neighborhood = (dataForLocation?.address?.neighbourhood)!
            let nav = navigationController
            nav?.pushViewController(createVC, animated: true)
//            present(createVC, animated: true)
        case 1:
            logout()
        default:
            break
        }
    }
    
    func circleMenu(_ circleMenu: CircleMenu, willDisplay button: UIButton, atIndex: Int) {
        switch atIndex {
        case 0:
            button.backgroundColor = .systemPurple
            button.setBackgroundImage(UIImage(systemName: "pencil.circle"), for: .normal)
            button.tintColor = .white
            button.showsTouchWhenHighlighted = true
        case 1:
        button.showsTouchWhenHighlighted = true
        button.setBackgroundImage(UIImage(systemName: "gear"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemRed
        default:
            break
        }
    }
    
}


//MARK: CollectionView Extension

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topCell", for: indexPath) as! TopCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 150)
    }
}


