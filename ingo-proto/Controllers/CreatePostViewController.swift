//
//  CreatePostViewController.swift
//  ingo-proto
//
//  Created by Sam Roman on 12/11/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class CreatePostViewController: UIViewController {

    override func viewDidLoad() {
        view.backgroundColor = .init(white: 1.0, alpha: 1)
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
        button.setTitle("Create", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemIndigo
        button.layer.cornerRadius = 10
        button.showsTouchWhenHighlighted = true
        
        return button
    }()
    
    @objc func createPostPressed(sender: UIButton) {
        guard bodyTextView.text != nil, bodyTextView.text != "" else { return }
        
    }
    
    
    private func setUpVC(){
        constrainCreateButton()
        constraintTitle()
        constrainBody()
    }
    
    private func constraintTitle() {
        view.addSubview(titleTextView)
        titleTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleTextView.topAnchor.constraint(equalTo: createButton.bottomAnchor),
            titleTextView.widthAnchor.constraint(equalToConstant: view.frame.width),
            titleTextView.heightAnchor.constraint(equalToConstant: 70)])
    }
    
    private func constrainBody() {
           view.addSubview(bodyTextView)
           bodyTextView.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               bodyTextView.topAnchor.constraint(equalTo: titleTextView.bottomAnchor),
               bodyTextView.widthAnchor.constraint(equalToConstant: view.frame.width),
               bodyTextView.heightAnchor.constraint(equalToConstant: view.frame.height / 3)])
       }
    
    private func constrainCreateButton(){
        view.addSubview(createButton)
        createButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 5),
            createButton.heightAnchor.constraint(equalToConstant: 45),
            createButton.widthAnchor.constraint(equalToConstant: 100)])
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
}
