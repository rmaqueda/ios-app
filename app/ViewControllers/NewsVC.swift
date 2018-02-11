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
    var pullToRefresh : UIRefreshControl = {
        var view = UIRefreshControl()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        load()
    }
    
    @objc func load(){
        print("load")
        Alamofire.request("http://pluma.me/feed").responseJSON { (response) in
            self.posts.removeAll()
            self.loadingIndicator.stopAnimating()
            self.pullToRefresh.endRefreshing()
            if response.error != nil {
                return
            }
            if response.value == nil {
                return
            }
            let arr = response.value as! [[String: Any]]
            for item in arr {
                self.print(item)
                let post = Post(id: item["id"] as! Int, url: item["url"] as! String, imgUrl: item["img_url"] as? String, title: item["title"] as! String, comments: [])
                self.posts.append(post)
            }
            self.collectionView.reloadData()
        }
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
        collectionView.addSubview(pullToRefresh)
        pullToRefresh.addTarget(self, action: #selector(load), for: UIControlEvents.valueChanged)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(PostCell.self, forCellWithReuseIdentifier: cardCellIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        
        self.navigationItem.title = "Новости"
        
        view.addSubview(loadingIndicator)
        loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        let addButton = UIBarButtonItem(title: "Добавить", style: .plain, target: self, action: #selector(addButtonAction))
        navigationItem.rightBarButtonItem = addButton
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
        if posts[indexPath.row].imgUrl != nil && !posts[indexPath.row].imgUrl!.isEmpty {
            cell.image.load(posts[indexPath.row].imgUrl!)
        }
        else {
            cell.image.image = #imageLiteral(resourceName: "template")
        }
        return cell
    }
    
    @objc func addButtonAction(){
        print("addButtonAction")
        show(AddVC(), sender: self)
    }
    
    @objc func postClickAction(_ sender: UITapGestureRecognizer){
        show(PostVC(posts[(sender.view?.tag)!]), sender: self)
    }
}
