//
//  UserVC.swift
//  app
//
//  Created by Максим Ефимов on 10.02.2018.
//  Copyright © 2018 Максим Ефимов. All rights reserved.
//

import UIKit

class UserEditVC: UIViewController {
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
    
    var saveButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Сохранить", for: .normal)
        button.titleLabel?.font = .bold16
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.titleLabel?.textColor = .black
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        saveButton.makeCircle()
    }
    
    func setupViews(){
        self.navigationItem.title = "Редактирование"
        view.backgroundColor = .white
        
        view.addSubview(sexLabel)
        view.addSubview(ageLabel)
        view.addSubview(profLabel)
        view.addSubview(aboutLabel)
        view.addSubview(saveButton)
        
        sexLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20).isActive = true
        sexLabel.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 20).isActive = true
        
        ageLabel.leadingAnchor.constraint(equalTo: sexLabel.leadingAnchor).isActive = true
        ageLabel.topAnchor.constraint(equalTo: sexLabel.bottomAnchor, constant: 10).isActive = true
        
        profLabel.leadingAnchor.constraint(equalTo: ageLabel.leadingAnchor).isActive = true
        profLabel.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 10).isActive = true
        
        aboutLabel.leadingAnchor.constraint(equalTo: profLabel.leadingAnchor).isActive = true
        aboutLabel.topAnchor.constraint(equalTo: profLabel.bottomAnchor, constant: 10).isActive = true
        
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: -20).isActive = true
        saveButton.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
    }
    
    
    @objc func saveButtonAction(){
        print("saveButtonAction")
        self.dismiss(animated: true, completion: nil)
    }
}

