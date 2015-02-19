//
//  BASManager.m
//  RestaurantControlSystem
//
//  Created by Sergey on 26.05.14.
//  Copyright (c) 2014 BestApp Studio. All rights reserved.
//

#import "BASManager.h"
#import "SRWebSocket.h"
#import "BASChatViewController.h"


@interface BASManager(){
    void (^_success) (NSDictionary* responseObject);
    void (^_successReopen) (NSDictionary* responseObject);
    void (^_failure) (NSString *error);
    
    BOOL isConnect;
    BOOL isClose;
}

@property (nonatomic,strong)SRWebSocket *webSocket;
@property (nonatomic,strong) NSString* curCommand;
@property (nonatomic,strong) NSDictionary* curDict;
@end

@implementation BASManager



+ (BASManager *)sharedInstance {
    
    static dispatch_once_t once;
    static BASManager *sharedInstance;
    
    dispatch_once(&once, ^{
        sharedInstance = [BASManager new];
        [sharedInstance initialization];
    });
    
    
    return sharedInstance;
}
- (void)initialization{
    isClose = NO;
}
- (void)initSocket{
    //ws://82.146.37.36:8887
    //195.138.68.2
    //ws://25.96.46.155:8887/
     _webSocket = nil;
   // self.webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://192.168.1.101:8887/"]]];
   
    self.webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://chat.bestapp-studio.com:8887/"]]];
    _webSocket.delegate = (id)self;
    
    
    [_webSocket open];
}
- (NSDictionary*)formatRequest:(NSString*)command withParam:(NSDictionary*)param{
    NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          command,@"command",
                          param,@"param",
                          nil];
    self.curCommand = command;
    self.curDict = [NSDictionary dictionaryWithDictionary:param];
    return dict;
}
- (void)resetWebSocket{
    TheApp;
    if(_webSocket.readyState == SR_CLOSED){
        [app showIndecator:YES withView:app.window];
        [self initSocket];
        if(app.userInfo != nil){
            isClose = YES;
            
        }
    }
}
- (void)getData:(NSDictionary*)dict success:(void (^) (NSDictionary* responseObject))success failure:(void (^) (NSString *error))failure{
    
    TheApp;
    _success = success;
    _failure = failure;
    
    if(_webSocket.readyState == SR_CLOSED){
        [self initSocket];
        if(app.userInfo != nil){
            isClose = YES;
            return;
        }
    }
    
    
    NSMutableData* mutData = [NSMutableData dataWithData:[NSJSONSerialization dataWithJSONObject:dict options:0 error:nil]];
    
    [_webSocket send:mutData];
    
}
-(void)closeSocket{
    [_webSocket close];
}

