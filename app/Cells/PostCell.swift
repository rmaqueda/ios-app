//
//  Post.swift
//  app
//
//  Created by Максим Ефимов on 10.02.2018.
//  Copyright © 2018 Максим Ефимов. All rights reserved.
//

import UIKit

class PostCell : UICollectionViewCell {
    var cardView : UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    var image: UIImageView = {
        var view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor.lightGray
        view.layer.cornerRadius = 10
        return view
    }()
    
    var text: UITextView = {
        var view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isEditable = false
        view.isScrollEnabled = false
        view.backgroundColor = .clear
        view.textColor = .white
        view.textContainer.lineFragmentPadding = 0
        view.textContainerInset = .zero
        view.font = .bold18
        view.isSelectable = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cardView.shadow(elevation: 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupViews(){
        addSubview(cardView)
        cardView.addSubview(image)
        cardView.addSubview(text)
        
        cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        cardView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        cardView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        image.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
        image.topAnchor.constraint(equalTo: cardView.topAnchor).isActive = true
        image.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo: cardView.bottomAnchor).isActive = true
        
        text.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
        text.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -10).isActive = true
        text.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10).isActive = true
    }
}
