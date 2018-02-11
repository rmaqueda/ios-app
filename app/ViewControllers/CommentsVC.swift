//
//  TestVC.swift
//  xprojects-without-storyboard
//
//  Created by Максим Ефимов on 24.01.2018.
//  Copyright © 2018 Platforma. All rights reserved.
//

import UIKit
import Alamofire

class CommentsVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    let commentCellIdentifier = "cardCellIdentifier"
    var collectionView: UICollectionView!
    var comments : [Comment] = []
    var postId : Int!
    var commentTextView : UITextView = {
        var view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.font = .medium18
        view.isScrollEnabled = false
        return view
    }()
    var sendButton : UIButton = {
        var button = UIButton(type: UIButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("отпр.", for: .normal)
        button.titleLabel?.font = .bold16
        return button
    }()
    var loadingIndicator : UIActivityIndicatorView = {
        var view = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.startAnimating()
        return view
    }()
    
    init(_ postId: Int ){
        self.postId = postId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        setupViews()
        
        Alamofire.request("http://pluma.me/post/" + String(describing: postId!)).responseJSON{(response) in
            self.print(response.value)
            self.print(response.request?.url)
            
            if response.value != nil {
                let items = (response.value as! [String: Any])["comments"] as! [[String: Any]]
                for item in items {
                    let userItem = item["user"] as! [String: Any]
                    let user = User(id: userItem["id"] as! Int, first_name: userItem["first_name"] as? String, last_name: userItem["last_name"] as? String, username: userItem["username"] as? String, photo_url: userItem["photo_url"] as? String, sex: (userItem["sex"] as! String), age: userItem["age"] as? String, prof: "", about: userItem["info"] as? String)
                    let comment = Comment(user: user, text: item["text"] as! String, date: item["date"] as! String)
                    self.comments.append(comment)
                    self.loadingIndicator.stopAnimating()
                    self.collectionView.reloadData()
                }
            }
        }
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setupViews(){
        self.hideKeyboardWhenTappedAround()
        view.addSubview(commentTextView)
        view.addSubview(sendButton)
        view.addSubview(loadingIndicator)
        sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        sendButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: commentTextView.centerYAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        sendButton.addTarget(self, action: #selector(sendButtonAction), for: .touchUpInside)
        
        commentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        commentTextView.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor).isActive = true
        commentTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionHeadersPinToVisibleBounds = true
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.minimumInteritemSpacing = 100
        layout.minimumLineSpacing = 10
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(CommonCell.self, forCellWithReuseIdentifier: commentCellIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: commentTextView.topAnchor).isActive = true
        
        self.navigationItem.title = "Комментарии"
    }
    
    @objc func sendButtonAction(){
        print("sendButtonAction")
        let params : Parameters = ["user_id": UserData.instance.user!.id, "post_id": postId, "text": commentTextView.text]
        Alamofire.request("http://pluma.me/comment", method: .put, parameters: params, encoding: URLEncoding.queryString).responseJSON { (response) in
            if response.error != nil {
                self.print(response.error!.localizedDescription)
                return
            }
            if response.value != nil {
                self.print(response.value!)
                self.print(response.request!.url ?? "")
                let comment = Comment(user: UserData.instance.user!, text: self.commentTextView.text, date: "now")
                self.comments.append(comment)
                self.collectionView.reloadData()
                self.commentTextView.text = ""
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return comments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commentCellIdentifier, for: indexPath) as! CommonCell
        cell.isUserInteractionEnabled = true
        cell.tag = indexPath.row
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userClickAction)))
        cell.subtitle.text = comments[indexPath.row].text
        cell.date.text = comments[indexPath.row].date
        cell.title.text = comments[indexPath.row].user.username
        cell.title.isUserInteractionEnabled = true
        cell.title.tag = indexPath.row
        cell.title.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userClickAction)))
        if comments[indexPath.row].user.photo_url != nil && !comments[indexPath.row].user.photo_url!.isEmpty {
            cell.image.load(comments[indexPath.row].user.photo_url!)
        }
        cell.image.isUserInteractionEnabled = true
        cell.image.tag = indexPath.row
        cell.image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userClickAction)))
        
        return cell
    }
    
    @objc func userClickAction(_ sender: UITapGestureRecognizer){
        show(UserVC(comments[(sender.view?.tag)!].user), sender: self)
    }
}