-(void)Restore{
    TheApp;
    __block NSDictionary* param = @{
                                    @"login" :app.login
                                    };
    [self getData:[[BASManager sharedInstance] formatRequest:@"RESETPASSWORD" withParam:param] success:^(NSDictionary* responseObject) {
        if([responseObject isKindOfClass:[NSDictionary class]]){
            [app showIndecator:NO withView:app.window];
            NSNumber* result =(NSNumber*)[[[responseObject objectForKey:@"param"]objectAtIndex:0]objectForKey:@"result"];
            //NSLog(@"%@",responseObject);
            if([result integerValue] == 0){
                [self showAlertViewWithMess:@"Неверно указан e-mail адрес"];
            }
            else{
                [self showAlertViewWithMess:@"Ваш новый пароль успешно выслан на указанный e-mail адрес"];
            }
        }
     }failure:^(NSString *error) {
        NSLog(@"%@",error);
        [app showIndecator:NO withView:app.window];
    }];
}
- (void)LogIn{
    
    TheApp;
 
  
    NSDateFormatter *objDateFormatter = [[NSDateFormatter alloc] init];
    [objDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *timezone = [objDateFormatter stringFromDate:[NSDate date]];
    
    switch (app.loginType) {
        case GUEST:{
            NSString* UIUD =  [[[UIDevice currentDevice] identifierForVendor]UUIDString];
            app.pass = UIUD;
            __block NSDictionary* param = @{
                                            @"uid" : UIUD,
                                            @"login" : app.login,
                                            @"timezone" : timezone
                                          };
            [self getData: [[BASManager sharedInstance] formatRequest:@"REGISTER" withParam:param]success:^(NSDictionary *responseObject) {
                if([responseObject isKindOfClass:[NSDictionary class]]){
                   // NSLog(@"%@",responseObject);
                    NSArray* userInfo = (NSArray*)[responseObject objectForKey:@"param"];
                    NSDictionary* dict = (NSDictionary*)[userInfo objectAtIndex:0];
                    app.userInfo = [NSDictionary dictionaryWithDictionary:dict];
                    if(dict.allKeys.count == 1){
                        [self showAlertViewWithMess:@"Данный логин уже используется!"];
                        if([_delegate respondsToSelector:@selector(autorizationUser:withResult:)]){
                            [_delegate autorizationUser:self withResult:NO];
                        }
                        return;
                    }

                    NSNumber* isPurches =(NSNumber*) [ dict objectForKey:@"isPurches"];
                    if ([isPurches integerValue] == 1)
                        app.isPurchaise = YES;
                    else
                        app.isPurchaise = NO;
                    app.login = [app.userInfo objectForKey:@"login"];
                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                    [userDefaults setObject:app.login forKey:@"login"];
                    [userDefaults setObject:app.pass forKey:@"password"];
                    [userDefaults setObject:[dict objectForKey:@"purchase_date"] forKey:@"isPurchaiseDate"];
                    [userDefaults setObject:[dict objectForKey:@"term"] forKey:@"isPurchaiseTermin"];
                    [userDefaults setBool:app.isPurchaise forKey:@"isPurchaise"];
                    [userDefaults setInteger:app.loginType forKey:@"loginType"];
                    [userDefaults synchronize];
                    [self checkPurshes];
                  
                }
            } failure:^(NSString *error) {
                    NSLog(@"%@",error);
                }];
            
            }
            break;
        case LOCAL:{

            __block NSDictionary* param = @{
                                    @"login" :app.login,
                                    @"pass" : app.pass,
                                    @"timezone" : timezone
                                    };
            [self getData:[[BASManager sharedInstance] formatRequest:@"AUTH" withParam:param] success:^(NSDictionary* responseObject) {
                if([responseObject isKindOfClass:[NSDictionary class]]){
                   // NSLog(@"%@",responseObject);
                    NSArray* userInfo = (NSArray*)[responseObject objectForKey:@"param"];
                    NSDictionary* dict = (NSDictionary*)[userInfo objectAtIndex:0];
                    app.userInfo = [NSDictionary dictionaryWithDictionary:dict];
                    if(dict.allKeys.count == 1){
                        [self showAlertViewWithMess:@"Неверный логин или пароль!"];
                        if([_delegate respondsToSelector:@selector(autorizationUser:withResult:)]){
                            [_delegate autorizationUser:self withResult:NO];
                        }
                        return;
                    }
                    NSNumber* isPurches =(NSNumber*) [ dict objectForKey:@"isPurches"];
                    if ([isPurches integerValue] == 1)
                        app.isPurchaise = YES ;
                    else
                        app.isPurchaise = NO;
                     NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                    [userDefaults setObject:[dict objectForKey:@"purchase_date"] forKey:@"isPurchaiseDate"];
                    [userDefaults setObject:[dict objectForKey:@"term"] forKey:@"isPurchaiseTermin"];
                    [userDefaults setBool:app.isPurchaise forKey:@"isPurchaise"];
                    [userDefaults setObject:app.login forKey:@"login"];
                    [userDefaults setObject:app.pass forKey:@"password"];
                    [userDefaults setObject:app.userInfo forKey:@"userInfo"];
                    [userDefaults setInteger: app.loginType forKey:@"loginType"];
                    [userDefaults synchronize];
                    //app.login = (NSString*)[app.userInfo objectForKey:@"login"];
                   // app.pass = (NSString*)[app.userInfo objectForKey:@"pass"];
                    [self checkPurshes];
                                              
                }
            }failure:^(NSString *error) {
                NSLog(@"%@",error);
            }];
        }
            break;
        
     
        case FACEBOOK:{
        

           [FBSession openActiveSessionWithReadPermissions:@[@"public_profile", @"user_friends", @"email",@"user_photos",@"read_friendlists"]
                                               allowLoginUI:YES
                                          completionHandler:
             ^(FBSession *session, FBSessionState state, NSError *error) {
                 NSLog(@"%@",error);
                 [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                     if (!error) {

                         __block NSString* ID = (NSString*)[((NSDictionary*)result) objectForKey:@"id"];
                         [FBRequestConnection startWithGraphPath:@"oauth/access_token?client_id=786246194803237&client_secret=1de05b8a3870b19c64c2fb573fece395&grant_type=client_credentials"
                         
                                               completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                                                   if (!error) {
                                                       
                                                       //NSLog(@"user events: %@", result);
                                                       NSDictionary* dict = [NSDictionary dictionaryWithDictionary:result];
                                                       NSString* tokenStr = (NSString*)[dict objectForKey:@"FACEBOOK_NON_JSON_RESULT"];
                                                       tokenStr = [tokenStr substringFromIndex:13];
                                                       NSDictionary* param = @{
                                                                               @"id" :ID,
                                                                               @"access_token" : tokenStr,
                                                                               @"timezone" : timezone
                                                                               };
                                                       [self getData:[[BASManager sharedInstance] formatRequest:@"REGISTER" withParam:param] success:^(NSDictionary* responseObject) {
                                                           if([responseObject isKindOfClass:[NSDictionary class]]){
                                                             //  NSLog(@"%@",responseObject);
                                                               NSArray* userInfo = (NSArray*)[responseObject objectForKey:@"param"];
                                                               NSDictionary* dict = (NSDictionary*)[userInfo objectAtIndex:0];
                                                              
                                                               if(dict.allKeys.count == 1){
                                                                   [self showAlertViewWithMess:@"Ошибка авторизации!"];
                                                                   return ;
                                                               } else{
                                                                   app.userInfo = (NSDictionary*)[userInfo objectAtIndex:0];
                                                                   NSNumber* isPurches =(NSNumber*) [ dict objectForKey:@"isPurches"];
                                                                   if ([isPurches integerValue] == 1)
                                                                       app.isPurchaise = YES ;
                                                                   else
                                                                       app.isPurchaise = NO;
                                                                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                                                                   [userDefaults  setObject:[dict objectForKey:@"purchase_date"] forKey:@"isPurchaiseDate"];
                                                                   [userDefaults  setObject:[dict objectForKey:@"term"] forKey:@"isPurchaiseTermin"];
                                                                   [userDefaults  setBool:app.isPurchaise forKey:@"isPurchaise"];
                                                                   [userDefaults  setObject:(NSString*)[app.userInfo objectForKey:@"login"] forKey:@"login"];
                                                                   [userDefaults  setObject:(NSString*)[app.userInfo objectForKey:@"pass"] forKey:@"password"];
                                                                   [userDefaults  setObject:app.userInfo forKey:@"userInfo"];
                                                                   [userDefaults  setObject:[NSNumber numberWithInt:app.loginType] forKey:@"loginType"];
                                                                   [userDefaults  synchronize];
                                                                   app.login = (NSString*)[app.userInfo objectForKey:@"login"];
                                                                   app.pass = (NSString*)[app.userInfo objectForKey:@"pass"];
                                                         
                                                                   [self checkPurshes];
                                                                   
                                                                 
                                                               }
                                                               
                                                           }
                                                       }failure:^(NSString *error) {
                                                           NSLog(@"%@",error);
                                                       }];
                                                   }
                                               }];
                     }
                 }];
                 
             }];
        
        }
            break;
        
            
        default:
            break;
    }

}


