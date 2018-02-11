//
//  TestVC.swift
//  xprojects-without-storyboard
//
//  Created by Максим Ефимов on 24.01.2018.
//  Copyright © 2018 Platforma. All rights reserved.
//

import UIKit
import Alamofire

class SearchVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UISearchBarDelegate {
    let commentCellIdentifier = "cardCellIdentifier"
    lazy var searchBar: UISearchBar = {
        var searchBar = UISearchBar(frame: CGRect(x:0,y: 0, width:300, height:20))
        searchBar.searchBarStyle = .minimal
        searchBar.showsCancelButton = true
        searchBar.enablesReturnKeyAutomatically = false
        return searchBar
    }()
    var pullToRefresh: UIRefreshControl = {
        var view = UIRefreshControl()
        return view
    }()
    var collectionView: UICollectionView!
    var users : [User] = []
    var loadingIndicator : UIActivityIndicatorView = {
        var view = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.startAnimating()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        searchBar.placeholder = "Поиск"
        searchBar.tintColor = .white
        searchBar.barTintColor = .white
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        leftNavBarButton.tintColor = .white
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        searchBar.delegate = self
        
        search("")
    }
    
    func setupViews(){
        //self.hideKeyboardWhenTappedAround()
        view.backgroundColor = .white
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.minimumInteritemSpacing = 100
        layout.minimumLineSpacing = 10
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        pullToRefresh.addTarget(self, action: #selector(pullToRefreshAction), for: UIControlEvents.valueChanged)
        collectionView.addSubview(pullToRefresh)
        collectionView.backgroundColor = .white
        
        collectionView.showsVerticalScrollIndicator = true
        collectionView.register(CommonCell.self, forCellWithReuseIdentifier: commentCellIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isUserInteractionEnabled = true
        view.addSubview(collectionView)
        
        view.addSubview(loadingIndicator)
        
        loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        self.navigationItem.title = "Поиск"
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commentCellIdentifier, for: indexPath) as! CommonCell
        let index = indexPath.row
        if users[index].photo_url != nil && !users[index].photo_url!.isEmpty {
            cell.image.load(users[index].photo_url!)
        }
        else {
            cell.image.image = #imageLiteral(resourceName: "template")
        }
        cell.title.font = .bold20
        cell.title.text = users[index].username
        cell.subtitle.text = (users[index].first_name ?? "") + " " + (users[index].last_name ?? "")
        cell.isUserInteractionEnabled = true
        cell.tag = index
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userClickAction)))
        return cell
    }
    
    @objc func pullToRefreshAction(){
        search("")
    }
    
    @objc func userClickAction(_ sender: UITapGestureRecognizer){
        show(UserVC(users[sender.view!.tag]), sender: self)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarSearchButtonClicked", searchBar.text)
        search(searchBar.text!)
    }
    
    func search(_ string: String){
        users.removeAll()
        collectionView.reloadData()
        loadingIndicator.startAnimating()
        let params : Parameters = ["q": string]
        Alamofire.request("http://pluma.me/user/search", parameters: params).responseJSON{(response) in
            self.print(response.value)
            if response.value != nil {
                let items = response.value as! [[String: Any]]
                for item in items {
                    let user = User(id: item["id"] as! Int, first_name: item["first_name"] as? String, last_name: item["last_name"] as? String, username: item["username"] as? String, photo_url: item["photo_url"] as? String, sex: item["sex"] as? String, age: item["age"] as? String, prof: "", about: item["info"] as? String)
                    self.users.append(user)
                }
            }
            self.collectionView.reloadData()
            self.loadingIndicator.stopAnimating()
            self.pullToRefresh.endRefreshing()
        }
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarSearchButtonClicked", searchBar.text)
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        print("selectedScopeButtonIndexDidChange", searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarCancelButtonClicked")
        searchBar.endEditing(true)
    }
    
}
