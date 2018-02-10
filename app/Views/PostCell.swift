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
    /*
     var moreButton : UIButton = {
     var button = UIButton(type: .system)
     button.translatesAutoresizingMaskIntoConstraints = false
     button.tintColor = .harmony2
     button.setImage(#imageLiteral(resourceName: "more"), for: .normal)
     return button
     }()
     var likeButton : UIButton = {
     var button = UIButton(type: .system)
     button.translatesAutoresizingMaskIntoConstraints = false
     button.tintColor = .harmony2
     button.setImage(#imageLiteral(resourceName: "like_line"), for: .normal)
     return button
     }()
     var unlikeButton : UIButton = {
     var button = UIButton(type: .system)
     button.translatesAutoresizingMaskIntoConstraints = false
     button.tintColor = .harmony2
     button.setImage(#imageLiteral(resourceName: "unlike_line"), for: .normal)
     return button
     }()
     var recordButton : UIButton = {
     var button = UIButton(type: .system)
     button.translatesAutoresizingMaskIntoConstraints = false
     button.tintColor = .color1
     button.titleLabel?.font = .demiBold14
     button.setTitle(NSLocalizedString("record", comment: ""), for: .normal)
     button.layer.borderColor = UIColor.color1.cgColor
     button.layer.borderWidth = 1.5
     return button
     }()
     var separator : UIView = {
     var view = UIView()
     view.translatesAutoresizingMaskIntoConstraints = false
     view.backgroundColor = .harmony1
     return view
     }()
     var timeLabel : UILabel = {
     var label = UILabel()
     label.translatesAutoresizingMaskIntoConstraints = false
     label.font = .medium15
     label.text = "1 m ago"
     label.textColor = .harmony3
     return label
     }()
     var photoView : UIImageView = {
     var view = UIImageView()
     view.translatesAutoresizingMaskIntoConstraints = false
     view.load("https://vignette.wikia.nocookie.net/animated/images/f/fc/Kakashi_Hatake.jpg/revision/latest?cb=20130807024734")
     return view
     }()
     var nameLabel : UILabel = {
     var label = UILabel()
     label.translatesAutoresizingMaskIntoConstraints = false
     label.text = "Ololo"
     label.font = .medium20
     label.textColor = .harmony5
     return label
     }()
     var label : UILabel = {
     var label = UILabel()
     label.translatesAutoresizingMaskIntoConstraints = false
     label.font = .medium20
     label.textColor = .harmony5
     label.textAlignment = .center
     label.text = "asjdf jlksa jfkljsa klf"
     return label
     }()*/
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cardView.shadow(elevation: 2)
        
        //recordButton.makeCircle()
        //photoView.makeCircle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupViews(){
        addSubview(cardView)
        cardView.addSubview(image)
        cardView.addSubview(text)
        /*cardView.addSubview(moreButton)
         cardView.addSubview(likeButton)
         cardView.addSubview(unlikeButton)
         cardView.addSubview(recordButton)
         cardView.addSubview(separator)
         cardView.addSubview(timeLabel)
         cardView.addSubview(photoView)
         cardView.addSubview(nameLabel)
         cardView.addSubview(label)*/
        
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