-(void) checkPurshes {
    TheApp;
     NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString* date = (NSString*)[userDefaults objectForKey:@"isPurchaiseDate"];
    NSNumber* term = (NSNumber*)[userDefaults objectForKey:@"isPurchaiseTermin"];
    app.isLogin = YES;
    NSDictionary* param;
    if (date!=nil && term !=nil){
                    param = @{
                            @"date" :date,
                            @"term" : term
                            };
        }
    [self getData:[[BASManager sharedInstance] formatRequest:@"SETPURCHES" withParam:param] success:^(NSDictionary* responseObject) {
         //NSLog(@"%@",responseObject);
        NSNumber* isPurches = [app.userInfo objectForKey:@"isPurches"];
        if ([isPurches integerValue] >= 0 || [term integerValue] != 0) {
            isPurches =(NSNumber*)[[[responseObject objectForKey:@"param"]objectAtIndex:0]objectForKey:@"isPurches"];
        }
       
        switch ([isPurches integerValue])
        {
      
                
            case -1:
            {
                [userDefaults removeObjectForKey:@"isPurchaise"];
                [userDefaults removeObjectForKey:@"isPurchaiseTermin"];
                [userDefaults removeObjectForKey:@"isPurchaiseDate"];
                [userDefaults synchronize];
                app.isPurchaise = NO;
                app.navigationController = [[UINavigationController alloc]initWithRootViewController:app.mainController];
                [app.window setRootViewController:app.navigationController];
                break;
            }
            case 0:
            {
            
                [[BASManager sharedInstance]showAlertViewWithMess:@"Ваша подписка истекла! Пожалуйста приобретите подписку!"];
                [userDefaults removeObjectForKey:@"isPurchaise"];
                [userDefaults removeObjectForKey:@"isPurchaiseTermin"];
                [userDefaults removeObjectForKey:@"isPurchaiseDate"];
                [userDefaults synchronize];
                app.isPurchaise = NO;
                app.navigationController = [[UINavigationController alloc]initWithRootViewController:app.mainController];
                [app.window setRootViewController:app.navigationController];
                break;
            }
            case 1:
            {
            
                app.isPurchaise = YES;
                NSDictionary* param = @{
                                    @"push_token" :app.pushToken,
                                    };
                [self getData:[[BASManager sharedInstance] formatRequest:@"SETPUSHTOKEN" withParam:param] success:^(NSDictionary* responseObject) {
                //  NSLog(@"%@",responseObject);
                app.chatController = [[BASChatViewController alloc]init];
                app.navigationController = [[UINavigationController alloc]initWithRootViewController:app.chatController];
                [app.window setRootViewController:app.navigationController];
                }failure:^(NSString *error) {
                    NSLog(@"%@",error);
                }];
                break;
            }
        }
        
    }failure:^(NSString *error) {
        NSLog(@"%@",error);
    }];

}



