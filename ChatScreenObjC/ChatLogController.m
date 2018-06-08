//
//  ChatLogController.m
//  ChatScreenObjC
//
//  Created by Unoiatech on 17/05/18.
//  Copyright © 2018 Unoiatech. All rights reserved.
//

#import "ChatLogController.h"
#import "ChatMessageCell.h"
@interface ChatLogController ()<UICollectionViewDelegateFlowLayout, UITextViewDelegate>
@property(nonatomic, readwrite) NSMutableArray *messagesRecieve;
@property(nonatomic, readwrite) NSMutableArray *messagesSend;
@property(nonatomic, readwrite) NSMutableArray *messages;
@property(nonatomic,readwrite) int keyBoardCount;
@property(nonatomic,readwrite) NSMutableArray *newarr;
@property(nonatomic,readwrite) CGFloat originalHeight;
@property(nonatomic,readwrite) CGFloat originalWidth;
@property(nonatomic,readwrite) CGFloat heightBeforeBecomingActive;
@property(nonatomic,readwrite) CGFloat widthBeforeBecomingActive;
@property(nonatomic,readwrite) NSLayoutConstraint *containerViewBottomAnchor;
@property(nonatomic,readwrite) NSLayoutConstraint *containerViewHeightAnchor;
@property(nonatomic,readwrite) CGFloat originalKeyBoardHeight;
@property(nonatomic,readwrite) UITextView* inputTextView;
@property(nonatomic,readwrite) UIButton* blockedMessageButton;
@property(nonatomic,readwrite) BOOL isUserBlocked;

-(void) handleSend;
@end

@implementation ChatLogController
static NSString * const reuseIdentifier = @"cellid";

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Chat LOg COntroller");
    _keyBoardCount = 0;
    _messagesRecieve = [[NSMutableArray alloc ] initWithObjects:@"I am willing to offer you help  on",@"YES",@"p", nil];
    _messagesSend = [[NSMutableArray alloc] initWithObjects: @"Hi",@"Hello",@"Go man",@"Let's Go",@"I are wanting", nil];
    _newarr = [[NSMutableArray alloc] init];
    for (int i=0,j=0,k=0; i<_messagesSend.count + _messagesRecieve.count; i++) {
        if (i<_messagesRecieve.count) {
            [_newarr addObject:_messagesRecieve[j]];
            j++;
        }
        else
        {
            [_newarr addObject:_messagesSend[k]];
            k++;
        }
    }
    NSLog(@"count = %d",_newarr.count);
    for (int i=0; i<_newarr.count; i++) {
        NSLog(_newarr[i]);
    }
    self.isUserBlocked = NO;
    self.collectionView.contentInset = UIEdgeInsetsMake(80,0, 58, 0);
    self.collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    self.collectionView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
    
    self.collectionView.alwaysBounceVertical = YES;
    
    [self.collectionView registerClass:[ ChatMessageCell class] forCellWithReuseIdentifier:reuseIdentifier];
    if (!_isUserBlocked) {
        [self setUpInputComponents];
        [self setUpKeyBoardObservers];
    }
    else
    {
        [self setUpBlockedView];
    }
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    self.originalHeight = self.inputTextView.frame.size.height;
    self.originalWidth = self.inputTextView.frame.size.width;
    self.heightBeforeBecomingActive = self.inputTextView.frame.size.height;
    self.widthBeforeBecomingActive = self.inputTextView.frame.size.width;
    
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    
    CGRect originalFrame = self.inputTextView.frame;
    [self.inputTextView setFrame:CGRectMake(originalFrame.origin.x, originalFrame.origin.y, self.widthBeforeBecomingActive, self.heightBeforeBecomingActive)];
    CGRect demoFrame = CGRectMake(0, 0, _widthBeforeBecomingActive, _heightBeforeBecomingActive);
    if (self.inputTextView.textColor  == [UIColor lightGrayColor]) {
        self.inputTextView.text = nil;
        self.inputTextView.textColor = [UIColor blackColor];
    }
    
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if ([self.inputTextView.text isEqualToString:@""]) {
        self.inputTextView.text = @"enter text";
        self.inputTextView.textColor = [UIColor lightGrayColor];
    }
}
-(UITextView*)makeInputTextView
{
    UITextView *textview = [[UITextView alloc] init];
    
    textview.layer.borderColor = [UIColor colorWithRed:220.0/255 green:220.0f/255 blue:220.0/255 alpha:1].CGColor;
    textview.layer.borderWidth = 1;
    textview.layer.cornerRadius = 6;
    textview.text = @"    enter text";
    textview.textColor = [UIColor lightGrayColor];
    textview.font = [UIFont systemFontOfSize:16];
    textview.translatesAutoresizingMaskIntoConstraints = false;
    textview.scrollEnabled = YES;
    return  textview;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        self.heightBeforeBecomingActive = self.inputTextView.frame.size.height;
        self.widthBeforeBecomingActive = self.inputTextView.frame.size.width;
        [textView resignFirstResponder];
        return  NO;
    }
    return  YES;
}

