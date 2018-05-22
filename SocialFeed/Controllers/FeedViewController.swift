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

    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Social Feed"
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellid)
        setupData()
    }
    
    func setupData() {
        let batmanPost = Post(name: "Batman", imageName: "batman", statusText: "It's not who I am underneath, but what I do that defines me.", date: "May 20", location: "Gotham City", statusImageName: "batman_status", likes: "14.8K", comments: "263K")
         let ironmanPost = Post(name: "Iron Man", imageName: "ironman", statusText: "I know that it's confusing. It is one thing to question the official story, and another thing entirely to make wild accusations, or insinuate that I'm a superhero. \n\nMy armor was never a distraction or a hobby, it was a cocoon, and now I'm a changed man. You can take away my house, all my tricks and toys, but one thing you can't take away - I am Iron Man. \n\nAgent’s ready. Save the world. Yadda, yadda. We need to go help Black Widow.", date: "Apr 6", location: "New  City", statusImageName: "ironman_status", likes: "12.1K", comments: "419K")
        let supermanPost = Post(name: "Superman", imageName: "superman", statusText: "Hi, this is Superman", date: "Feb 3", location: "Old City", statusImageName: "superman_status", likes: "50.2K", comments: "663K")
        posts = [batmanPost, ironmanPost, supermanPost]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as! FeedCell
        cell.post = posts[indexPath.item]
        cell.feedVC = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let statusText = posts[indexPath.item].statusText {
            let rect = NSString(string: statusText).boundingRect(with: CGSize(width: view.frame.width, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)], context: nil)
            let otherCellsHeightsAndSpacings : CGFloat = 8 + 44 + 12 + 4 + 200 + 4 + 8 + 20 + 8 + 30 + 8 + 8
            let padding : CGFloat = 16
            return CGSize(width: view.frame.width, height: rect.height + otherCellsHeightsAndSpacings + padding)
        }
        return CGSize(width: view.frame.width, height: 500)
    }
    
    let blackBackgroundView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        return view
    }()
    
    let zoomImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var statusImageView : UIImageView?
    
    
    func zoomInStatusImageView(statusImageView : UIImageView) {
        self.statusImageView = statusImageView
        if let startingFrame = statusImageView.superview?.convert(statusImageView.frame, to: nil) {
            statusImageView.alpha = 0
            
            blackBackgroundView.frame = view.frame
            blackBackgroundView.alpha = 0
            view.addSubview(blackBackgroundView)
            
            zoomImageView.image = statusImageView.image
            zoomImageView.frame = startingFrame
            view.addSubview(zoomImageView)
            
            zoomImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoomOutStatusImageView)))
            
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.curveEaseOut, animations: {
                let height = (self.view.frame.width / startingFrame.width) * startingFrame.height
                let y = self.view.frame.height/2 - height/2
                self.zoomImageView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: height)
                self.blackBackgroundView.alpha = 1
            }, completion: nil)
        }
    }
    
    @objc func zoomOutStatusImageView() {
        if let startingFrame = statusImageView!.superview?.convert(statusImageView!.frame, to: nil) {
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.zoomImageView.frame = startingFrame
                self.blackBackgroundView.alpha = 0
            }, completion: { (didComplete) -> Void in
                self.zoomImageView.removeFromSuperview()
                self.blackBackgroundView.removeFromSuperview()
                self.statusImageView?.alpha = 1
            })
        }
    }
}

//MARK:- FeedCell
class FeedCell : UICollectionViewCell {
    var feedVC : FeedViewController?
    
    var post : Post? {
        didSet {
            let attributedText = NSMutableAttributedString(string: "")
            if let name = post?.name, let date = post?.date, let location = post?.location {
                attributedText.append(NSMutableAttributedString(string: name, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 14)]))
                //Location label
                attributedText.append(NSAttributedString(string: "\n\(date). \(location). ", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12), NSAttributedStringKey.foregroundColor : UIColor.lightGray]))
                
                //Shared-with icon
                let attachment = NSTextAttachment()
                attachment.image = UIImage(named: "globe")
                attachment.bounds = CGRect(x: 0, y: 0, width: 12, height: 12)
                attributedText.append(NSAttributedString(attachment: attachment))
                
                //Paragraph Style
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 4
                
                attributedText.addAttributes([NSAttributedStringKey.paragraphStyle : paragraphStyle], range: NSRange(location: 0, length: attributedText.string.count))
                
                nameLabel.attributedText = attributedText
            }
            
            if let imageName = post?.imageName {
                profileImageView.image = UIImage(named: imageName)
            }
            
            if let likes = post?.likes, let comments = post?.comments {
                likeCommentLabel.text = "\(likes) Likes   \(comments) Comments"
            }
            
            if let statusText = post?.statusText {
                statusTextView.text =  statusText
            }
            
            if let statusImageName = post?.statusImageName {
                statusImageView.image = UIImage(named: statusImageName)
            }
            
        }
    }
    
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
        imageView.isUserInteractionEnabled = true
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
    
    @objc func zoomInStatusImageView() {
        feedVC?.zoomInStatusImageView(statusImageView: statusImageView)
    }
    
    func setupViews() {
        backgroundColor = UIColor.white
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
        

        statusImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoomInStatusImageView)))
        
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
        
        //Constraints for statusImageView
        statusImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        statusImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        statusImageView.heightAnchor.constraint(equalToConstant: 200)
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


























