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
   
    self.webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://195.138.68.2:8887/"]]];
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
- (void)LogIn{
    
    TheApp;
    
    NSDateFormatter *objDateFormatter = [[NSDateFormatter alloc] init];
    [objDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *timezone = [objDateFormatter stringFromDate:[NSDate date]];
    
    switch (app.loginType) {
        case LOCAL:{

            __block NSDictionary* param = @{
                                    @"login" :app.login,
                                    @"pass" : app.pass,
                                    @"timezone" : timezone
                                    };
            [self getData:[[BASManager sharedInstance] formatRequest:@"AUTH" withParam:param] success:^(NSDictionary* responseObject) {
                if([responseObject isKindOfClass:[NSDictionary class]]){
                    NSLog(@"%@",responseObject);
                    
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
                   
                    
                    NSDictionary* param = @{
                                            @"push_token" :app.pushToken,
                                            };
                    [self getData:[[BASManager sharedInstance] formatRequest:@"SETPUSHTOKEN" withParam:param] success:^(NSDictionary* responseObject) {
                        NSLog(@"%@",responseObject);
                        app.userInfo = [NSDictionary dictionaryWithDictionary:dict];
                        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                        [userDefaults removeObjectForKey:@""];
                        [userDefaults removeObjectForKey:@""];
                        [userDefaults removeObjectForKey:@""];
                        [userDefaults synchronize];
                        [userDefaults setObject:app.login forKey:@"login"];
                        [userDefaults setObject:app.pass forKey:@"password"];
                        [userDefaults setObject:app.userInfo forKey:@"userInfo"];
                        [userDefaults setObject:[NSNumber numberWithInt:app.loginType] forKey:@"loginType"];
                        [userDefaults synchronize];
                        
                        NSNumber* isPurches = (NSNumber*)[dict objectForKey:@"isPurches"];
                        
                        if([isPurches integerValue] == 0){
                            [[BASManager sharedInstance]showAlertViewWithMess:@"Ваша подписка истекла! Пожалуйста приобретите подписку!"];
                            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                            [defaults removeObjectForKey:@"isPurchaise"];
                            [defaults removeObjectForKey:@"isPurchaiseTermin"];
                            [defaults removeObjectForKey:@"isPurchaiseDate"];
                            [defaults synchronize];
                            app.isPurchaise = NO;
                            app.navigationController = [[UINavigationController alloc]initWithRootViewController:app.mainController];
                            [app.window setRootViewController:app.navigationController];
                        } else {
                            app.chatController = [[BASChatViewController alloc]init];
                            app.navigationController = [[UINavigationController alloc]initWithRootViewController:app.chatController];
                            [app.window setRootViewController:app.navigationController];
                        }
                        
                        
                    }failure:^(NSString *error) {
                        NSLog(@"%@",error);
                    }];

                    
                    
 
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
                                                               NSLog(@"%@",responseObject);
                                                               NSArray* userInfo = (NSArray*)[responseObject objectForKey:@"param"];
                                                               NSDictionary* dict = (NSDictionary*)[userInfo objectAtIndex:0];
                                                              
                                                               if(dict.allKeys.count == 1){
                                                                   [self showAlertViewWithMess:@"Ошибка авторизации!"];
                                                                   return ;
                                                               } else{
                                                                   app.userInfo = (NSDictionary*)[userInfo objectAtIndex:0];
                                                                   NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                                                                   [userDefaults removeObjectForKey:@""];
                                                                    [userDefaults removeObjectForKey:@""];
                                                                    [userDefaults removeObjectForKey:@""];
                                                                   [userDefaults synchronize];
                                                                   [userDefaults setObject:(NSString*)[app.userInfo objectForKey:@"login"] forKey:@"login"];
                                                                   [userDefaults setObject:(NSString*)[app.userInfo objectForKey:@"pass"] forKey:@"password"];
                                                                   [userDefaults setObject:app.userInfo forKey:@"userInfo"];
                                                                   [userDefaults setObject:[NSNumber numberWithInt:app.loginType] forKey:@"loginType"];
                                                                   [userDefaults synchronize];
                                                                   app.login = (NSString*)[app.userInfo objectForKey:@"login"];
                                                                   app.pass = (NSString*)[app.userInfo objectForKey:@"pass"];
                                                         
                                                                   NSNumber* isPurches = (NSNumber*)[dict objectForKey:@"isPurches"];
                                                                   if([isPurches integerValue] == -1){
                                                                       NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                                                       NSString* date = (NSString*)[defaults objectForKey:@"isPurchaiseDate"];
                                                                       NSNumber* term = (NSNumber*)[defaults objectForKey:@"isPurchaiseTermin"];
                                                                      NSDictionary* param = @{
                                                                                 @"date" :date,
                                                                                 @"term" : term
                                                                                 };
                                                                       [self getData:[[BASManager sharedInstance] formatRequest:@"SETPURCHES" withParam:param] success:^(NSDictionary* responseObject) {
                                                                           NSLog(@"%@",responseObject);
                                                                           NSDictionary* param = @{
                                                                                                   @"push_token" :app.pushToken,
                                                                                                   };
                                                                           [self getData:[[BASManager sharedInstance] formatRequest:@"SETPUSHTOKEN" withParam:param] success:^(NSDictionary* responseObject) {
                                                                               NSLog(@"%@",responseObject);
                                                                               app.chatController = [[BASChatViewController alloc]init];
                                                                               app.navigationController = [[UINavigationController alloc]initWithRootViewController:app.chatController];
                                                                               [app.window setRootViewController:app.navigationController];
                                                                           }failure:^(NSString *error) {
                                                                               NSLog(@"%@",error);
                                                                           }];
                                                                         

                                                                       }failure:^(NSString *error) {
                                                                           NSLog(@"%@",error);
                                                                       }];
                                                                   }  else {
                                                                       app.chatController = [[BASChatViewController alloc]init];
                                                                       app.navigationController = [[UINavigationController alloc]initWithRootViewController:app.chatController];
                                                                       [app.window setRootViewController:app.navigationController];
                                                                   }

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
- (void)LogOut{
   
}



#pragma mark - SRWebSocketDelegate

- (void)webSocketDidOpen:(SRWebSocket *)webSocket;
{
    TheApp;
    NSLog(@"Websocket Connected");
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
    NSLog(@":( Websocket Failed With Error %@", error);
    isConnect = NO;
    if (error.code == 60)  // timeout
        [self showAlertViewWithMess:@"Отсутствует связь с сервером! Перезапустите приложение!"];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message;
{
    NSLog(@"Received \"%@\"", message);
    
    
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
    NSLog(@"WebSocket closed");
    isConnect = NO;
    [self showAlertViewWithMess:@"Отсутствует связь с сервером! Перезапустите приложение!"];

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
