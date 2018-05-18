//
//  ChatMessageCell.m
//  ChatScreenObjC
//
//  Created by Unoiatech on 18/05/18.
//  Copyright © 2018 Unoiatech. All rights reserved.
//

#import "ChatMessageCell.h"

@implementation ChatMessageCell

-(UITextView*)makeTextView
{
    UITextView *tv = [[UITextView alloc]init];
    tv.text = @"SAMPLE TEXT";
    tv.font = [UIFont systemFontOfSize:20];
    tv.textColor = [UIColor colorWithRed:103/255 green:103/255 blue:103/255 alpha:1];
    tv.backgroundColor = [UIColor whiteColor];
    tv.layer.cornerRadius = 5;
    tv.layer.masksToBounds = YES;
    tv.textAlignment = NSTextAlignmentLeft;
    tv.translatesAutoresizingMaskIntoConstraints = false;
    tv.editable = NO;
    return tv;
}
-(UIView*)makeBubbleView
{
    UIView  *bubbleView = [[UIView alloc]init];
    bubbleView.translatesAutoresizingMaskIntoConstraints = NO;
    bubbleView.backgroundColor = [UIColor whiteColor];
    bubbleView.layer.cornerRadius = 5;
    bubbleView.layer.masksToBounds = YES;
    return  bubbleView;
}
-(UITextView*)makeTimeView
{
    UITextView *tv = [[UITextView alloc]init];
    tv.text = @"12:48";
    tv.font = [UIFont systemFontOfSize:15];
    tv.textColor = [UIColor colorWithRed:178/255 green:178/255 blue:178/255 alpha:1];
    tv.backgroundColor = [UIColor clearColor];
    tv.layer.cornerRadius = 5;
    tv.layer.masksToBounds = YES;
    tv.translatesAutoresizingMaskIntoConstraints = false;
    tv.editable = NO;
    return tv;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *bubbleView = [self makeBubbleView];
        UITextView *textView = [self makeTextView];
        UIView *timeView = [self makeTimeView];
        
        [self addSubview:bubbleView];
        [self addSubview:textView];
        [self addSubview:timeView];
        _bubbleViewRightAnchor = [bubbleView.rightAnchor constraintEqualToAnchor:self.rightAnchor];
        _bubbleViewRightAnchor.active = YES;
        _bubbleViewLeftAnchor = [bubbleView.leftAnchor constraintEqualToAnchor:self.leftAnchor];
        _bubbleViewLeftAnchor.active = NO;
        [bubbleView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
        _bubbleWidthAnchor = [bubbleView.widthAnchor constraintEqualToConstant:200];
        _bubbleWidthAnchor.active = YES;
        [bubbleView.heightAnchor constraintEqualToAnchor:self.heightAnchor].active = YES;
        /*
         textView.leftAnchor.constraint(equalTo: bubbleView.leftAnchor,constant : 8).isActive = true
         textView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
         //textView.widthAnchor.constraint(equalToConstant: 200).isActive = true
         textView.rightAnchor.constraint(equalTo: bubbleView.rightAnchor,constant : -8).isActive = true
         textView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
         */
        [textView.leftAnchor constraintEqualToAnchor:bubbleView.leftAnchor constant:8].active = YES;
        [textView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
        [textView.widthAnchor constraintEqualToConstant:200].active = YES;
        [textView.rightAnchor constraintEqualToAnchor:bubbleView.rightAnchor constant:-8].active = YES;
        [textView.heightAnchor constraintEqualToAnchor:self.heightAnchor].active = YES;
        
        
        
        
    }
    return self;
}



@end
