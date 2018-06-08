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
@property(nonatomic,readwrite) NSLayoutConstraint* bubbleHeightAnchor;
@property(nonatomic,readwrite) NSLayoutConstraint* bubbleViewRightAnchor;
@property(nonatomic,readwrite) NSLayoutConstraint* bubbleViewLeftAnchor;
@property(nonatomic,readwrite) UIView* bubbleView;
@property(nonatomic,readwrite) UITextView* textView;
@property(nonatomic,readwrite) UIView* timeView;
@property(nonatomic,readwrite) UILabel* dateLabel;
@property(nonatomic,readwrite) NSLayoutConstraint* dateLabelwidthAnchor;
@property(nonatomic,readwrite) NSLayoutConstraint* dateLabelheightAnchor;
-(UIView*)makeBubbleView;
-(UITextView*)makeTextView;
-(UITextView*)makeTimeView;
-(UILabel*)makeLabel;
-(void)addlabel;
@end
