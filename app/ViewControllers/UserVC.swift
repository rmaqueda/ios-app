//
//  UserVC.swift
//  app
//
//  Created by Максим Ефимов on 10.02.2018.
//  Copyright © 2018 Максим Ефимов. All rights reserved.
//

import UIKit

class UserVC: UIViewController {
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
    var sexLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .bold16
        label.text = "Пол:"
        return label
    }()
    var ageLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .bold16
        label.text = "Возраст:"
        return label
    }()
    var profLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .bold16
        label.text = "Специализация:"
        return label
    }()
    var aboutLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .bold16
        label.text = "О себе:"
        return label
    }()
    var writeButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("edit", comment: ""), for: .normal)
        button.isUserInteractionEnabled = true
        button.titleLabel?.font = .bold16
        button.setImage(#imageLiteral(resourceName: "t_logo"), for: .normal)
        return button
    }()
    var editButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Редактировать", for: .normal)
        button.titleLabel?.font = .bold16
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.titleLabel?.textColor = .black
        button.setTitleColor(.black, for: .normal)
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
        username.text = user.username
        nameLabel.text = user.first_name! + " " + user.last_name!
        
        sexLabel.text! += " " + (user.sex == nil ? "" : user.sex!)
        ageLabel.text! += " " + (user.age == nil ? "" : user.age!)
        profLabel.text! += " " + (user.prof == nil ? "" : user.prof!)
        aboutLabel.text! += " " + (user.about == nil ? "" : user.about!)
        
        editButton.addTarget(self, action: #selector(editButtonAction), for: .touchUpInside)
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        photoView.makeCircle()
        editButton.makeCircle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupViews(){
        self.navigationItem.title = "Профиль"
        view.backgroundColor = .white
        
        view.addSubview(photoView)
        view.addSubview(username)
        view.addSubview(nameLabel)
        view.addSubview(writeButton)
        view.addSubview(editButton)
        view.addSubview(sexLabel)
        view.addSubview(ageLabel)
        view.addSubview(profLabel)
        view.addSubview(aboutLabel)
        
        photoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        photoView.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 10).isActive = true
        photoView.widthAnchor.constraint(equalToConstant: 64).isActive = true
        photoView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        username.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: 15).isActive = true
        username.topAnchor.constraint(equalTo: photoView.topAnchor, constant: 4).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: username.bottomAnchor, constant: 8).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: username.leadingAnchor).isActive = true
        
        writeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        writeButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        writeButton.widthAnchor.constraint(equalToConstant: 48).isActive = true
        writeButton.centerYAnchor.constraint(equalTo: photoView.centerYAnchor).isActive = true
        
        editButton.leadingAnchor.constraint(equalTo: photoView.leadingAnchor).isActive = true
        editButton.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 15).isActive = true
        editButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        sexLabel.leadingAnchor.constraint(equalTo: editButton.leadingAnchor).isActive = true
        sexLabel.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 20).isActive = true
        
        ageLabel.leadingAnchor.constraint(equalTo: sexLabel.leadingAnchor).isActive = true
        ageLabel.topAnchor.constraint(equalTo: sexLabel.bottomAnchor, constant: 10).isActive = true
        
        profLabel.leadingAnchor.constraint(equalTo: ageLabel.leadingAnchor).isActive = true
        profLabel.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 10).isActive = true
        
        aboutLabel.leadingAnchor.constraint(equalTo: profLabel.leadingAnchor).isActive = true
        aboutLabel.topAnchor.constraint(equalTo: profLabel.bottomAnchor, constant: 10).isActive = true
    }
    
    @objc func userTapAction(){
        print("userTapAction")
        //show(UserVC(profile), sender: self)
    }
    
    @objc func editButtonAction(){
        print("editButtonAction")
        self.present(UserEditVC(), animated: true, completion: nil)
    }
    
    @objc func writeButtonAction(){
        print("writeButtonAction")
        if user.username != nil {
            UIApplication.shared.open(URL(string: ("https://telegram.me/" + user.username!))!, options: [:], completionHandler: nil)
        }
    }
}
