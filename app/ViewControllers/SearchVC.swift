//
//  UserVC.swift
//  app
//
//  Created by Максим Ефимов on 10.02.2018.
//  Copyright © 2018 Максим Ефимов. All rights reserved.
//

import UIKit

class SearchVC : UIViewController {
    var user : User!
    
    var photoView : UIImageView = {
        var view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.load("https://imgix.ranker.com/user_node_img/50036/1000707993/original/we-both-want-the-same-thing-photo-u1?w=650&q=50&fm=jpg&fit=crop&crop=faces")
        return view
    }()
    var nameLabel : UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.font = .medium15
        return view
    }()
    var username : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .bold20
        return label
    }()
    var statusLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .bold16
        return label
    }()
    var descriptionLabel: UITextView = {
        var label = UITextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.backgroundColor = .clear
        label.font = .medium15
        label.isEditable = false
        label.isScrollEnabled = false
        label.textContainer.lineFragmentPadding = 0
        label.textContainerInset = .zero
        return label
    }()
    var writeButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("edit", comment: ""), for: .normal)
        button.isUserInteractionEnabled = true
        button.titleLabel?.font = .bold16
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.setImage(#imageLiteral(resourceName: "t_logo"), for: .normal)
        return button
    }()
    
    var isSelfProfile : Bool {
        return self.user.id == UserData.instance.user?.id
    }
    
    init(_ user: User){
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("isSelfProfile:", isSelfProfile)
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        photoView.makeCircle()
        writeButton.makeCircle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupViews(){
        self.navigationItem.title = "User"
        view.backgroundColor = .white
        
        view.addSubview(photoView)
        view.addSubview(username)
        //view.addSubview(nameLabel)
        //view.addSubview(writeButton)
        //addSubview(statusLabel)
        //addSubview(descriptionLabel)
        //addSubview(actionButton)
        
        
        photoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        photoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        photoView.widthAnchor.constraint(equalToConstant: 64).isActive = true
        photoView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        username.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: 15).isActive = true
        username.topAnchor.constraint(equalTo: photoView.topAnchor, constant: 4).isActive = true
        /*
         nameLabel.topAnchor.constraint(equalTo: username.bottomAnchor, constant: 8).isActive = true
         nameLabel.leadingAnchor.constraint(equalTo: username.leadingAnchor).isActive = true
         
         writeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
         writeButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
         writeButton.widthAnchor.constraint(equalToConstant: 48).isActive = true
         writeButton.centerYAnchor.constraint(equalTo: photoView.centerYAnchor).isActive = true*/
    }
    
    @objc func userTapAction(){
        print("userTapAction")
        //show(UserVC(profile), sender: self)
    }
    
    @objc func recordButtonAction(){
        print("record button action")
    }
    
    @objc func writeButtonAction(){
        print("writeButtonAction")
        if user.username != nil {
            UIApplication.shared.open(URL(string: ("https://telegram.me/" + user.username!))!, options: [:], completionHandler: nil)
        }
    }
}

