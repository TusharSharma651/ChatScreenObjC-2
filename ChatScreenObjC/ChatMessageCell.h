//
//  ChatMessageCell.h
//  ChatScreenObjC
//
//  Created by Unoiatech on 18/05/18.
//  Copyright © 2018 Unoiatech. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 var bubbleWidthAnchor : NSLayoutConstraint?
 var bubbleViewRightAnchor : NSLayoutConstraint?
 var bubbleViewLeftAnchor: NSLayoutConstraint?*/
@interface ChatMessageCell : UICollectionViewCell
@property(nonatomic,readwrite) NSLayoutConstraint* bubbleWidthAnchor;
@property(nonatomic,readwrite) NSLayoutConstraint* bubbleViewRightAnchor;
@property(nonatomic,readwrite) NSLayoutConstraint* bubbleViewLeftAnchor;
-(UIView*)makeBubbleView;
-(UITextView*)makeTextView;
-(UITextView*)makeTimeView;

@end
