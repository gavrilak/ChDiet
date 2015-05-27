//
//  BASRegistrationViewController.m
//  ChatDieta
//
//  Created by Sergey on 11.11.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASRegistrationViewController.h"
#import "BASChatViewController.h"

@interface BASRegistrationViewController ()
@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) NSArray* textFields;
@property (nonatomic,strong) UIButton* registrButton;
@end

@implementation BASRegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = [[UIScreen mainScreen]bounds];
    
    self.scrollview = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollview.showsHorizontalScrollIndicator = NO;
    _scrollview.showsVerticalScrollIndicator = NO;
    [_scrollview setBounces:NO];
    [_scrollview setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview: _scrollview];
    
    UIImage* image = [UIImage imageNamed:@"register_bg@3x.png"];
    if(IS_IPHONE_5)
        image = [UIImage imageNamed:@"register_bg@2x.png"];
    else if(IS_IPHONE_6)
        image = [UIImage imageNamed:@"register_bg_6.png"];
    UIImageView *bgView = [[UIImageView alloc]initWithImage:image];
    [bgView setFrame:CGRectMake(0, 0, _scrollview.bounds.size.width, image.size.height)];
    
    [_scrollview addSubview:bgView];
    
    NSMutableArray* temp = [[NSMutableArray alloc]initWithCapacity:8];
    for(int i = 0 ;i < 8; i++){
        
        UITextField *textField = [[UITextField alloc]init];
        [textField setBackgroundColor:[UIColor clearColor]];
        textField.borderStyle = UITextBorderStyleNone;
        textField.font = [UIFont fontWithName:@"Helvetica-Light" size:15.f];
        textField.placeholder = @"enter text";
        textField.autocorrectionType = UITextAutocorrectionTypeNo;
        textField.keyboardType = UIKeyboardTypeDefault;
        textField.returnKeyType = UIReturnKeyDone;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        textField.delegate = (id) self;
        if ([textField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
            NSDictionary *textAttributes =
            @{ NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Light" size:15.f] };
            NSAttributedString *attributedPlaceholder =
            [[NSAttributedString alloc] initWithString:@"" attributes:@{
                                                                        NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Light" size:15.f],
                                                                        }];
            
            [textField setAttributedPlaceholder:attributedPlaceholder];
        }
        textField.textColor = [UIColor colorWithRed:34.f/255.f green:141.f/255.f blue:221.f/255.f alpha:1.0];
        
        [temp addObject:textField];
        [_scrollview addSubview:textField];
    }
    
    self.textFields = [NSArray arrayWithArray:temp];
    ((UITextField*)[_textFields objectAtIndex:6]).secureTextEntry = YES;
    ((UITextField*)[_textFields objectAtIndex:7]).secureTextEntry = YES;
    ((UITextField*)[_textFields objectAtIndex:5]).keyboardType = UIKeyboardTypeEmailAddress;
    ((UITextField*)[_textFields objectAtIndex:2]).keyboardType = UIKeyboardTypeNumberPad;
    
    ((UITextField*)[_textFields objectAtIndex:0]).frame = CGRectMake(81.f,29.f, 204.f, 30.f);
    ((UITextField*)[_textFields objectAtIndex:1]).frame = CGRectMake(81.f,73.f, 204.f, 30.f);
    ((UITextField*)[_textFields objectAtIndex:2]).frame = CGRectMake(81.f,117.f, 204.f, 30.f);
    ((UITextField*)[_textFields objectAtIndex:3]).frame = CGRectMake(81.f,160.f, 204.f, 30.f);
    ((UITextField*)[_textFields objectAtIndex:4]).frame = CGRectMake(81.f,202.f, 204.f, 30.f);
    ((UITextField*)[_textFields objectAtIndex:5]).frame = CGRectMake(81.f,248.f, 204.f, 30.f);
    ((UITextField*)[_textFields objectAtIndex:6]).frame = CGRectMake(81.f,295.f, 204.f, 30.f);
    ((UITextField*)[_textFields objectAtIndex:7]).frame = CGRectMake(81.f,338.f, 204.f, 30.f);
    if(IS_IPHONE_6){
        ((UITextField*)[_textFields objectAtIndex:0]).frame = CGRectMake(95.f,34.f, 235.f, 35.f);
        ((UITextField*)[_textFields objectAtIndex:1]).frame = CGRectMake(95.f,86.f, 235.f, 35.f);
        ((UITextField*)[_textFields objectAtIndex:2]).frame = CGRectMake(95.f,138.f, 235.f, 35.f);
        ((UITextField*)[_textFields objectAtIndex:3]).frame = CGRectMake(95.f,187.f, 235.f, 35.f);
        ((UITextField*)[_textFields objectAtIndex:4]).frame = CGRectMake(95.f,237.f, 235.f, 35.f);
        ((UITextField*)[_textFields objectAtIndex:5]).frame = CGRectMake(95.f,291.f, 235.f, 35.f);
        ((UITextField*)[_textFields objectAtIndex:6]).frame = CGRectMake(95.f,345.f, 235.f, 35.f);
        ((UITextField*)[_textFields objectAtIndex:7]).frame = CGRectMake(95.f,395.f, 235.f, 35.f);
    } else if(IS_IPHONE_6_PLUS){
        ((UITextField*)[_textFields objectAtIndex:0]).frame = CGRectMake(105.f,38.f, 265.f, 37.f);
        ((UITextField*)[_textFields objectAtIndex:1]).frame = CGRectMake(105.f,95.f, 265.f, 37.f);
        ((UITextField*)[_textFields objectAtIndex:2]).frame = CGRectMake(105.f,152.f, 265.f, 37.f);
        ((UITextField*)[_textFields objectAtIndex:3]).frame = CGRectMake(105.f,207.f, 265.f, 37.f);
        ((UITextField*)[_textFields objectAtIndex:4]).frame = CGRectMake(105.f,263.f, 265.f, 37.f);
        ((UITextField*)[_textFields objectAtIndex:5]).frame = CGRectMake(105.f,322.f, 265.f, 37.f);
        ((UITextField*)[_textFields objectAtIndex:6]).frame = CGRectMake(105.f,382.f, 265.f, 37.f);
        ((UITextField*)[_textFields objectAtIndex:7]).frame = CGRectMake(105.f,437.f, 265.f, 37.f);
    }
    image = [UIImage imageNamed:@"button_sign_up.png"];
    CGFloat posY = ((UITextField*)[_textFields objectAtIndex:7]).frame.origin.y + ((UITextField*)[_textFields objectAtIndex:7]).frame.size.height + 60.f;
    self.registrButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_registrButton setBackgroundColor:[UIColor clearColor]];
    [_registrButton setBackgroundImage:image forState:UIControlStateNormal];
    [_registrButton setFrame:CGRectMake(frame.size.width / 2 - image.size.width / 2, posY, image.size.width, image.size.height)];
    [_registrButton addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
    [_scrollview addSubview:_registrButton];
    
    [_scrollview setContentSize:CGSizeMake(frame.size.width, frame.size.height)];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self removeTitleImage];
    [self setupNavBtn:BACKTYPE];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [super viewWillDisappear:animated];
    
}
#pragma mark -
#pragma mark NSNotification
- (void)keyboardWillShow:(NSNotification*)notification
{
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    
    CGSize scrollSize = _scrollview.contentSize;
    
    if(IS_IPHONE_6){
        scrollSize.height += 60.f ;
    }else if(IS_IPHONE_6_PLUS){
        scrollSize.height += 60.f ;

    } else {
        scrollSize.height += 100.f ;
    }
    [_scrollview setContentSize:scrollSize];
   // [_scrollview setContentOffset:CGPointMake(0, scrollSize.height) animated:NO];
}
- (void)keyboardWillHide:(NSNotification*)notification
{
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    CGSize scrollSize = _scrollview.contentSize;
    
    if(IS_IPHONE_6){
        scrollSize.height -= 60.f;
    }else if(IS_IPHONE_6_PLUS){
        scrollSize.height -= 60.f;
    } else {
        scrollSize.height -= 100.f;
    }
    [_scrollview setContentSize:scrollSize];
   // [_scrollview setContentOffset:CGPointMake(0, 0) animated:YES];
}
#pragma mark -
#pragma mark UITextField delegate methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    

    if(textField == (UITextField*)[_textFields objectAtIndex:5] || textField == (UITextField*)[_textFields objectAtIndex:6] || textField == (UITextField*)[_textFields objectAtIndex:7]){
       
        if(IS_IPHONE_6){
            [_scrollview setContentOffset:CGPointMake(0, 60.f) animated:YES];
        }else if(IS_IPHONE_6_PLUS){
            [_scrollview setContentOffset:CGPointMake(0, 60.f) animated:YES];
        } else {
             [_scrollview setContentOffset:CGPointMake(0, 100.f) animated:YES];
        }

    }
   
    
    return YES;
}
- (BOOL) textField: (UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString: (NSString *)string {


    if(textField == (UITextField*)[_textFields objectAtIndex:2]){
        if (textField.text.length < 2){
            if ([string intValue])
            {
                return YES;
            } else{
                return NO;
            }
        } else {
            return NO;
        }
    }
        
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    CGRect frame = [[UIScreen mainScreen]bounds];
    [textField resignFirstResponder];
    [_scrollview setContentSize:CGSizeMake(frame.size.width, frame.size.height)];
    [_scrollview setContentOffset:CGPointMake(0,0.f) animated:NO];
    return YES;
}
- (void)clicked{
    
    TheApp;
    for (UITextField* field in _textFields) {
        if([field.text isEqualToString:@""]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Сообщение" message:@"Все поля обязательны для заполнения!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            
            [alert show];
            return;
        } else if((UITextField*)[_textFields objectAtIndex:5] == field){
            NSArray* arr = [field.text componentsSeparatedByString:@"@"];
            if(arr.count == 1){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Сообщение" message:@"Некорректный адрес электронной почты!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                
                [alert show];
            } else {
                break;
            }
        }
    }
    NSString* pass = ((UITextField*)[_textFields objectAtIndex:6]).text;
    NSString* confirmpass = ((UITextField*)[_textFields objectAtIndex:7]).text;
    if([pass compare:confirmpass] != NSOrderedSame){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Сообщение" message:@"Пароль и потверждение не совпадают!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [alert show];
        return;
    }
    
    NSDateFormatter *objDateFormatter = [[NSDateFormatter alloc] init];
    [objDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *timezone = [objDateFormatter stringFromDate:[NSDate date]];
    
    NSString* agestr = ((UITextField*)[_textFields objectAtIndex:2]).text;
    NSNumber* age = [NSNumber numberWithInt:[agestr intValue]];
    NSDictionary* param = @{
                            @"login" :((UITextField*)[_textFields objectAtIndex:5]).text,
                            @"pass" : ((UITextField*)[_textFields objectAtIndex:6]).text,
                            @"uid" : app.UID,
                            @"timezone" : timezone,
                            @"surname_user" :((UITextField*)[_textFields objectAtIndex:1]).text,
                            @"name_user" :((UITextField*)[_textFields objectAtIndex:0]).text,
                            @"age" :age,
                            @"country" :((UITextField*)[_textFields objectAtIndex:3]).text,
                            @"city" :((UITextField*)[_textFields objectAtIndex:4]).text,
                            };

    [[BASManager sharedInstance] getData:[[BASManager sharedInstance] formatRequest:@"REGISTER" withParam:param] success:^(NSDictionary* responseObject) {
        if([responseObject isKindOfClass:[NSDictionary class]]){
          //  NSLog(@"%@",responseObject);
            NSArray* userInfo = (NSArray*)[responseObject objectForKey:@"param"];
            NSDictionary* dict = (NSDictionary*)[userInfo objectAtIndex:0];
            
            if(dict.allKeys.count == 1){
                if ([[dict objectForKey:@"result"] isEqualToString:@"This login is not available"]) {
                    [[BASManager sharedInstance] showAlertViewWithMess:@"Данный e-mail адрес уже используется"];
                } else {
                    [[BASManager sharedInstance] showAlertViewWithMess:@"Ошибка регистрации!"];
                    return ;
                }
            } else{
                app.userInfo = (NSDictionary*)[userInfo objectAtIndex:0];
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:(NSString*)[app.userInfo objectForKey:@"login"] forKey:@"login"];
                [userDefaults setObject:(NSString*)[app.userInfo objectForKey:@"pass"] forKey:@"password"];
                [userDefaults setObject:app.userInfo forKey:@"userInfo"];
                [userDefaults setObject:[NSNumber numberWithInt:app.loginType] forKey:@"loginType"];
                [userDefaults synchronize];
                
                [[BASManager sharedInstance] checkPurshes];
            }
            
        }
    }failure:^(NSString *error) {
        NSLog(@"%@",error);
    }];

}
@end
