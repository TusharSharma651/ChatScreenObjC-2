//
//  ChatLogController.swift
//  chatScreen
//
//  Created by Tushar on 03/04/18.
//  Copyright © 2018 Tushar. All rights reserved.
//
/*
import  UIKit
class ChatLogController : UICollectionViewController, UITextViewDelegate, UICollectionViewDelegateFlowLayout {
    var messagesRecieve = ["I am willing to offer you help for the errands you are wanting to have worked on","YES","p"]
    var messagesSend = ["Hi","Hello","Go man","Let's Go","I am willing to offer you help for the errands you are wanting"]
    //    var messagesRecieve = [String]()
    //    var messagesSend = [String]()
    var sendMesssagesCompleted = false
    var keyBoardCount = 0
    var newArr: [String]!
    var sendCounter = 0
    var originalHeight: CGFloat?
    var originalWidth: CGFloat?
    var heightBeforeBecomingActive: CGFloat?
    var widthBeforeBecomingActive: CGFloat?
    var containerViewBottomAnchor : NSLayoutConstraint?
    var containerViewHeightAnchor : NSLayoutConstraint?
    var originalKeyBoardHeight : CGFloat?
    let inputTextView : UITextView =
    {
        let textView = UITextView()
        //textView.    enter text = "    enter text"
        textView.layer.borderColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1).cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 6
        textView.text = "   enter text"
        textView.textColor = UIColor.lightGray
        textView.font = UIFont.systemFont(ofSize: 16)
        let linelimit = 3
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = true
        return textView
    }()
    
    let cellid = "cellid"
    override func viewDidLoad() {
        super.viewDidLoad()
        newArr = messagesRecieve + messagesSend
        collectionView?.contentInset = UIEdgeInsets(top: 80, left: 0, bottom: 58, right: 0)
        // collectionView?.keyboardDismissMode = .interactive
        collectionView?.backgroundColor = UIColor(red: 242/255, green: 241/255, blue: 241/255, alpha: 1)
        //collectionView?.backgroundColor = UIColor.gray
        collectionView?.register(ChatMessageCell.self, forCellWithReuseIdentifier: cellid)
        collectionView?.alwaysBounceVertical = true
        setUpInputComponents()
        setUpKeyBoardObservers()
    }
    override func viewDidAppear(_ animated: Bool) {
        originalHeight = inputTextView.frame.size.height
        originalWidth = inputTextView.frame.size.width
        
        heightBeforeBecomingActive = inputTextView.frame.size.height
        widthBeforeBecomingActive = inputTextView.frame.size.width
        print("############")
        print(originalHeight)
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        inputTextView.frame.size.height = heightBeforeBecomingActive!
        inputTextView.frame.size.width = widthBeforeBecomingActive!
        if inputTextView.textColor == UIColor.lightGray {
            inputTextView.text = nil
            inputTextView.textColor = UIColor.black
        }
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if inputTextView.text.isEmpty {
            inputTextView.text = "    enter text"
            inputTextView.textColor = UIColor.lightGray
            //inputTextView.b
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            //save the current height of text view , so after becoming active again it regains it's original height
            heightBeforeBecomingActive = inputTextView.frame.size.height
            widthBeforeBecomingActive = inputTextView.frame.size.width
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    func textViewDidChange(_ textView: UITextView) {
        
        print(inputTextView.frame.size.height)
        var olderHeight = inputTextView.frame.size.height
        if inputTextView.frame.size.height < 73.5
        {
            let fixedWidth = inputTextView.frame.size.width
            inputTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            let newSize = inputTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            var newFrame = inputTextView.frame
            newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
            inputTextView.frame = newFrame
            if (newFrame.size.height - olderHeight) == 19
            {
                print("Height Changed")
                
                containerViewHeightAnchor?.constant = (containerViewHeightAnchor?.constant)! + 19
            }
        }
    }
    func setUpKeyBoardObservers()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyBoardDidShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyBoardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyBoardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        
    }
    @objc func handleKeyBoardDidShow(notification : Notification)
    {
        if !newArr.isEmpty
        {
            
            let keyboardDuration  = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey]
            
            UIView.animate(withDuration: keyboardDuration as! TimeInterval, animations: {
                self.collectionView?.scrollToItem(at: IndexPath(item: self.newArr.count - 1, section: 0), at: UICollectionViewScrollPosition.top, animated: true)
                
            })
        }
    }
    @objc func handleKeyBoardWillShow(notification : Notification)
    {
        
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            let keyboardDuration  = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey]
            
            if keyBoardCount == 0
            {
                containerViewBottomAnchor?.constant = -(keyboardHeight)
                originalKeyBoardHeight = keyboardHeight //containerView should be lifted by same height every time...Without it there is issue in iphone 7
            }
            else
            {
                containerViewBottomAnchor?.constant = -(originalKeyBoardHeight!)
            }
            UIView.animate(withDuration: keyboardDuration as! TimeInterval, animations: {
                self.view.layoutIfNeeded()
            })
            
        }
        
        keyBoardCount = 1
        
    }
    @objc func handleKeyBoardWillHide(notification : NSNotification)
    {
        containerViewBottomAnchor?.constant = 0
        let keyboardDuration  = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey]
        UIView.animate(withDuration: keyboardDuration as! TimeInterval, animations: {
            self.view.layoutIfNeeded()
        })
        
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        newArr = messagesRecieve + messagesSend
        return newArr.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as! ChatMessageCell
        newArr  = messagesRecieve + messagesSend
        cell.bubbleWidthAnchor?.constant = estimateFrameForText(text: newArr[indexPath.item]).width + 80
        cell.backgroundColor = UIColor.clear
        var message: String!
        
        message = newArr[indexPath.item]
        
        cell.textView.text = message
        var isSend : Bool = false
        if indexPath.item >= messagesRecieve.count
        {
            isSend = true
        }
        setUpCell(cell: cell,message: message, isSend: isSend)
        return cell
    }
    private func setUpCell(cell: ChatMessageCell, message: String, isSend: Bool)
    {
        if !isSend
        {
            cell.bubbleViewLeftAnchor?.isActive = true
            cell.bubbleViewRightAnchor?.isActive = false
            
        }
        else
        {
            cell.bubbleViewLeftAnchor?.isActive = false
            cell.bubbleViewRightAnchor?.isActive = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let text = newArr[indexPath.item]
        var height = estimateFrameForText(text: text).height + 40
        return CGSize(width: view.frame.width, height: height)
    }
    private func estimateFrameForText(text: String) -> CGRect
    {
        
        let size = CGSize(width: self.view.frame.size.width * 0.7, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 20)], context: nil)
    }
    
    func setUpInputComponents()
    {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerViewBottomAnchor = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        containerViewBottomAnchor?.isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containerViewHeightAnchor =  containerView.heightAnchor.constraint(equalToConstant: 50)
        containerViewHeightAnchor?.isActive = true
        
        let sendButton = UIButton(type: UIButtonType.system)
        sendButton.setTitle("Send", for: UIControlState.normal)
        sendButton.setTitleColor(UIColor.gray, for: UIControlState.normal)
        sendButton.addTarget(self, action: #selector(handleSend), for: UIControlEvents.touchUpInside)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(sendButton)
        sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        sendButton.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        containerView.addSubview(inputTextView)
        
        inputTextView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant : 10).isActive = true
        inputTextView.rightAnchor.constraint(equalTo: sendButton.leftAnchor, constant : 10).isActive = true
        inputTextView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        inputTextView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
        inputTextView.delegate = self
        originalHeight = inputTextView.frame.size.height
        originalWidth = inputTextView.frame.size.width
        
        let separatorLineView = UIView()
        separatorLineView.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        separatorLineView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(separatorLineView)
        separatorLineView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        separatorLineView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        separatorLineView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        separatorLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    //    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    //        if (text as NSString).rangeOfCharacter(from: CharacterSet.newlines).location == NSNotFound {
    //            return true
    //        }
    //        inputTextView.resignFirstResponder()
    //        return false
    //    }
    
    
    @objc  func handleSend()
    {
        
        if !(inputTextView.text?.isEmpty)!
        {
            messagesSend.append(inputTextView.text!)
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
                let indexPath = IndexPath(item: self.newArr.count, section: 0)
                self.collectionView?.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.bottom, animated: true)
                
            }
            inputTextView.text = nil
            inputTextView.frame.size = CGSize(width: originalWidth!, height: originalHeight!)
            containerViewHeightAnchor?.constant = 50
        }
    }
    
    }
*/
