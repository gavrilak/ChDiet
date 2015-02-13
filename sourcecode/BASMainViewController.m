//
//  ViewController.m
//  tellme
//
//  Created by Sergey on 09.10.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//
#import "BASAppDelegate.h"
#import "BASMainViewController.h"
#import "BASChatViewController.h"
#import "BASRegistrationViewController.h"
#import "InAppPurches.h"


@interface BASMainViewController (){
    UIButton *curButton;
  //  BOOL isButtonPress;
}

@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) UIImageView* infoView;
@property (nonatomic,strong) UIButton* oneButton;
@property (nonatomic,strong) UIButton* treeButton;
@property (nonatomic,strong) UIButton* sixButton;
@property (nonatomic,strong) UIButton* inButton;
@property (nonatomic,strong) UIButton* guestButton;
@property (nonatomic,strong) UIButton* fbButton;
@property (nonatomic,strong) UIButton* registrButton;
@property (nonatomic,strong) InAppPurches* purchaes;
@end

@implementation BASMainViewController

- (void)viewDidLoad {
    TheApp;
    [super viewDidLoad];
    
    _isButtonPress = NO;
    self.purchaes = [[InAppPurches alloc]init];
    _purchaes.delegate = (id) self;
    
    CGRect frame = [[UIScreen mainScreen]bounds];

    self.scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, app.tabView.frame.origin.y)];
    _scrollview.showsHorizontalScrollIndicator = NO;
    _scrollview.showsVerticalScrollIndicator = NO;
    [_scrollview setBounces:NO];
    [_scrollview setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview: _scrollview];
    
}
- (void)viewWillAppear:(BOOL)animated{
    TheApp;
    [super viewWillAppear:animated];
    [self customTitleImage];
    [self setupNavBtn:MENUTYPE];
    [self.view addSubview:app.tabView];
    app.tabView.delegate = self;
    [self prepareView];
}
- (void)viewWillDisappear:(BOOL)animated{
    TheApp;
    [super viewWillDisappear:animated];
    [app.tabView removeFromSuperview];
    
}
#pragma mark - Service method


