//
//  UserVC.swift
//  app
//
//  Created by Максим Ефимов on 10.02.2018.
//  Copyright © 2018 Максим Ефимов. All rights reserved.
//

import UIKit

class UserVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    let profileCellIdentifier = "profileCellIdentifier"
    let cardCellIdentifier = "cardCellIdentifier"
    
    let arr =
        [
            "1",
            "2",
            "3",
            "4",
            "5",
            "6",
            "7",
            "8",
            "9",
            "10",
            "11",
            "12",
            ]
    var user : User!
    
    var isSelfProfile : Bool {
        return self.user.id == UserData.instance.user?.id
    }
    
    var collectionView: UICollectionView!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupViews(){
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionHeadersPinToVisibleBounds = true
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 5
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: profileCellIdentifier)
        collectionView.register(PostCell.self, forCellWithReuseIdentifier: cardCellIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        self.navigationItem.title = "User"
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if section == 0 {
            return 1
        }
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: UIScreen.main.bounds.width, height: 250)
        }
        return CGSize(width: UIScreen.main.bounds.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        if indexPath.section == 0 {
            let profileCell = collectionView.dequeueReusableCell(withReuseIdentifier: profileCellIdentifier, for: indexPath) as? ProfileCell
            
            profileCell?.nameLabel.text = user.first_name! + " " + user.last_name!
            profileCell?.username.text = user.username
            profileCell?.statusLabel.text = "asdf asd fasd ffd"
            profileCell?.descriptionLabel.text = "asdfasdfafasd f fd fdfdfdf "
            
            
            if !isSelfProfile {
                profileCell?.writeButton.setTitle(NSLocalizedString("follow", comment: ""), for: .normal)
            }
            else {
                profileCell?.writeButton.addTarget(self, action: #selector(writeButtonAction), for: .touchUpInside)
            }
            return profileCell!
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cardCellIdentifier, for: indexPath) as! PostCell
        
        return cell
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

class ProfileCell : UICollectionViewCell {
    var background : UIImageView = {
        var view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.load("http://wallpaperswide.com/download/apple_mac_os_x_mavericks-wallpaper-960x540.jpg")
        return view
    }()
    
    var photoView : UIImageView = {
        var view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.load("https://imgix.ranker.com/user_node_img/50036/1000707993/original/we-both-want-the-same-thing-photo-u1?w=650&q=50&fm=jpg&fit=crop&crop=faces")
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    var nameLabel : UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.font = .medium15
        return view
    }()
    var username : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .bold20
        return label
    }()
    var statusLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .bold16
        return label
    }()
    var descriptionLabel: UITextView = {
        var label = UITextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoView.makeCircle()
        writeButton.makeCircle()
    }
    
    func setupViews(){
        addSubview(background)
        addSubview(photoView)
        addSubview(username)
        addSubview(nameLabel)
        addSubview(writeButton)
        //addSubview(statusLabel)
        //addSubview(descriptionLabel)
        //addSubview(actionButton)
        
        background.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        background.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        background.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        photoView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        photoView.topAnchor.constraint(equalTo: self.topAnchor, constant: 25).isActive = true
        photoView.widthAnchor.constraint(equalToConstant: 64).isActive = true
        photoView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        username.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: 15).isActive = true
        username.topAnchor.constraint(equalTo: photoView.topAnchor, constant: 4).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: username.bottomAnchor, constant: 8).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: username.leadingAnchor).isActive = true
        
        writeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        writeButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        writeButton.widthAnchor.constraint(equalToConstant: 48).isActive = true
        writeButton.centerYAnchor.constraint(equalTo: photoView.centerYAnchor).isActive = true
        
        /*
        statusLabel.leadingAnchor.constraint(equalTo: username.leadingAnchor).isActive = true
        statusLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -4).isActive = true
        
        descriptionLabel.leadingAnchor.constraint(equalTo: statusLabel.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
        actionButton.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor, constant: -3).isActive = true
        actionButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        actionButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
 */
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
