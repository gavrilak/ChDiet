//
//  BASInfoViewController.m
//  SupportChat
//
//  Created by Sergey on 17.11.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASInfoViewController.h"
#import "BASProgViewController.h"

@interface BASInfoViewController ()
@property (nonatomic, strong) UIButton* srcButton;
@property (nonatomic, strong) UIButton* anyButton;
@property (nonatomic, strong) UIScrollView *scrollview;
@end

@implementation BASInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    _scrollview.showsHorizontalScrollIndicator = NO;
    _scrollview.showsVerticalScrollIndicator = NO;
    [_scrollview setBounces:NO];
    [_scrollview setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview: _scrollview];

    
    UIImage* image = [UIImage imageNamed:@"bg_about.png"];
    if(IS_IPHONE_6)
        image = [UIImage imageNamed:@"bg_about_6.png"];
    UIImageView* bgView = [[UIImageView alloc]initWithImage:image];
    [bgView setFrame:CGRectMake(0, 0, self.view.bounds.size.width, image.size.height)];
    [_scrollview addSubview:bgView];
 
    
    self.srcButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_srcButton setBackgroundColor:[UIColor clearColor]];
    [_srcButton addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollview addSubview: _srcButton];
    
    self.anyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_anyButton setBackgroundColor:[UIColor clearColor]];
    [_anyButton addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollview addSubview: _anyButton];
    
    [_srcButton setFrame:CGRectMake(0, 278.f, self.view.bounds.size.width, 40.f)];
    [_anyButton setFrame:CGRectMake(0, 425.f, self.view.bounds.size.width, 40.f)];
    if(IS_IPHONE_6){
        [_srcButton setFrame:CGRectMake(0, 325.f, self.view.bounds.size.width, 50.f)];
        [_anyButton setFrame:CGRectMake(0, 497.f, self.view.bounds.size.width, 50.f)];
    } else if(IS_IPHONE_6_PLUS){
        [_srcButton setFrame:CGRectMake(0, 360.f, self.view.bounds.size.width, 70.f)];
        [_anyButton setFrame:CGRectMake(0, 545.f, self.view.bounds.size.width, 70.f)];
    }
    [_scrollview setContentSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height)];
    if(!Is4Inch && IS_IPHONE_5){
        [_scrollview setContentSize:CGSizeMake(self.view.bounds.size.width, 568.f)];
    }
}
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self removeTitleImage];
    [self customTitle:@"Инфо"];
    [self setupNavBtn:BACKTYPE];

}

- (void)viewWillDisappear:(BOOL)animated{
    [self customTitle:@""];
    [self removeTitleImage];
    [super viewWillDisappear:animated];
    
}
- (void)clicked:(id)sender{
    TheApp;
    UIButton* button = (UIButton*)sender;
    if([button isEqual:_srcButton]){

        NSString* link = @"https://itunes.apple.com/ru/app/dieta-dukana-+-dnevnik-pitania/id813912029?mt=8";
        
        if([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:link]]){
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:link]];
        }
    } else {
        BASProgViewController * controller = [BASProgViewController new];
        [app.navigationController pushViewController:controller animated:YES];
    }
}
@end