- (void)LogOut{
   
}



#pragma mark - SRWebSocketDelegate

- (void)webSocketDidOpen:(SRWebSocket *)webSocket;
{
    TheApp;
    NSLog(@"Websocket Connected");
    NSLog(@"%@,  %@",app.login,app.pass);
    if(isClose){
        
        NSDictionary* param = @{
                                        @"login" :app.login,
                                        @"pass" : app.pass
                                        };
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                 @"AUTH",@"command",
                 param,@"param",
                 nil];
        NSMutableData* mutData = [NSMutableData dataWithData:[NSJSONSerialization dataWithJSONObject:param options:0 error:nil]];
        [_webSocket send:mutData];
        sleep(3);
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                              _curCommand,@"command",
                              _curDict,@"param",
                              nil];
        mutData = [NSMutableData dataWithData:[NSJSONSerialization dataWithJSONObject:param options:0 error:nil]];
        [_webSocket send:mutData];
        [app showIndecator:NO withView:app.window];
        isClose = NO;
    }
    isConnect = YES;
    
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error;
{
    TheApp;
    NSLog(@":( Websocket Failed With Error %@", error);
    isConnect = NO;
    if (error.code == 60 || error.code == 61)  // timeout
        [self showAlertViewWithMess:@"Отсутствует связь с сервером! Повторите соединение через несколько минут!"];
    
    if (error.code == 51) //no internet
        [self showAlertViewWithMess:@"Отсутствует интернет соединение! Повторите соединение позже!"];
    
   if( _failure!= nil)
       _failure(error.localizedDescription);
        
    [app showIndecator:NO withView:app.window];

}
- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload{
    //NSLog(@"pong");
    [webSocket sendPing:nil];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message;
{
    //NSLog(@"Received \"%@\"", message);
    
    
    NSData* responceData = [message dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:responceData options:kNilOptions error:nil];
    NSDictionary* dict = (NSDictionary*)json;
    
    NSNumber* coming = (NSNumber*)[dict objectForKey:@"coming"];
    if([coming integerValue] == 1){
        _success(dict);
    } else {
        if([_delegate respondsToSelector:@selector(icommingMessage:withObject:)]){
            [_delegate icommingMessage:self withObject:dict];
        }
    }
    
    
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean;
{
    NSLog(@"WebSocket closed %u, %@",code,reason);
    isConnect = NO;
    if(code == 1010){
        [self showAlertViewWithMess:@"Был осуществлен вход с другого устройства! Перезапустите приложение!"];
    }
    else if (code!=1063){
        [self showAlertViewWithMess:@"Отсутствует связь с сервером! Перезапустите приложение!"];
    }
    
    if(_failure!=nil)
        _failure(reason);
    _webSocket = nil;
}

- (void)showAlertViewWithMess:(NSString *)mess
{
    TheApp;
    if(!app.isShowMessage){
        app.isShowMessage = YES;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:mess delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.cancelButtonIndex == buttonIndex){
        TheApp;
        app.isShowMessage = NO;
       // if(!isConnect)
           // exit(0);
    }
}
-(NSString *)stringByStrippingHTML:(NSString*)str
{
    NSRange r;
    while ((r = [str rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location!= NSNotFound)
    {
        str = [str stringByReplacingCharactersInRange:r withString:@""];
    }
    return str;
}



@end