-(void)textViewDidChange:(UITextView *)textView
{
    CGFloat olderHeight = self.inputTextView.frame.size.height;
    if (_inputTextView.frame.size.height < 73.5) {
        CGFloat fixedWidth = self.inputTextView.frame.size.width;
        [_inputTextView sizeThatFits:CGSizeMake(fixedWidth, CGFLOAT_MAX)];
        CGSize newSize = [_inputTextView sizeThatFits:CGSizeMake(fixedWidth, CGFLOAT_MAX)];
        CGRect newFrame = _inputTextView.frame;
        newFrame.size = CGSizeMake(MAX(newSize.width, fixedWidth), newSize.height);
        _inputTextView.frame = newFrame;
        CGFloat difference = newFrame.size.height - olderHeight;
        NSLog(@"Diff= %f",difference);
        if ((olderHeight + difference) < 73.5) {
            
        
self.containerViewHeightAnchor.constant = (self.containerViewHeightAnchor.constant) + difference;
        self.view.layoutIfNeeded;
        CGFloat h = self.containerViewHeightAnchor.constant;
        }
        else
        {
            _containerViewHeightAnchor.constant = 73.5;
        }
        
       }
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
   
    
    return _newarr.count;
}




- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ChatMessageCell *cell = (ChatMessageCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.bubbleWidthAnchor.constant =   [self estimateFrameForText:_newarr[indexPath.item]].size.width + 80;
    cell.backgroundColor = [UIColor clearColor];
    NSString *message = _newarr[indexPath.item];
    cell.textView.text = message;
    bool isSend = NO;
    if (indexPath.item >= _messagesRecieve.count) {
        isSend = YES;
    }
    [self setUpCell:cell :isSend];
    return cell;
}

-(void)setUpCell:(ChatMessageCell*)cell:(bool)isSend
{
    if (!isSend) {
        cell.bubbleViewLeftAnchor.active = YES;
        cell.bubbleViewRightAnchor.active = NO;
        [cell addlabel]; // if message is from sender add label to cell
        cell.dateLabelwidthAnchor.constant = self.view.frame.size.width;
    }
    else
    {
        cell.bubbleViewLeftAnchor.active = NO;
        cell.bubbleViewRightAnchor.active = YES;
    }
    
}
#pragma mark <UICololectionViewFlowLayout>
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = _newarr[indexPath.item];
    CGFloat height = [self estimateFrameForText:text].size.height + 40;
    
    return CGSizeMake(self.view.frame.size.width, height);
}

-(CGRect)estimateFrameForText:(NSString*)text
{
    CGSize size = CGSizeMake(self.view.frame.size.width *0.7, 1000);
    NSStringDrawingOptions options = NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin;
    NSDictionary *attributes = @{ NSFontAttributeName : [UIFont systemFontOfSize:20] };
    return [text boundingRectWithSize:size options:options attributes:  attributes context:nil];
    
}

-(void)handleSend
{
    if (self.inputTextView.text != nil) {
        [self.newarr addObject:self.inputTextView.text];
        self.collectionView.reloadData;
        NSIndexPath *tempIndexPath = [NSIndexPath indexPathForItem:self.newarr.count - 1 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:tempIndexPath atScrollPosition: UICollectionViewScrollPositionBottom animated:YES];
        self.inputTextView.text = nil;
        CGRect frame = self.inputTextView.frame;
        self.inputTextView.frame = CGRectMake(frame.origin.x, frame.origin.y
                                              , _originalWidth, _originalHeight);
        self.containerViewHeightAnchor.constant = 50;
        
        
        
    }
    
}

