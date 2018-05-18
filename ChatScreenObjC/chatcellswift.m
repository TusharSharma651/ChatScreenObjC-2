/*//
 //  ChatMessageCell.swift
 //  chatScreen
 //
 //  Created by Tushar on 03/04/18.
 //  Copyright © 2018 Tushar. All rights reserved.
 //
 
 import UIKit
 
 class ChatMessageCell: UICollectionViewCell {
 let textView : UITextView =
 {
 let tv = UITextView()
 tv.text = "SAMPLE TEXT"
 tv.font = UIFont.systemFont(ofSize: 20)
 tv.textColor = UIColor(red: 103/255, green: 103/255, blue: 103/255, alpha: 1)
 tv.backgroundColor = UIColor.white
 tv.layer.cornerRadius = 5
 tv.layer.masksToBounds = true
 tv.textAlignment = NSTextAlignment.left
 tv.translatesAutoresizingMaskIntoConstraints = false
 tv.isEditable = false
 return tv
 }()
 let bubbleView : UIView =
 {
 let view = UIView()
 view.translatesAutoresizingMaskIntoConstraints = false
 view.backgroundColor = UIColor.white
 view.layer.cornerRadius = 5
 view.layer.masksToBounds = true
 return view
 }()
 let timeView : UITextView =
 {
 let tv = UITextView()
 tv.text = "12:48"
 tv.font = UIFont.systemFont(ofSize: 15)
 tv.textColor = UIColor(red: 178/255, green: 178/255, blue: 178/255, alpha: 1)
 tv.backgroundColor = UIColor.clear
 tv.layer.cornerRadius = 5
 tv.layer.masksToBounds = true
 tv.translatesAutoresizingMaskIntoConstraints = false
 tv.isEditable = false
 return tv
 }()
 var bubbleWidthAnchor : NSLayoutConstraint?
 var bubbleViewRightAnchor : NSLayoutConstraint?
 var bubbleViewLeftAnchor: NSLayoutConstraint?
 
 override init(frame: CGRect) {
 super.init(frame: frame)
 
 addSubview(bubbleView)
 addSubview(textView)
 addSubview(timeView)
 bubbleViewRightAnchor = bubbleView.rightAnchor.constraint(equalTo: self.rightAnchor, constant : 0)
 bubbleViewRightAnchor?.isActive = true
 bubbleViewLeftAnchor = bubbleView.leftAnchor.constraint(equalTo: self.leftAnchor,constant : 0)
 bubbleViewLeftAnchor?.isActive = false
 bubbleView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
 bubbleWidthAnchor = bubbleView.widthAnchor.constraint(equalToConstant: 200)
 bubbleWidthAnchor?.isActive = true
 bubbleView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
 
 textView.leftAnchor.constraint(equalTo: bubbleView.leftAnchor,constant : 8).isActive = true
 textView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
 //textView.widthAnchor.constraint(equalToConstant: 200).isActive = true
 textView.rightAnchor.constraint(equalTo: bubbleView.rightAnchor,constant : -8).isActive = true
 textView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
 
 timeView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant : -7).isActive = true
 timeView.rightAnchor.constraint(equalTo: bubbleView.rightAnchor,constant : -7).isActive = true
 timeView.widthAnchor.constraint(equalToConstant: 50).isActive = true
 timeView.heightAnchor.constraint(equalToConstant: 28).isActive = true
 }
 
 required init?(coder aDecoder: NSCoder) {
 fatalError("init(coder:) has not been implemented")
 }
 }
*/
