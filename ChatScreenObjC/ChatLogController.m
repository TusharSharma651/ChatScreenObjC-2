//
//  ChatLogController.m
//  ChatScreenObjC
//
//  Created by Unoiatech on 17/05/18.
//  Copyright © 2018 Unoiatech. All rights reserved.
//

#import "ChatLogController.h"

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
-(void) handleSend;
@end

@implementation ChatLogController
static NSString * const reuseIdentifier = @"cellid";

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Chat LOg COntroller");
    _keyBoardCount = 0;
    _messagesRecieve = [[NSMutableArray alloc ] initWithObjects:@"I am willing to offer you help for the errands you are wanting to have worked on",@"YES",@"p", nil];
    _messagesSend = [[NSMutableArray alloc] initWithObjects: @"Hi",@"Hello",@"Go man",@"Let's Go",@"I am willing to offer you help for the errands you are wanting", nil];
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
    self.collectionView.contentInset = UIEdgeInsetsMake(80,0, 58, 0);
    self.collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    self.collectionView.backgroundColor = [UIColor grayColor];
    self.collectionView.alwaysBounceVertical = YES;
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self setUpInputComponents];
    [self setUpKeyBoardObservers];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
 
 */
-(UITextView*)inputTextView
{
    UITextView *textview = [[UITextView alloc] init];
    
    textview.layer.borderColor = [UIColor colorWithRed:220/255 green:220/255 blue:220/255 alpha:1].CGColor;
    textview.layer.borderWidth = 1;
    textview.layer.cornerRadius = 6;
    textview.text = @"    enter text";
    textview.textColor = [UIColor lightGrayColor];
    textview.font = [UIFont systemFontOfSize:16];
    textview.translatesAutoresizingMaskIntoConstraints = false;
    textview.scrollEnabled = YES;
    return  textview;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}
-(void)handleSend
{
    
}

-(void)setUpKeyBoardObservers
{
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(handleKeyBoardDidShow) name:UIKeyboardDidShowNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(handleKeyBoardWillShow) name:UIKeyboardWillShowNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(handleKeyBoardWillHide) name:UIKeyboardWillHideNotification object:nil];
}

-(void)handleKeyBoardDidShoW:(NSNotification*)notification
{
    if (_newarr.count!=0) {
        NSNumber *keyboardDuration = notification.userInfo [UIKeyboardAnimationDurationUserInfoKey];
        NSIndexPath *lastIndexPath = [NSIndexPath indexPathForItem:self.newarr.count -  1   inSection:0];
//        [UIView animateWithDuration: keyboardDuration.doubleValue animations:[self.collectionView scrollToItemAtIndexPath:lastIndexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES]];

        
        
    }
}
-(void)handleKeyBoardWillShow
{
    
}
-(void)handleKeyBoardWillHide
{
    
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
    [containerView.heightAnchor constraintEqualToConstant:50].active = YES;
    UIButton *sendButton = [UIButton buttonWithType: UIButtonTypeSystem];
    [sendButton setTitle:@"Click Me" forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(handleSend) forControlEvents:UIControlEventTouchUpInside];
    sendButton.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:sendButton];
    [sendButton.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [sendButton.centerYAnchor constraintEqualToAnchor:containerView.centerYAnchor].active = YES;
    [sendButton.widthAnchor constraintEqualToConstant:80].active = YES;
    [sendButton.heightAnchor constraintEqualToAnchor:containerView.heightAnchor].active = YES;
    UITextView *inputView = [self inputTextView];
    inputView.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview: inputView];
    NSLog(@"count = %d",containerView.subviews.count);
    [inputView.leftAnchor constraintEqualToAnchor:containerView.leftAnchor constant:10].active = YES;
    [inputView.rightAnchor constraintEqualToAnchor:sendButton.leftAnchor constant:10].active = YES;
    [inputView.topAnchor constraintEqualToAnchor:containerView.topAnchor constant:10].active = YES;
    [inputView.bottomAnchor constraintEqualToAnchor:containerView.bottomAnchor constant:-10].active = YES;
    inputView.delegate = self;
    self.originalHeight = inputView.frame.size.height;
    self.originalWidth = inputView.frame.size.width;
    UIView *separatorLineView = [[UIView alloc]init];
    separatorLineView.backgroundColor = [UIColor colorWithRed:220/255 green:220/255 blue:220/255 alpha:1];
    separatorLineView.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:separatorLineView];
    [separatorLineView.leftAnchor constraintEqualToAnchor:containerView.leftAnchor].active = YES;
    [separatorLineView.topAnchor constraintEqualToAnchor:containerView.topAnchor].active =YES;
    [separatorLineView.widthAnchor constraintEqualToAnchor:containerView.widthAnchor].active = YES;
    [separatorLineView.heightAnchor constraintEqualToConstant:1]
    .active = YES;

    
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