-(void)setUpKeyBoardObservers
{
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(handleKeyBoardDidShoW:) name:UIKeyboardDidShowNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(handleKeyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(handleKeyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)handleKeyBoardWillShow:(NSNotification*)notification
{
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [keyboardFrameBegin CGRectValue].size;
    CGFloat keyboardHeight = keyboardSize.height;
    NSNumber *keyboardDuration = UIKeyboardAnimationDurationUserInfoKey;
    if (self.keyBoardCount == 0) {
        self.containerViewBottomAnchor.constant = -(keyboardHeight);
        self.originalKeyBoardHeight = keyboardHeight;
        
    }
    else
    {
        _containerViewBottomAnchor.constant = -self.originalKeyBoardHeight;
    }
    [UIView animateWithDuration:keyboardDuration.doubleValue animations:^{
        
        [self.view layoutIfNeeded];
    }];
    
    
    self.keyBoardCount = 1;
    
}

-(void)handleKeyBoardDidShoW:(NSNotification*)notification
{
    if (self.newarr.count != 0) {
        NSDictionary* keyboardInfo = [notification userInfo];
        NSNumber *keyboardDuration = UIKeyboardAnimationDurationUserInfoKey;
        NSIndexPath *tempIndexPath = [NSIndexPath indexPathForItem:self.newarr.count - 1 inSection:0];
        [UIView animateWithDuration:0 animations:^{
            [self.collectionView scrollToItemAtIndexPath:tempIndexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:true];
        }];
        
    }
}

-(void)handleKeyBoardWillHide:(NSNotification*)notification
{
    self.containerViewBottomAnchor.constant = 0;
    NSDictionary* keyboardInfo = [notification userInfo];
    double keyboardDuration = UIKeyboardAnimationDurationUserInfoKey.doubleValue;
//    [UIView animateWithDuration:(NSTimeInterval)keyboardDuration animations: self.view.layoutIfNeeded];
    
}
-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    self.collectionView.collectionViewLayout.invalidateLayout;
}
-(void)unblockUser
{
    [self.blockedMessageButton removeFromSuperview];
    [self setUpInputComponents];
    [self setUpKeyBoardObservers];
    self.heightBeforeBecomingActive = self.inputTextView.frame.size.height;
    self.widthBeforeBecomingActive = self.inputTextView.frame.size.width;
    NSLog(@"%f",self.heightBeforeBecomingActive);
}
-(void)setUpInputComponents
{
    
    UIView *containerView = [[UIView alloc] init];
    containerView.backgroundColor = [UIColor whiteColor];
    containerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview: containerView];
    [containerView.leftAnchor constraintEqualToAnchor: self.view.leftAnchor].active = YES;
    _containerViewBottomAnchor = [containerView.bottomAnchor constraintEqualToAnchor: self.view.bottomAnchor];
    _containerViewBottomAnchor.active = YES;
    [containerView.widthAnchor constraintEqualToAnchor: self.view.widthAnchor].active = YES;
    
    self.containerViewHeightAnchor =  [containerView.heightAnchor constraintEqualToConstant:50];
    self.containerViewHeightAnchor.active = YES;
    
    UIButton *sendButton = [UIButton buttonWithType: UIButtonTypeSystem];
    [sendButton setTitle:@"Send" forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(
     handleSend) forControlEvents:UIControlEventTouchUpInside];
    sendButton.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:sendButton];
    [sendButton.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [sendButton.centerYAnchor constraintEqualToAnchor:containerView.centerYAnchor].active = YES;
    [sendButton.widthAnchor constraintEqualToConstant:80].active = YES;
    [sendButton.heightAnchor constraintEqualToAnchor:containerView.heightAnchor].active = YES;
    self.inputTextView = [self makeInputTextView];
    self.inputTextView.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview: self.inputTextView];
   
    [self.inputTextView.leftAnchor constraintEqualToAnchor:containerView.leftAnchor constant:10].active = YES;
    [self.inputTextView.rightAnchor constraintEqualToAnchor:sendButton.leftAnchor constant:10].active = YES;
    [self.inputTextView.topAnchor constraintEqualToAnchor:containerView.topAnchor constant:10].active = YES;
    [self.inputTextView.bottomAnchor constraintEqualToAnchor:containerView.bottomAnchor constant:-10].active = YES;
    self.inputTextView.delegate = self;
    self.originalHeight = self.inputTextView.frame.size.height;
    self.originalWidth = self.inputTextView.frame.size.width;
    UIView *separatorLineView = [[UIView alloc]init];
    separatorLineView.backgroundColor = [UIColor colorWithRed:0.86 green:0.86 blue:0.86 alpha:1];
    separatorLineView.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:separatorLineView];
    [separatorLineView.leftAnchor constraintEqualToAnchor:containerView.leftAnchor].active = YES;
    [separatorLineView.topAnchor constraintEqualToAnchor:containerView.topAnchor].active =YES;
    [separatorLineView.widthAnchor constraintEqualToAnchor:containerView.widthAnchor].active = YES;
    [separatorLineView.heightAnchor constraintEqualToConstant:1]
    .active = YES;

    
}
-(void)setUpBlockedView
{
    self.blockedMessageButton = [[UIButton alloc]init];
    self.blockedMessageButton.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
    self.blockedMessageButton.tintColor = [UIColor whiteColor];
    [self.blockedMessageButton setTitle:@"You cannot send more messages" forState:UIControlStateNormal];
    [self.blockedMessageButton addTarget:self action:@selector(unblockUser) forControlEvents: UIControlEventTouchUpInside];
    self.blockedMessageButton.titleLabel.font = [UIFont systemFontOfSize:16];
    self.blockedMessageButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.blockedMessageButton];
    [self.blockedMessageButton.leftAnchor constraintEqualToAnchor: self.view.leftAnchor].active = YES;
    [self.blockedMessageButton.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [self.blockedMessageButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [self.blockedMessageButton.heightAnchor constraintEqualToConstant:50].active = YES   ;
    
    
    
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/


@end
