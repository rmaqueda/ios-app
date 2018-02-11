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
        //button.setTitleColor(.black, for: .normal)
        //button.backgroundColor = .clear
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
            
            let items = (response.value as! [String: Any])["comments"] as! [[String: Any]]
            for item in items {
                let comment = Comment(user_id: item["user_id"] as! Int, text: item["text"] as! String, date: item["date"] as! String)
                self.comments.append(comment)
                self.loadingIndicator.stopAnimating()
                self.collectionView.reloadData()
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
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: commentCellIdentifier)
        
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
                let comment = Comment(user_id: (UserData.instance.user?.id)!, text: self.commentTextView.text, date: "now")
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commentCellIdentifier, for: indexPath) as! CommentCell
        cell.isUserInteractionEnabled = true
        cell.tag = indexPath.row
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(commentClickAction)))
        cell.text.text = comments[indexPath.row].text
        cell.date.text = comments[indexPath.row].date
        cell.name.text = String(comments[indexPath.row].user_id)
        //cell.text.text = comments[indexPath.row].title
        return cell
    }
    
    @objc func commentClickAction(_ sender: UITapGestureRecognizer){
    }
}

class CommentCell : UICollectionViewCell {
    var image: UIImageView = {
        var view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    var name: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .bold14
        view.textColor = .black
        return view
    }()
    
    var text: UITextView = {
        var view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isEditable = false
        view.isScrollEnabled = false
        view.backgroundColor = .clear
        view.textColor = .gray
        view.textContainer.lineFragmentPadding = 0
        view.textContainerInset = .zero
        view.font = .medium16
        view.isSelectable = false
        return view
    }()
    
    var date: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .medium12
        view.textColor = .lightGray
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        image.makeCircle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupViews(){
        addSubview(image)
        addSubview(text)
        addSubview(date)
        addSubview(name)
        
        image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        image.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        image.heightAnchor.constraint(equalToConstant: 48).isActive = true
        image.widthAnchor.constraint(equalToConstant: 48).isActive = true
        
        name.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8).isActive = true
        name.topAnchor.constraint(equalTo: image.topAnchor, constant: 2).isActive = true
        
        text.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8).isActive = true
        text.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 4).isActive = true
        
        date.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        date.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        /*
         moreButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
         moreButton.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -10).isActive = true
         
         unlikeButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -14).isActive = true
         unlikeButton.bottomAnchor.constraint(equalTo: moreButton.bottomAnchor).isActive = true
         
         likeButton.trailingAnchor.constraint(equalTo: unlikeButton.leadingAnchor, constant: -10).isActive = true
         likeButton.bottomAnchor.constraint(equalTo: unlikeButton.bottomAnchor).isActive = true
         
         recordButton.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
         recordButton.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor).isActive = true
         recordButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
         
         separator.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
         separator.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
         separator.bottomAnchor.constraint(equalTo: moreButton.topAnchor, constant: -13).isActive = true
         separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
         
         timeLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -14).isActive = true
         timeLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 14).isActive = true
         
         photoView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12).isActive = true
         photoView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 12).isActive = true
         photoView.widthAnchor.constraint(equalToConstant: 32).isActive = true
         photoView.heightAnchor.constraint(equalToConstant: 32).isActive = true
         
         nameLabel.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: 10).isActive = true
         nameLabel.centerYAnchor.constraint(equalTo: photoView.centerYAnchor).isActive = true
         
         label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
         label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
         label.centerYAnchor.constraint(equalTo: cardView.centerYAnchor).isActive = true
         label.topAnchor.constraint(equalTo: photoView.bottomAnchor).isActive = true
         */
    }
}
