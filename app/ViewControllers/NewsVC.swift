//
//  TestVC.swift
//  xprojects-without-storyboard
//
//  Created by Максим Ефимов on 24.01.2018.
//  Copyright © 2018 Platforma. All rights reserved.
//

import UIKit
import Alamofire

class NewsVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    let cardCellIdentifier = "cardCellIdentifier"
    var collectionView: UICollectionView!
    var posts : [Post] = []
    var loadingIndicator: UIActivityIndicatorView = {
        var view = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.startAnimating()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        Alamofire.request("http://pluma.me/feed").responseJSON { (response) in
            if response.error != nil {
                return
            }
            if response.value == nil {
                return
            }
            let arr = response.value as! [[String: Any]]
            for item in arr {
                let post = Post(url: item["url"] as! String, imgUrl: item["img_url"] as? String, title: item["title"] as! String)
                self.posts.append(post)
                self.print(item)
                self.collectionView.reloadData()
                self.loadingIndicator.stopAnimating()
            }
        }
        //let parameters: Parameters = ["url": "http://telegra.ph/gosha-ili-geiorgiy-02-10", "user_id" : UserData.instance.user!.id]
        
        /*
        Alamofire.request("http://pluma.me/post?url=http://telegra.ph/gosha-ili-geiorgiy-02-10&user_id=" + String(describing: UserData.instance.user!.id!) , method: .put).responseJSON { (response) in
            self.print(response.value)
            self.print(response.request?.url)
        }
        */
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        collectionView.register(PostCell.self, forCellWithReuseIdentifier: cardCellIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        self.navigationItem.title = "News"
        
        view.addSubview(loadingIndicator)
        loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cardCellIdentifier, for: indexPath) as! PostCell
        cell.isUserInteractionEnabled = true
        cell.tag = indexPath.row
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(postClickAction)))
        cell.text.text = posts[indexPath.row].title
        return cell
    }
    
    @objc func postClickAction(_ sender: UITapGestureRecognizer){
        show(PostVC(posts[(sender.view?.tag)!]), sender: self)
    }
}
