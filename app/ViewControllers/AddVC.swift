//
//  AddVC.swift
//  app
//
//  Created by Максим Ефимов on 11.02.2018.
//  Copyright © 2018 Максим Ефимов. All rights reserved.
//

import UIKit
import Alamofire

class AddVC : UIViewController {
    var label : UILabel = {
        var label = UILabel()
        label.font = .medium14
        label.textColor = .lightGray
        label.text = "Ссылка"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var urlInput : UITextView = {
        var view = UITextView()
        view.textColor = .black
        view.keyboardType = .URL
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .bold18
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    var addButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Добавить", for: .normal)
        button.titleLabel?.font = .bold18
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func setupViews(){
        self.hideKeyboardWhenTappedAround()
        view.backgroundColor = .white
        view.addSubview(label)
        view.addSubview(urlInput)
        view.addSubview(addButton)
        
        urlInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        urlInput.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 40).isActive = true
        urlInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        urlInput.heightAnchor.constraint(greaterThanOrEqualToConstant: 25).isActive = true
        
        label.bottomAnchor.constraint(equalTo: urlInput.topAnchor, constant: -8).isActive = true
        label.leadingAnchor.constraint(equalTo: urlInput.leadingAnchor).isActive = true
        
        addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addButton.bottomAnchor.constraint(equalTo: view.safeBottomAnchor,constant: -10).isActive = true
        
        addButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y = 0
        }
    }
    
    @objc func addButtonAction(){
        let url = urlInput.text!
        if url.contains("telegra.ph") {
            let parameters: Parameters = ["url": url, "user_id" : UserData.instance.user!.id]
            
            Alamofire.request("http://pluma.me/post", method: .put, parameters: parameters, encoding: URLEncoding.queryString).responseJSON { (response) in
                self.print(response.value)
                self.print(response.request?.url)
            }
        }
    }
}
