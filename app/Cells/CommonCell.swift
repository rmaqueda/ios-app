//
//  CommonCell.swift
//  app
//
//  Created by Максим Ефимов on 11.02.2018.
//  Copyright © 2018 Максим Ефимов. All rights reserved.
//

import UIKit

class CommonCell : UICollectionViewCell {
    var image: UIImageView = {
        var view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    var title: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .bold14
        view.textColor = .black
        return view
    }()
    
    var subtitle: UITextView = {
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
        addSubview(subtitle)
        addSubview(date)
        addSubview(title)
        
        image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        image.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        image.heightAnchor.constraint(equalToConstant: 48).isActive = true
        image.widthAnchor.constraint(equalToConstant: 48).isActive = true
        
        title.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8).isActive = true
        title.topAnchor.constraint(equalTo: image.topAnchor, constant: 2).isActive = true
        
        subtitle.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 5).isActive = true
        subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4).isActive = true
        
        date.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        date.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
    }
}
