//
//  CreatePostViewController.swift
//  ingo-proto
//
//  Created by Sam Roman on 12/11/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit
import CoreLocation

class CreatePostViewController: UIViewController {
    
    var currentLocation = CLLocationCoordinate2D()
    
    var neighborhood = ""
    
    override func viewDidLoad() {
        view.backgroundColor = .init(white: 1, alpha: 1)
        setUpVC()
        navigationController?.navigationBar.isHidden = true
        super.viewDidLoad()
        
    }
    
    lazy var bodyTextView: UITextView = {
        let tv = UITextView()
        tv.text = "New Post..."
        tv.backgroundColor = .init(white: 0.8, alpha: 1)
        tv.delegate = self
        tv.tag = 1
        tv.isEditable = true
        return tv
    }()
    
    lazy var createButton: UIButton = {
        let button = UIButton()
        button.setTitle("Post", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(18)
        button.isEnabled = false
        button.backgroundColor = .clear
        button.layer.cornerRadius = 10
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: #selector(createPostPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var exitButton: UIButton = {
       let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: #selector(exitButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    @objc func exitButtonPressed(sender: UIButton) {
        navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func createPostPressed(sender: UIButton) {
        
        guard bodyTextView.text != nil, bodyTextView.text != "", bodyTextView.text != "New Post..." else { return }
        guard let user = FirebaseAuthService.manager.currentUser else { return }

        let newPost = Post(body: bodyTextView.text! , creatorID: user.uid, lat: currentLocation.latitude, long: currentLocation.longitude, neighborhood: neighborhood, likes: 0, dislikes: 0)
        FirestoreService.manager.createPost(post: newPost) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success():
                print("created post")
                self.navigationController?.popViewController(animated: true)
//                self.dismiss(animated: true, completion: nil)
            }
        }
        
        
    }
    
    
    private func setUpVC(){
        constrainCreateButton()
        constrainBody()
        constrainExitButton()
    }
    
   
    
    private func constrainBody() {
           view.addSubview(bodyTextView)
           bodyTextView.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
            bodyTextView.topAnchor.constraint(equalTo: createButton.bottomAnchor, constant: 5),
               bodyTextView.widthAnchor.constraint(equalToConstant: view.frame.width),
               bodyTextView.heightAnchor.constraint(equalToConstant: view.frame.height / 3)])
       }
    
    private func constrainCreateButton(){
        view.addSubview(createButton)
        createButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            createButton.heightAnchor.constraint(equalToConstant: 45),
            createButton.widthAnchor.constraint(equalToConstant: 50)])
    }
    
    private func constrainExitButton(){
        view.addSubview(exitButton)
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            exitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            exitButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            exitButton.bottomAnchor.constraint(equalTo: createButton.bottomAnchor),
            exitButton.heightAnchor.constraint(equalToConstant: 25),
            exitButton.widthAnchor.constraint(equalToConstant: 20)])
    }
       
    
    

}


extension CreatePostViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
      guard textView.text == "New Post..." else { return }
        textView.text = ""

    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        guard bodyTextView.text != nil, bodyTextView.text != "" else {
        createButton.titleLabel?.textColor = .lightGray
        createButton.isEnabled = false
            return }
        createButton.titleLabel?.textColor = .black
        createButton.isEnabled = true
    }
}
