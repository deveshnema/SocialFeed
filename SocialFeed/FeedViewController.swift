//
//  ViewController.swift
//  SocialFeed
//
//  Created by Devesh Nema on 5/20/18.
//  Copyright © 2018 Devesh Nema. All rights reserved.
//

import UIKit

let cellid = "cellid"

class FeedViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Social Feed"
        collectionView?.backgroundColor = UIColor.lightGray
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellid)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 400)
    }
}

//MARK:- FeedCell
class FeedCell : UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        //Name
        let attributedText = NSMutableAttributedString(string: "Batman", attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 14)])
        
        //Location label
        attributedText.append(NSAttributedString(string: "\nMay 20. Gotham City. ", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12), NSAttributedStringKey.foregroundColor : UIColor.lightGray]))
        
        //Shared-with icon
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "globe")
        attachment.bounds = CGRect(x: 0, y: 0, width: 12, height: 12)
        attributedText.append(NSAttributedString(attachment: attachment))
        
        //Paragraph Style
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        
        attributedText.addAttributes([NSAttributedStringKey.paragraphStyle : paragraphStyle], range: NSRange(location: 0, length: attributedText.string.count))
        
        label.attributedText = attributedText
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor(red: 222/255, green: 222/255, blue: 222/255, alpha: 1)
        imageView.image = UIImage(named: "batman")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let statusTextView : UITextView = {
        let textView = UITextView()
        textView.text = "Hi, this is batman"
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let statusImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "batman_status")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let likeCommentLabel : UILabel = {
        let label = UILabel()
        label.text = "12.8K Likes  45K Comments"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let separatorView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let buttonsView : UIStackView = {
        let view = UIStackView()
        view.alignment = .center
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let likeButton : UIButton = {
        let button = UIButton()
        button.setTitle("Like", for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0)
        button.setImage(UIImage(named: "like"), for: .normal)
        return button
    }()
    
    let shareButton : UIButton = {
        let button = UIButton()
        button.setTitle("Share", for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0)
        button.setImage(UIImage(named: "share"), for: .normal)
        return button
    }()
    
    let commentButton : UIButton = {
        let button = UIButton()
        button.setTitle("Comment", for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0)
        button.setImage(UIImage(named: "comment"), for: .normal)
        return button
    }()
    
    func setupViews() {
        backgroundColor = UIColor.yellow
        addSubview(nameLabel)
        addSubview(profileImageView)
        addSubview(statusTextView)
        addSubview(statusImageView)
        addSubview(likeCommentLabel)
        addSubview(separatorView)
        addSubview(buttonsView)
        
        buttonsView.addArrangedSubview(likeButton)
        buttonsView.addArrangedSubview(commentButton)
        buttonsView.addArrangedSubview(shareButton)
        

        //Constraints for profileImageView
        profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        profileImageView.trailingAnchor.constraint(equalTo: nameLabel.leadingAnchor, constant: -8).isActive = true
        profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true

        //Constraints for nameLabel
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        
        //Constraints for statusTextView
        statusTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        statusTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        statusTextView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 4).isActive = true
        statusTextView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        //Constraints for statusImageView
        statusImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        statusImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        statusImageView.topAnchor.constraint(equalTo: statusTextView.bottomAnchor, constant: 4).isActive = true

        //Constraints for likeCommentLabel
        likeCommentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12).isActive = true
        likeCommentLabel.topAnchor.constraint(equalTo: statusImageView.bottomAnchor, constant: 8).isActive = true
        likeCommentLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

        //Constraints for separatorView
        separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        separatorView.topAnchor.constraint(equalTo: likeCommentLabel.bottomAnchor, constant: 8).isActive = true

        //Constraints for buttonsView
        buttonsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        buttonsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        buttonsView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        buttonsView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 8).isActive = true
        buttonsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        
    }
    
}


























