//
//  BASGuestInputViewController.m
//  ChatDieta
//
//  Created by Sergey on 12.11.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASGuestInputViewController.h"
#import "BASRegistrationViewController.h"

@interface BASGuestInputViewController ()
@property (nonatomic, strong) UITextField* loginView;
@end

@implementation BASGuestInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat posY = 0.f;
    if(!Is4Inch && IS_IPHONE_5)
        posY = -30.f;
    UIImage* image = [UIImage imageNamed:@"guest_bg.png"];
    if(IS_IPHONE_6)
        image = [UIImage imageNamed:@"guest_bg_6.png"];
    UIImageView* bgView = [[UIImageView alloc]initWithImage:image];
    [bgView setFrame:CGRectMake(0, posY, self.view.bounds.size.width, image.size.height)];
   
    [self.view addSubview:bgView];
    
    self.loginView = [[UITextField alloc]init];
    [_loginView setBackgroundColor:[UIColor clearColor]];
    _loginView.borderStyle = UITextBorderStyleNone;
    _loginView.font = [UIFont fontWithName:@"Helvetica-Light" size:15.f];
    _loginView.placeholder = @"enter text";
    _loginView.autocorrectionType = UITextAutocorrectionTypeNo;
    _loginView.keyboardType = UIKeyboardTypeDefault;
    _loginView.returnKeyType = UIReturnKeyDone;
    _loginView.clearButtonMode = UITextFieldViewModeWhileEditing;
    _loginView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _loginView.delegate = (id) self;
    if ([_loginView respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        NSDictionary *textAttributes =
        @{ NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Light" size:15.f] };
        NSAttributedString *attributedPlaceholder =
        [[NSAttributedString alloc] initWithString:@"" attributes:@{
                                                                    NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Light" size:15.f],
                                                                    }];
        
        [_loginView setAttributedPlaceholder:attributedPlaceholder];
    }
    _loginView.textColor = [UIColor colorWithRed:34.f/255.f green:141.f/255.f blue:221.f/255.f alpha:1.0];
    _loginView.keyboardType = UIKeyboardTypeEmailAddress;
    [self.view addSubview:_loginView];
    
  
    
    _loginView.frame = CGRectMake(58.f,117.f + posY, 204.f, 30.f);
    if(IS_IPHONE_6){
        _loginView.frame = CGRectMake(70.f,136.f, 235.f, 35.f);
    } else if(IS_IPHONE_6_PLUS){
        _loginView.frame = CGRectMake(75.f,151.f, 265.f, 37.f);
    }
    posY = _loginView.frame.origin.y + _loginView.frame.size.height + 30.f;
    image = [UIImage imageNamed:@"button_sign_in.png"];
    if(!IS_IPHONE_5)
        image = [UIImage imageNamed:@"button_sign_in@3x.png"];
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor clearColor]];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setFrame:CGRectMake(self.view.bounds.size.width / 2 - image.size.width / 2, posY, image.size.width, image.size.height)];
    [button addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    image = [UIImage imageNamed:@"button_register.png"];
    if(!IS_IPHONE_5)
        image = [UIImage imageNamed:@"button_register@3x.png"];
    
    UIButton* buttonRestore = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonRestore setBackgroundColor:[UIColor clearColor]];
    [buttonRestore setBackgroundImage:image forState:UIControlStateNormal];
    [buttonRestore setFrame:CGRectMake(self.view.bounds.size.width / 2 - image.size.width / 2, self.view.bounds.size.height -130 , image.size.width, image.size.height)];
    [buttonRestore addTarget:self action:@selector(restore) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonRestore];

    
    UIImage* infoImage = [UIImage imageNamed:@"info_guest.png"];

   // if(IS_IPHONE_6)
    //        infoImage = [UIImage imageNamed:@"guest_bg_6.png"];

    UIImageView* infoView = [[UIImageView alloc]initWithImage:infoImage];
    [infoView setFrame:CGRectMake(0, self.view.bounds.size.height - (infoImage.size.height+170 ),  self.view.bounds.size.width, infoImage.size.height+30)];
    
    [self.view addSubview:infoView];
    
  }
- (void)restore{
    TheApp;
    BASRegistrationViewController *controller = [BASRegistrationViewController new];
    [app.navigationController pushViewController:controller animated:YES];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setupNavBtn:BACKTYPE];
    [self removeTitleImage];

    _loginView.text = @"";
    
 
}
- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];

}



- (void)clicked{
    TheApp;
    app.loginType = GUEST;
    [_loginView resignFirstResponder];

    
    if([_loginView.text isEqualToString:@""] ){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Сообщение" message:@"Необходимо ввести логин!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [alert show];
        return;
    }
    
   app.login = _loginView.text;
   
    [[BASManager sharedInstance]LogIn];
}
#pragma mark -
#pragma mark BASManager delegate methods
-(void)autorizationUser:(BASManager*)obj withResult:(BOOL)state{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Сообщение" message:@"Данный пользователь не существует. Зарегистрируйтесь пожалуйста!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    [alert show];
}
#pragma mark -
#pragma mark UITextField delegate methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    
    return YES;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
  
    return YES;
}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    TheApp;
    switch (alertView.tag) {
        case 101:
            if (buttonIndex == 1) {
                UITextField *textfield = [alertView textFieldAtIndex:0];
                app.login = textfield.text;
                 [app showIndecator:YES withView:app.window];
                [[BASManager sharedInstance]Restore];
            }
    }
}
@end