- (void)prepareView{
    TheApp;
    [_infoView removeFromSuperview];
    _infoView  = nil;
    [_oneButton removeFromSuperview];
    _oneButton  = nil;
    [_sixButton removeFromSuperview];
    _sixButton  = nil;
    [_treeButton removeFromSuperview];
    _treeButton  = nil;
    [_inButton removeFromSuperview];
    _inButton  = nil;
    [_fbButton removeFromSuperview];
    _fbButton  = nil;
    [_guestButton removeFromSuperview];
    _guestButton = nil;
    [_registrButton removeFromSuperview];
    _registrButton  = nil;
    
    [_scrollview setScrollEnabled:YES];
    CGRect frame = [[UIScreen mainScreen]bounds];
    
    UIImage* image = [UIImage imageNamed:@"text_nutritionist.png"];
    if(IS_IPHONE_6)
        image = [UIImage imageNamed:@"text_nutritionist_6.png"];
    self.infoView = [[UIImageView alloc]initWithImage:image];
    [_infoView setFrame:CGRectMake(frame.size.width / 2 - image.size.width / 2, _scrollview.frame.origin.y + 5.f, frame.size.width, image.size.height)];
    [_scrollview addSubview:_infoView];
    
    CGFloat posY = _infoView.frame.origin.y + _infoView.frame.size.height + 10.f ;

    
    if(app.tabView.tabIndex == 1 || app.isLogin){

        if(!app.isPurchaise && app.tabView.tabIndex != 1 ){
            
            posY += 10.f ;
            image = [UIImage imageNamed:@"button_899.png"];
            if(!IS_IPHONE_5)
                image = [UIImage imageNamed:@"button_899@3x.png"];
            self.oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [_oneButton setBackgroundColor:[UIColor clearColor]];
            [_oneButton setBackgroundImage:image forState:UIControlStateNormal];
            [_oneButton setFrame:CGRectMake(frame.size.width / 2 - image.size.width / 2, posY, image.size.width, image.size.height)];
            [_oneButton addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
            [_scrollview addSubview:_oneButton];
            
            posY += (_oneButton.frame.size.height + 10.f);
            image = [UIImage imageNamed:@"button_2390.png"];
            if(!IS_IPHONE_5)
                image = [UIImage imageNamed:@"button_2390@3x.png"];
            self.treeButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [_treeButton setBackgroundColor:[UIColor clearColor]];
            [_treeButton setBackgroundImage:image forState:UIControlStateNormal];
            [_treeButton setFrame:CGRectMake(frame.size.width / 2 - image.size.width / 2, posY, image.size.width, image.size.height)];
            [_treeButton addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
            [_scrollview addSubview:_treeButton];
            
            posY += (_treeButton.frame.size.height + 10.f);
            
            image = [UIImage imageNamed:@"button_4290.png"];
            if(!IS_IPHONE_5)
                image = [UIImage imageNamed:@"button_4290@3x.png"];
            self.sixButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [_sixButton setBackgroundColor:[UIColor clearColor]];
            [_sixButton setBackgroundImage:image forState:UIControlStateNormal];
            [_sixButton setFrame:CGRectMake(frame.size.width / 2 - image.size.width / 2, posY, image.size.width, image.size.height)];
            [_sixButton addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
            [_scrollview addSubview:_sixButton];
            posY += (_sixButton.frame.size.height + 15.f);
            
        } else{
            image = [UIImage imageNamed:@"bg_support.png"];
            if(IS_IPHONE_6)
                image = [UIImage imageNamed:@"bg_support_6.png"];
            [_infoView setFrame:CGRectMake(0, frame.size.height / 2 - image.size.height / 2 - 113.f, image.size.width, image.size.height)];
            posY = frame.size.height;
            [_infoView setImage:image];
            [_scrollview setScrollEnabled:NO];
        }
        
        

    } else {
        if(app.tabView.tabIndex == 1){
            image = [UIImage imageNamed:@"text_technical_support.png"];
            if(IS_IPHONE_6)
                image = [UIImage imageNamed:@"text_technical_support_6.png"];
        } else {
            image = [UIImage imageNamed:@"text_nutritionist.png"];
            if(IS_IPHONE_6)
                image = [UIImage imageNamed:@"text_nutritionist_6.png"];
        }
        [_infoView setImage:image];
        image = [UIImage imageNamed:@"button_sign_in.png"];
        if(!IS_IPHONE_5)
            image = [UIImage imageNamed:@"button_sign_in@3x.png"];
        self.inButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_inButton setBackgroundColor:[UIColor clearColor]];
        [_inButton setBackgroundImage:image forState:UIControlStateNormal];
        [_inButton setFrame:CGRectMake(frame.size.width / 2 - image.size.width / 2, posY, image.size.width, image.size.height)];
        [_inButton addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollview addSubview:_inButton];
        
        posY += (_inButton.frame.size.height );
        
        image = [UIImage imageNamed:@"button_guest_in.png"];
        if(!IS_IPHONE_5)
            image = [UIImage imageNamed:@"button_guest_in@3x.png"];
        self.guestButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_guestButton setBackgroundColor:[UIColor clearColor]];
        [_guestButton setBackgroundImage:image forState:UIControlStateNormal];
        [_guestButton setFrame:CGRectMake(frame.size.width / 2 - image.size.width / 2, posY, image.size.width, image.size.height)];
        [_guestButton addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollview addSubview:_guestButton];
        
        posY += (_inButton.frame.size.height );
        
        image = [UIImage imageNamed:@"button_sign_in_fb.png"];
        if(!IS_IPHONE_5)
            image = [UIImage imageNamed:@"button_sign_in_fb@3x.png"];
        self.fbButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fbButton setBackgroundColor:[UIColor clearColor]];
        
        [_fbButton setBackgroundImage:image forState:UIControlStateNormal];
        [_fbButton setFrame:CGRectMake(frame.size.width / 2 - image.size.width / 2, posY, image.size.width, image.size.height)];
        [_fbButton addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollview addSubview:_fbButton];
        
        posY += (_fbButton.frame.size.height );
        
        image = [UIImage imageNamed:@"button_register.png"];
        if(!IS_IPHONE_5)
            image = [UIImage imageNamed:@"button_register@3x.png"];
        self.registrButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registrButton setBackgroundColor:[UIColor clearColor]];
        [_registrButton setBackgroundImage:image forState:UIControlStateNormal];
        [_registrButton setFrame:CGRectMake(frame.size.width / 2 - image.size.width / 2, posY, image.size.width, image.size.height)];
        [_registrButton addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollview addSubview:_registrButton];
        posY += (_registrButton.frame.size.height );
        
        

    }
    
    [_scrollview setContentSize:CGSizeMake(_scrollview.frame.size.width, posY)];
    
}
- (void)setButtonPressedNO{

    _isButtonPress = NO;
}

