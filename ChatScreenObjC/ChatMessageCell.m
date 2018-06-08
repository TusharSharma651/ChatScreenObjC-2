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
    tv.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1];
    tv.backgroundColor = [UIColor whiteColor];
    tv.layer.cornerRadius = 5;
    tv.layer.masksToBounds = YES;
    tv.textAlignment = NSTextAlignmentLeft;
    tv.translatesAutoresizingMaskIntoConstraints = false;
    tv.editable = NO;
    tv.scrollEnabled = NO;
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
    tv.textColor = [UIColor colorWithRed:0.69 green:0.69 blue:0.69 alpha:1];
    tv.backgroundColor = [UIColor clearColor];
    tv.layer.cornerRadius = 5;
    tv.layer.masksToBounds = YES;
    tv.translatesAutoresizingMaskIntoConstraints = false;
    tv.editable = NO;
    return tv;
}

-(UILabel *)makeLabel{
    UILabel *label = [[UILabel alloc] init];
    label.text = @"Today";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.translatesAutoresizingMaskIntoConstraints = false;
    return label;
}
-(void)addlabel{
    self.dateLabel = [self makeLabel];
    [self addSubview:self.dateLabel];
    [self.dateLabel.topAnchor constraintEqualToAnchor:self.bubbleView.bottomAnchor constant:0].active = YES;
    self.dateLabelwidthAnchor =  [self.dateLabel.widthAnchor constraintEqualToConstant:200];
    self.dateLabelwidthAnchor.active = YES;
    self.dateLabelheightAnchor = [self.dateLabel.heightAnchor constraintEqualToConstant:20];
    self.dateLabelheightAnchor.active = YES;
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor cyanColor];
        self.bubbleView = [self makeBubbleView];
        self.textView = [self makeTextView];
        self.timeView = [self makeTimeView];
        
        [self addSubview:self.bubbleView];
        [self addSubview:self.textView];
        [self addSubview:self.timeView];
        
        _bubbleViewRightAnchor = [self.bubbleView.rightAnchor constraintEqualToAnchor:self.rightAnchor];
        _bubbleViewRightAnchor.active = YES;
        _bubbleViewLeftAnchor = [self.bubbleView.leftAnchor constraintEqualToAnchor:self.leftAnchor];
        _bubbleViewLeftAnchor.active = NO;
        [self.bubbleView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
        _bubbleWidthAnchor = [self.bubbleView.widthAnchor constraintEqualToConstant:200];
        _bubbleWidthAnchor.active = YES;
        [self.bubbleView.heightAnchor constraintEqualToAnchor:self.heightAnchor].active = YES;
        
        [self.textView.leftAnchor constraintEqualToAnchor:self.bubbleView.leftAnchor constant:8].active = YES;
        [self.textView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
       // [self.textView.widthAnchor constraintEqualToConstant:200].active = NO;
        [self.textView.rightAnchor constraintEqualToAnchor:self.bubbleView.rightAnchor constant:-8].active = YES;
        [self.textView.heightAnchor constraintEqualToAnchor:self.heightAnchor].active = YES;
        [self.timeView.bottomAnchor constraintLessThanOrEqualToAnchor:self.bottomAnchor constant:-7].active = YES;
        [self.timeView.rightAnchor constraintLessThanOrEqualToAnchor:self.bubbleView.rightAnchor constant:-7].active = YES;
        [self.timeView.widthAnchor constraintEqualToConstant:50].active = YES;
        [self.timeView.heightAnchor constraintEqualToConstant:28].active = YES;
        
        
    }
    return self;
}



@end
