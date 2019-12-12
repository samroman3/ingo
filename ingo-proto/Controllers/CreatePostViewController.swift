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
    
    
    override func viewDidLoad() {
        view.backgroundColor = .init(white: 1, alpha: 1)
        setUpVC()
        super.viewDidLoad()
        
    }
    
    lazy var titleTextView: UITextView = {
    let tv = UITextView()
        tv.text = "Title..."
        tv.backgroundColor = .init(white: 0.8, alpha: 1)
        tv.delegate = self
        tv.tag = 0
        tv.isEditable = true
        return tv
    }()
    
    lazy var bodyTextView: UITextView = {
        let tv = UITextView()
        tv.text = "Body..."
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
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func createPostPressed(sender: UIButton) {
        guard bodyTextView.text != nil, bodyTextView.text != "" else { return }
        guard let user = FirebaseAuthService.manager.currentUser else { return }
        
        var title = ""
        
        if titleTextView.text != nil, titleTextView.text != "Title..." {
            title = titleTextView.text
        }
        
        let newPost = Post(title: title, body: bodyTextView.text! , creatorID: user.uid, text: nil, image: nil, lat: currentLocation.latitude, long: currentLocation.longitude, neighborhood: "")
        FirestoreService.manager.createPost(post: newPost) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success():
                print("created post")
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        
    }
    
    
    private func setUpVC(){
        constrainCreateButton()
        constraintTitle()
        constrainBody()
        constrainExitButton()
    }
    
    private func constraintTitle() {
        view.addSubview(titleTextView)
        titleTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleTextView.topAnchor.constraint(equalTo: createButton.bottomAnchor, constant: 5),
            titleTextView.widthAnchor.constraint(equalToConstant: view.frame.width),
            titleTextView.heightAnchor.constraint(equalToConstant: 70)])
    }
    
    private func constrainBody() {
           view.addSubview(bodyTextView)
           bodyTextView.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
            bodyTextView.topAnchor.constraint(equalTo: titleTextView.bottomAnchor, constant: 1),
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
        switch textView.tag {
        case 0:
            guard textView.text == "Title..." else {
                return
            }
            textView.text = ""
        case 1:
            guard textView.text == "Body..." else { return }
            textView.text = ""
        default:
            break
        }
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        guard bodyTextView.text != nil, bodyTextView.text != "" else {
        createButton.titleLabel?.textColor = .lightGray
        createButton.isEnabled = false
            return }
        createButton.titleLabel?.textColor = .white
        createButton.isEnabled = true
    }
}