- (void)clicked:(id)sender{
    TheApp;
    UIButton * button = (UIButton*)sender;
    
    
    if(button == _oneButton && !_isButtonPress){
        _isButtonPress = YES;
        [app showIndecator:YES withView:app.window];
        curButton = _oneButton;
        _purchaes.productID = feature1Id;
    } else if(button == _treeButton && !_isButtonPress){
        _isButtonPress = YES;
        [app showIndecator:YES withView:app.window];
        curButton = _treeButton;
        _purchaes.productID = feature2Id;
    } else if(button == _sixButton && !_isButtonPress){
        _isButtonPress = YES;
        [app showIndecator:YES withView:app.window];
        curButton = _sixButton;
        _purchaes.productID = feature3Id;
    } else if(button == _registrButton){
        BASRegistrationViewController *controller = [BASRegistrationViewController new];
        [app.navigationController pushViewController:controller animated:YES];
    } else if(button == _inButton){
        [app.navigationController pushViewController:app.inputController animated:YES];
    }  else if(button == _fbButton){
        app.loginType = FACEBOOK;
        [[BASManager sharedInstance] LogIn];
    }  else if(button == _guestButton){
        app.loginType = GUEST;
        [[BASManager sharedInstance] LogIn];
    }
}
#pragma mark - Purchaise

-(void)unlockFeatureForDate:(NSDate*) date {

    TheApp;
    [app showIndecator:NO withView:app.window];

    
    [SDCloudUserDefaults removeObjectForKey:@"isPurchaise"];
    [SDCloudUserDefaults removeObjectForKey:@"isPurchaiseTermin"];
    [SDCloudUserDefaults removeObjectForKey:@"isPurchaiseDate"];
    [SDCloudUserDefaults synchronize];

    NSDateFormatter *objDateFormatter = [[NSDateFormatter alloc] init];
    [objDateFormatter setDateFormat:@"dd.MM.yyyy"];
    NSString* dateStr = [objDateFormatter stringFromDate:date];
    NSNumber* term = nil;

    if(curButton == _oneButton){
        term = [NSNumber numberWithInt:1];
    } else if(curButton == _treeButton){
        term = [NSNumber numberWithInt:3];
    }else if(curButton == _sixButton){
        term = [NSNumber numberWithInt:6];
    }
    [SDCloudUserDefaults setObject:dateStr forKey:@"isPurchaiseDate"];
    [SDCloudUserDefaults setObject:term forKey:@"isPurchaiseTermin"];
    [SDCloudUserDefaults setBool:YES forKey:@"isPurchaise"];
    [SDCloudUserDefaults synchronize];
    app.isPurchaise = YES;
    app.isLogin = YES;
    
    [[BASManager sharedInstance] checkPurshes];
 
     [self prepareView];
    //UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Сообщение" message:@"Ваши покупки успешно завершены" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    //[alert show];
    
}
#pragma mark - BASTabView delegate method
- (void)BASTabView:(BASTabView*)view withTabClicked:(NSInteger)index{
    [_scrollview setContentOffset:CGPointMake(0, 0)];
    [self customTitleImage];
    [self prepareView];
}


@end
