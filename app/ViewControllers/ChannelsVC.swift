//
//  TestVC.swift
//  xprojects-without-storyboard
//
//  Created by Максим Ефимов on 24.01.2018.
//  Copyright © 2018 Platforma. All rights reserved.
//

import UIKit
import Alamofire

class ChannelsVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    let commentCellIdentifier = "cardCellIdentifier"
    var collectionView: UICollectionView!
    var channels : [Channel] = []
    var loadingIndicator : UIActivityIndicatorView = {
        var view = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.startAnimating()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        Alamofire.request("http://pluma.me/chat").responseJSON{(response) in
            self.print(response.value)
            self.print(response.request?.url)
            let items = (response.value as! [[String: Any]])
            for item in items {
                let channel = Channel(url: item["url"] as! String, title: item["title"] as! String)
                self.channels.append(channel)
            }
            self.loadingIndicator.stopAnimating()
            self.collectionView.reloadData()
            /*
            let items = (response.value as! [String: Any])["comments"] as! [[String: Any]]
            for item in items {
                let userItem = item["user"] as! [String: Any]
                let user = User(id: userItem["id"] as! Int, first_name: userItem["first_name"] as? String, last_name: userItem["last_name"] as? String, username: userItem["username"] as? String, photo_url: userItem["photo_url"] as? String, sex: (userItem["sex"] as! String), age: userItem["age"] as? String, prof: "", about: userItem["info"] as? String)
                let comment = Comment(user: user, text: item["text"] as! String, date: item["date"] as! String)
                self.comments.append(comment)
                self.loadingIndicator.stopAnimating()
                self.collectionView.reloadData()
            }*/
        }
    }
    
    func setupViews(){
        
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
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.addSubview(loadingIndicator)
        
        loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        self.navigationItem.title = "Каналы"
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return channels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commentCellIdentifier, for: indexPath) as! CommentCell
        cell.name.text = channels[indexPath.row].title
        cell.name.font = .bold20
        cell.image.image = #imageLiteral(resourceName: "t_logo")
        cell.isUserInteractionEnabled = true
        cell.tag = indexPath.row
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userClickAction)))
        return cell
    }
    
    @objc func userClickAction(_ sender: UITapGestureRecognizer){
        UIApplication.shared.open(URL(string: channels[(sender.view?.tag)!].url)!, options: [:], completionHandler: nil)
    }
}
