//
//  BASChatViewController.m
//  ChatDieta
//
//  Created by Sergey on 04.11.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASChatViewController.h"
#import "ThreadCell.h"

@interface BASChatViewController (){
    NSInteger nutritionistState;
    NSInteger supportState;
}

@property (nonatomic, strong) NSMutableArray *messagesNat;
@property (nonatomic, strong) NSMutableArray *messagesSupport;
@property (nonatomic, strong) NSArray *messages;
@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,strong) UIImageView* bgTextView;
@property (nonatomic,strong) UITextView* textField;
@property (nonatomic,strong) UIButton* sendButton;
@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) NSMutableArray* allEmojis;
@end

@implementation BASChatViewController

- (id)init{
    self = [super init];
    if(self){
        /* self.allEmojis = [[NSMutableArray alloc] initWithObjects:@"😄", @"😃", @"😀", @"😊", @"☺️", @"😉", @"😍", @"😘", @"😚", @"😗", @"😙", @"😜", @"😝", @"😛", @"😳", @"😁", @"😔", @"😌", @"😒", @"😞", @"😣", @"😢", @"😂", @"😭", @"😪", @"😥", @"😰", @"😅", @"😓", @"😩", @"😫", @"😨", @"😱", @"😠", @"😡", @"😤", @"😖", @"😆", @"😋", @"😷", @"😎", @"😴", @"😵", @"😲", @"😟", @"😦", @"😧", @"😈", @"👿", @"😮", @"😬", @"😐", @"😕", @"😯", @"😶", @"😇", @"😏", @"😑", @"👲", @"👳", @"👮", @"👷", @"💂", @"👶", @"👦", @"👧", @"👨", @"👩", @"👴", @"👵", @"👱", @"👼", @"👸", @"😺", @"😸", @"😻", @"😽", @"😼", @"🙀", @"😿", @"😹", @"😾", @"👹", @"👺", @"🙈", @"🙉", @"🙊", @"💀", @"👽", @"💩", @"🔥", @"✨", @"🌟", @"💫", @"💥", @"💢", @"💦", @"💧", @"💤", @"💨", @"👂", @"👀", @"👃", @"👅", @"👄", @"👍", @"👎", @"👌", @"👊", @"✊", @"✌️", @"👋", @"✋", @"👐", @"👆", @"👇", @"👉", @"👈", @"🙌", @"🙏", @"☝️", @"👏", @"💪", @"🚶", @"🏃", @"💃", @"👫", @"👪", @"👬", @"👭", @"💏", @"💑", @"👯", @"🙆", @"🙅", @"💁", @"🙋", @"💆", @"💇", @"💅", @"👰", @"🙎", @"🙍", @"🙇", @"🎩", @"👑", @"👒", @"👟", @"👞", @"👡", @"👠", @"👢", @"👕", @"👔", @"👚", @"👗", @"🎽", @"👖", @"👘", @"👙", @"💼", @"👜", @"👝", @"👛", @"👓", @"🎀", @"🌂", @"💄", @"💛", @"💙", @"💜", @"💚", @"❤️", @"💔", @"💗", @"💓", @"💕", @"💖", @"💞", @"💘", @"💌", @"💋", @"💍", @"💎", @"👤", @"👥", @"💬", @"👣", @"💭", @"🐶", @"🐺", @"🐱", @"🐭", @"🐹", @"🐰", @"🐸", @"🐯", @"🐨", @"🐻", @"🐷", @"🐽", @"🐮", @"🐗", @"🐵", @"🐒", @"🐴", @"🐑", @"🐘", @"🐼", @"🐧", @"🐦", @"🐤", @"🐥", @"🐣", @"🐔", @"🐍", @"🐢", @"🐛", @"🐝", @"🐜", @"🐞", @"🐌", @"🐙", @"🐚", @"🐠", @"🐟", @"🐬", @"🐳", @"🐋", @"🐄", @"🐏", @"🐀", @"🐃", @"🐅", @"🐇", @"🐉", @"🐎", @"🐐", @"🐓", @"🐕", @"🐖", @"🐁", @"🐂", @"🐲", @"🐡", @"🐊", @"🐫", @"🐪", @"🐆", @"🐈", @"🐩", @"🐾", @"💐", @"🌸", @"🌷", @"🍀", @"🌹", @"🌻", @"🌺", @"🍁", @"🍃", @"🍂", @"🌿", @"🌾", @"🍄", @"🌵", @"🌴", @"🌲", @"🌳", @"🌰", @"🌱", @"🌼", @"🌐", @"🌞", @"🌝", @"🌚", @"🌑", @"🌒", @"🌓", @"🌔", @"🌕", @"🌖", @"🌗", @"🌘", @"🌜", @"🌛", @"🌙", @"🌍", @"🌎", @"🌏", @"🌋", @"🌌", @"🌠", @"⭐️", @"☀️", @"⛅️", @"☁️", @"⚡️", @"☔️", @"❄️", @"⛄️", @"🌀", @"🌁", @"🌈", @"🌊", @"🎍", @"💝", @"🎎", @"🎒", @"🎓", @"🎏", @"🎆", @"🎇", @"🎐", @"🎑", @"🎃", @"👻", @"🎅", @"🎄", @"🎁", @"🎋", @"🎉", @"🎊", @"🎈", @"🎌", @"🔮", @"🎥", @"📷", @"📹", @"📼", @"💿", @"📀", @"💽", @"💾", @"💻", @"📱", @"☎️", @"📞", @"📟", @"📠", @"📡", @"📺", @"📻", @"🔊", @"🔉", @"🔈", @"🔇", @"🔔", @"🔕", @"📢", @"📣", @"⏳", @"⌛️", @"⏰", @"⌚️", @"🔓", @"🔒", @"🔏", @"🔐", @"🔑", @"🔎", @"💡", @"🔦", @"🔆", @"🔅", @"🔌", @"🔋", @"🔍", @"🛁", @"🛀", @"🚿", @"🚽", @"🔧", @"🔩", @"🔨", @"🚪", @"🚬", @"💣", @"🔫", @"🔪", @"💊", @"💉", @"💰", @"💴", @"💵", @"💷", @"💶", @"💳", @"💸", @"📲", @"📧", @"📥", @"📤", @"✉️", @"📩", @"📨", @"📯", @"📫", @"📪", @"📬", @"📭", @"📮", @"📦", @"📝", @"📄", @"📃", @"📑", @"📊", @"📈", @"📉", @"📜", @"📋", @"📅", @"📆", @"📇", @"📁", @"📂", @"✂️", @"📌", @"📎", @"✒️", @"✏️", @"📏", @"📐", @"📕", @"📗", @"📘", @"📙", @"📓", @"📔", @"📒", @"📚", @"📖", @"🔖", @"📛", @"🔬", @"🔭", @"📰", @"🎨", @"🎬", @"🎤", @"🎧", @"🎼", @"🎵", @"🎶", @"🎹", @"🎻", @"🎺", @"🎷", @"🎸", @"👾", @"🎮", @"🃏", @"🎴", @"🀄️", @"🎲", @"🎯", @"🏈", @"🏀", @"⚽️", @"⚾️", @"🎾", @"🎱", @"🏉", @"🎳", @"⛳️", @"🚵", @"🚴", @"🏁", @"🏇", @"🏆", @"🎿", @"🏂", @"🏊", @"🏄", @"🎣", @"☕️", @"🍵", @"🍶", @"🍼", @"🍺", @"🍻", @"🍸", @"🍹", @"🍷", @"🍴", @"🍕", @"🍔", @"🍟", @"🍗", @"🍖", @"🍝", @"🍛", @"🍤", @"🍱", @"🍣", @"🍥", @"🍙", @"🍘", @"🍚", @"🍜", @"🍲", @"🍢", @"🍡", @"🍳", @"🍞", @"🍩", @"🍮", @"🍦", @"🍨", @"🍧", @"🎂", @"🍰", @"🍪", @"🍫", @"🍬", @"🍭", @"🍯", @"🍎", @"🍏", @"🍊", @"🍋", @"🍒", @"🍇", @"🍉", @"🍓", @"🍑", @"🍈", @"🍌", @"🍐", @"🍍", @"🍠", @"🍆", @"🍅", @"🌽", @"🏠", @"🏡", @"🏫", @"🏢", @"🏣", @"🏥", @"🏦", @"🏪", @"🏩", @"🏨", @"💒", @"⛪️", @"🏬", @"🏤", @"🌇", @"🌆", @"🏯", @"🏰", @"⛺️", @"🏭", @"🗼", @"🗾", @"🗻", @"🌄", @"🌅", @"🌃", @"🗽", @"🌉", @"🎠", @"🎡", @"⛲️", @"🎢", @"🚢", @"⛵️", @"🚤", @"🚣", @"⚓️", @"🚀", @"✈️", @"💺", @"🚁", @"🚂", @"🚊", @"🚉", @"🚞", @"🚆", @"🚄", @"🚅", @"🚈", @"🚇", @"🚝", @"🚋", @"🚃", @"🚎", @"🚌", @"🚍", @"🚙", @"🚘", @"🚗", @"🚕", @"🚖", @"🚛", @"🚚", @"🚨", @"🚓", @"🚔", @"🚒", @"🚑", @"🚐", @"🚲", @"🚡", @"🚟", @"🚠", @"🚜", @"💈", @"🚏", @"🎫", @"🚦", @"🚥", @"⚠️", @"🚧", @"🔰", @"⛽️", @"🏮", @"🎰", @"♨️", @"🗿", @"🎪", @"🎭", @"📍", @"🚩", @"🇯🇵", @"🇰🇷", @"🇩🇪", @"🇨🇳", @"🇺🇸", @"🇫🇷", @"🇪🇸", @"🇮🇹", @"🇷🇺", @"🇬🇧", @"1⃣", @"2⃣", @"3⃣", @"4⃣", @"5⃣", @"6⃣", @"7⃣", @"8⃣", @"9⃣", @"0⃣", @"1️⃣", @"2️⃣", @"3️⃣", @"4️⃣", @"5️⃣", @"6️⃣", @"7️⃣", @"8️⃣", @"9️⃣", @"0️⃣", @"🔟", @"🔢", @"#️⃣", @"🔣", @"⬆️", @"⬇️", @"⬅️", @"➡️", @"🔠", @"🔡", @"🔤", @"↗️", @"↖️", @"↘️", @"↙️", @"↔️", @"↕️", @"🔄", @"◀️", @"▶️", @"🔼", @"🔽", @"↩️", @"↪️", @"ℹ️", @"⏪", @"⏩", @"⏫", @"⏬", @"⤵️", @"⤴️", @"🆗", @"🔀", @"🔁", @"🔂", @"🆕", @"🆙", @"🆒", @"🆓", @"🆖", @"📶", @"🎦", @"🈁", @"🈯️", @"🈳", @"🈵", @"🈴", @"🈲", @"🉐", @"🈹", @"🈺", @"🈶", @"🈚️", @"🚻", @"🚹", @"🚺", @"🚼", @"🚾", @"🚰", @"🚮", @"🅿️", @"♿️", @"🚭", @"🈷", @"🈸", @"🈂", @"Ⓜ️", @"🛂", @"🛄", @"🛅", @"🛃", @"🉑", @"㊙️", @"㊗️", @"🆑", @"🆘", @"🆔", @"🚫", @"🔞", @"📵", @"🚯", @"🚱", @"🚳", @"🚷", @"🚸", @"⛔️", @"✳️", @"❇️", @"❎", @"✅", @"✴️", @"💟", @"🆚", @"📳", @"📴", @"🅰", @"🅱", @"🆎", @"🅾", @"💠", @"➿", @"♻️", @"♈️", @"♉️", @"♊️", @"♋️", @"♌️", @"♍️", @"♎️", @"♏️", @"♐️", @"♑️", @"♒️", @"♓️", @"⛎", @"🔯", @"🏧", @"💹", @"💲", @"💱", @"©", @"®", @"™", @"❌", @"‼️", @"⁉️", @"❗️", @"❓", @"❕", @"❔", @"⭕️", @"🔝", @"🔚", @"🔙", @"🔛", @"🔜", @"🔃", @"🕛", @"🕧", @"🕐", @"🕜", @"🕑", @"🕝", @"🕒", @"🕞", @"🕓", @"🕟", @"🕔", @"🕠", @"🕕", @"🕖", @"🕗", @"🕘", @"🕙", @"🕚", @"🕡", @"🕢", @"🕣", @"🕤", @"🕥", @"🕦", @"✖️", @"➕", @"➖", @"➗", @"♠️", @"♥️", @"♣️", @"♦️", @"💮", @"💯", @"✔️", @"☑️", @"🔘", @"🔗", @"➰", @"〰", @"〽️", @"🔱", @"◼️", @"◻️", @"◾️", @"◽️", @"▪️", @"▫️", @"🔺", @"🔲", @"🔳", @"⚫️", @"⚪", @"🔴", @"🔵", @"🔻", @"⬜️", @"⬛️", @"🔶", @"🔷", @"🔸", @"🔹", nil];*/
    }
    return  self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    TheApp;
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    [self.view addSubview:app.tabView];
    app.tabView.delegate = self;
    app.messageType = NUTRIT;
    app.tabView.tabIndex = 0;
    
    self.messages = [NSMutableArray new];
    self.messagesNat = [NSMutableArray new];
    self.messagesSupport = [NSMutableArray new];

    
    CGRect frame = [[UIScreen mainScreen]bounds];

    UIView* headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 20.f)];
    [headerView setBackgroundColor:[UIColor clearColor]];
    
    self.scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,app.tabView.frame.origin.y)];
    
    _scrollview.showsHorizontalScrollIndicator = NO;
    _scrollview.showsVerticalScrollIndicator = NO;
    [_scrollview setBounces:NO];
    [_scrollview setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview: _scrollview];
    
    
    
    UIImage *image = [UIImage imageNamed:@"cell"];
    self.bgTextView = [[UIImageView alloc]initWithImage:image];
    [_bgTextView setFrame:CGRectMake(5.f, self.view.bounds.size.height - image.size.height - app.navigationController.navigationBar.frame.size.height - 20.f - 10.f - app.tabView.frame.size.height  , image.size.width, image.size.height)];
    if(IS_IPHONE_6){
        [_bgTextView setFrame:CGRectMake(5.f, self.view.bounds.size.height - image.size.height - app.navigationController.navigationBar.frame.size.height - 20.f - 10.f - app.tabView.frame.size.height  , image.size.width + 50.f, image.size.height)];
    } else if(IS_IPHONE_6_PLUS){
        [_bgTextView setFrame:CGRectMake(5.f, self.view.bounds.size.height - image.size.height - app.navigationController.navigationBar.frame.size.height - 20.f - 10.f - app.tabView.frame.size.height  , image.size.width + 90.f, image.size.height)];
    }
    [_scrollview addSubview:_bgTextView];
    
    image = [UIImage imageNamed:@"separator"];
    UIImageView * separ = [[UIImageView alloc]initWithImage:image];
    [separ setFrame:CGRectMake(0.f, _bgTextView.frame.origin.y - 10.f, self.view.bounds.size.width, image.size.height)];
    [_scrollview addSubview:separ];
    
    
    image = [UIImage imageNamed:@"button_send"];
    self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sendButton setBackgroundColor:[UIColor clearColor]];
    [_sendButton  setImage:image forState:UIControlStateNormal];
    [_sendButton setFrame:CGRectMake(_bgTextView.frame.origin.x + _bgTextView.frame.size.width, _bgTextView.frame.origin.y, frame.size.width - (_bgTextView.frame.origin.x + _bgTextView.frame.size.width), _bgTextView.frame.size.height)];
    [_sendButton addTarget:self action:@selector(sendClicked) forControlEvents:UIControlEventTouchUpInside];
    [_scrollview addSubview:_sendButton];
    
    self.textField = [[UITextView alloc]init];
    [_textField setBackgroundColor:[UIColor clearColor]];
    _textField.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.f];
    _textField.autocorrectionType = UITextAutocorrectionTypeNo;
    _textField.keyboardType = UIKeyboardTypeDefault;
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.delegate = (id) self;
  
    _textField.textColor = [UIColor colorWithRed:34.f/255.f green:141.f/255.f blue:221.f/255.f alpha:1.0];
    [_textField setFrame:CGRectMake(_bgTextView.frame.origin.x + 5, _bgTextView.frame.origin.y + 4.f, _bgTextView.frame.size.width - 10.f, _bgTextView.frame.size.height - 6.f)];
    [_scrollview addSubview:_textField];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x + 10.f, self.view.bounds.origin.y , self.view.bounds.size.width - 20.f, _bgTextView.frame.origin.y - 10.f) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tableView setShowsHorizontalScrollIndicator:NO];
    [_tableView setShowsVerticalScrollIndicator:NO];
    [_tableView setTableHeaderView:headerView];
    [_scrollview addSubview:_tableView];
    [_tableView reloadData];
    
    

}
- (void)viewDidAppear:(BOOL)animated{
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [BASManager sharedInstance].delegate = self;
    [self setupNavBtn:BASETYPE];
    [self customTitleImage];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self getData];
    
}
- (void)viewWillDisappear:(BOOL)animated{

    [_textField resignFirstResponder];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [super viewWillDisappear:animated];
    
}
- (void)getData{
    TheApp;
    
    [[BASManager sharedInstance] getData:[[BASManager sharedInstance] formatRequest:@"GETMESSAGES" withParam:nil] success:^(NSDictionary* responseObject) {
        if([responseObject isKindOfClass:[NSDictionary class]]){
            NSLog(@"%@",responseObject);
            NSDictionary* param = @{@"level":[NSNumber numberWithInt:(int)app.tabView.tabIndex + 1]
                      };
            [[BASManager sharedInstance] getData:[[BASManager sharedInstance] formatRequest:@"SETMESSAGESREAD" withParam:param] success:^(NSDictionary* responseObject) {
                if([responseObject isKindOfClass:[NSDictionary class]]){
                    NSLog(@"%@",responseObject);
                    NSArray* userInfo = (NSArray*)[responseObject objectForKey:@"param"];
                    NSDictionary* dict = (NSDictionary*)[userInfo objectAtIndex:0];
                    
                    [self.messagesNat removeAllObjects];
                    [self.messagesNat addObjectsFromArray:(NSArray*)[dict objectForKey:@"nutritionist"]];
                    
                    [self.messagesSupport removeAllObjects];
                    [self.messagesSupport addObjectsFromArray:(NSArray*)[dict objectForKey:@"support"]];
                    
                    NSNumber* support_count = (NSNumber*)[dict objectForKey:@"support_count"];
                    NSNumber* nutritionist_count = (NSNumber*)[dict objectForKey:@"nutritionist_count"];
                    nutritionistState = [nutritionist_count integerValue];
                    supportState = [support_count integerValue];
                    NSNumber* nutritionist_status = (NSNumber*)[dict objectForKey:@"nutritionist_status"];
                    [app.tabView showState:0 withState:(BOOL)[nutritionist_status integerValue]];
                    NSNumber* support_status = (NSNumber*)[dict objectForKey:@"support_status"];
                    [app.tabView showState:1 withState:(BOOL)[support_status integerValue]];
                    
                    if(app.tabView.tabIndex == 0){
                        self.messages = [NSArray arrayWithArray:_messagesNat];
                        
                        [app.tabView showNoticesCount:supportState withSatate:NO];
                        
                    } else {
                        self.messages = [NSArray arrayWithArray:_messagesSupport];
                        [app.tabView showNoticesCount:nutritionistState withSatate:YES];
                        
                    }
                    [_tableView reloadData];
                    if(_messages.count > 0){
                        [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_messages.count -1] animated:YES scrollPosition:UITableViewScrollPositionBottom];
                    }
                }
            }failure:^(NSString *error) {
                NSLog(@"%@",error);
            }];

        }
    }failure:^(NSString *error) {
       [[BASManager sharedInstance] showAlertViewWithMess:@"Ошибка при передаче данных! Перезапустите приложение!"];
    }];
}
- (void)sendClicked{ 
    TheApp;
    [_textField resignFirstResponder];
    
    if([_textField.text isEqualToString:@""]){
        return;
    }
    

    __block NSDictionary* param = @{@"message":_textField.text,
                                    @"level":[NSNumber numberWithInt:(int)app.tabView.tabIndex + 1]
                                    };
    
    

    [_textField resignFirstResponder];
    [app showIndecator:YES withView:self.view];
    [_sendButton setEnabled:NO];
    [_textField setEditable:NO];
        
    
    [[BASManager sharedInstance] getData:[[BASManager sharedInstance] formatRequest:@"SENDMESSAGE" withParam:param] success:^(NSDictionary* responseObject) {
        if([responseObject isKindOfClass:[NSDictionary class]]){
            NSLog(@"%@",responseObject);
            [app showIndecator:NO withView:self.view];
            [_sendButton setEnabled:YES];
            [_textField setEditable:YES];
            if ([[responseObject objectForKey:@"command"] isEqualToString:@"BADREQUEST"]) {
                [[BASManager sharedInstance] showAlertViewWithMess:@"Превышена максимальная длина сообщения"];
            }
            else{
                NSArray* userInfo = (NSArray*)[responseObject objectForKey:@"param"];
                NSDictionary* dict = (NSDictionary*)[userInfo objectAtIndex:0];
            
                [self.messagesNat removeAllObjects];
                [self.messagesNat addObjectsFromArray:(NSArray*)[dict objectForKey:@"nutritionist"]];
            
                [self.messagesSupport removeAllObjects];
                [self.messagesSupport addObjectsFromArray:(NSArray*)[dict objectForKey:@"support"]];
            
                NSNumber* support_count = (NSNumber*)[dict objectForKey:@"support_count"];
                NSNumber* nutritionist_count = (NSNumber*)[dict objectForKey:@"nutritionist_count"];
                nutritionistState = [nutritionist_count integerValue];
                supportState = [support_count integerValue];
                NSNumber* nutritionist_status = (NSNumber*)[dict objectForKey:@"nutritionist_status"];
                [app.tabView showState:0 withState:(BOOL)[nutritionist_status integerValue]];
                NSNumber* support_status = (NSNumber*)[dict objectForKey:@"support_status"];
                [app.tabView showState:1 withState:(BOOL)[support_status integerValue]];
            
                if(app.tabView.tabIndex == 0){
                    self.messages = [NSArray arrayWithArray:_messagesNat];
                
                [app.tabView showNoticesCount:supportState withSatate:NO];
                
                } else {
                    self.messages = [NSArray arrayWithArray:_messagesSupport];
                    [app.tabView showNoticesCount:nutritionistState withSatate:YES];
                
                }
                [_tableView reloadData];
                if(_messages.count > 0){
                    [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_messages.count -1] animated:YES scrollPosition:UITableViewScrollPositionBottom];
                }
                _textField.text = @"";
            }
 
        }
    }failure:^(NSString *error) {
        [_sendButton setEnabled:YES];
        [_textField setEditable:YES];
        if ([error isEqualToString:@"INTERNALSERVERERROR"]){
            [[BASManager sharedInstance] showAlertViewWithMess:@"Ошибка при передаче данных! Перезапустите приложение!"];
        }
    }];

    
}

#pragma mark -
#pragma mark UITextField delegate methods
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"] && [_textField.text isEqualToString:@""]) {
        [textView resignFirstResponder];
       
        return NO;
    }
   
    
    if ([textView isFirstResponder]) {
        if ([[[textView textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textView textInputMode] primaryLanguage]) {
            return NO;
        }
    }
   
   
    
    return YES;
}
#pragma mark -
#pragma mark NSNotification
- (void)keyboardWillShow:(NSNotification*)notification
{
    TheApp;
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    
    CGSize scrollSize = _scrollview.contentSize;
    scrollSize.height += keyboardFrameBeginRect.size.height;
    scrollSize.height -= app.tabView.frame.size.height;
    [_scrollview setContentSize:scrollSize];
    [_scrollview setContentOffset:CGPointMake(0, scrollSize.height) animated:NO];
}
- (void)keyboardWillHide:(NSNotification*)notification
{
    TheApp;
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    CGSize scrollSize = _scrollview.contentSize;
    scrollSize.height -= keyboardFrameBeginRect.size.height;
    scrollSize.height += app.tabView.frame.size.height;
    [_scrollview setContentSize:scrollSize];
    [_scrollview setContentOffset:CGPointMake(0, 0) animated:YES];
}
#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.messages count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    // create the parent view that will hold header Label
    UIView *customView   = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 300.0, 20.0)];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    
    customView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    headerLabel.backgroundColor      = [UIColor clearColor];
    headerLabel.opaque               = NO;
    headerLabel.textColor            = [UIColor whiteColor];
    headerLabel.highlightedTextColor = [UIColor whiteColor];
    headerLabel.font                 = [UIFont boldSystemFontOfSize:12];
    headerLabel.frame                = CGRectMake(115.0, 0.0, 300.0, 20.0);
    

    NSDictionary* dict = (NSDictionary*)[_messages objectAtIndex:section];
    NSString* timeStr = (NSString*)[dict objectForKey:@"date_message"];
    

    NSDateFormatter *serverFormatter = [[NSDateFormatter alloc] init];
    [serverFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDateFormatter *clientFormatter = [[NSDateFormatter alloc] init];
    [clientFormatter setDateFormat:@"dd.MM.yyyy HH:mm"];
    
    headerLabel.text = [ clientFormatter stringFromDate:[serverFormatter dateFromString:timeStr]];
    
    [customView addSubview:headerLabel];

    
    return customView;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"MsgListCell";
    
    ThreadCell *cell = (ThreadCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[ThreadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    NSDictionary* dict = (NSDictionary*)[_messages objectAtIndex:indexPath.section];
    NSNumber* state = (NSNumber*)[dict objectForKey:@"is_own"];
    cell.imgName      = ([state intValue]) ? @"blue.png" : @"lime.png";
    cell.tipRightward = ([state intValue]) ? YES : NO;
    cell.msgText      = (NSString*)[dict objectForKey:@"message"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary* dict = (NSDictionary*)[_messages objectAtIndex:indexPath.section];
    NSString *aMsg = (NSString*)[dict objectForKey:@"message"];
    CGFloat widthForText ;
    
    UIInterfaceOrientation orient = [self interfaceOrientation];
    
    if (UIInterfaceOrientationIsPortrait(orient)) {
        widthForText = 260.f;
    } else {
        widthForText = 400.f;
    }
   
    CGSize size = [ThreadCell calcTextHeight:aMsg withinWidth:widthForText];
    
    size.height += 5;
    
    CGFloat height = (size.height < 36) ? 36 : size.height;
    
    return height;
}

#pragma mark - BASTabView delegate method
- (void)BASTabView:(BASTabView*)view withTabClicked:(NSInteger)index{
    TheApp;
    [self removeTitleImage];
    [self customTitleImage];
    if(app.tabView.tabIndex == 0){
        app.messageType = NUTRIT;
    } else {
        app.messageType = SUPPORT;
    }
 
    self.messages = nil;
    [_tableView reloadData];
    [app showIndecator:YES withView:self.view];
    
    [[BASManager sharedInstance] getData:[[BASManager sharedInstance] formatRequest:@"GETMESSAGES" withParam:nil] success:^(NSDictionary* responseObject) {
        if([responseObject isKindOfClass:[NSDictionary class]]){
            //NSLog(@"%@",responseObject);
            NSDictionary* param = @{@"level":[NSNumber numberWithInt:(int)index + 1]
                                    };
            [[BASManager sharedInstance] getData:[[BASManager sharedInstance] formatRequest:@"SETMESSAGESREAD" withParam:param] success:^(NSDictionary* responseObject) {
                if([responseObject isKindOfClass:[NSDictionary class]]){
                    //NSLog(@"%@",responseObject);
                    [app showIndecator:NO withView:self.view];
                    NSArray* userInfo = (NSArray*)[responseObject objectForKey:@"param"];
                    NSDictionary* dict = (NSDictionary*)[userInfo objectAtIndex:0];
                    
                    [self.messagesNat removeAllObjects];
                    [self.messagesNat addObjectsFromArray:(NSArray*)[dict objectForKey:@"nutritionist"]];
                    
                    [self.messagesSupport removeAllObjects];
                    [self.messagesSupport addObjectsFromArray:(NSArray*)[dict objectForKey:@"support"]];
                    
                    NSNumber* support_count = (NSNumber*)[dict objectForKey:@"support_count"];
                    NSNumber* nutritionist_count = (NSNumber*)[dict objectForKey:@"nutritionist_count"];
                    nutritionistState = [nutritionist_count integerValue];
                    supportState = [support_count integerValue];
                    NSNumber* nutritionist_status = (NSNumber*)[dict objectForKey:@"nutritionist_status"];
                    [app.tabView showState:0 withState:(BOOL)[nutritionist_status integerValue]];
                    NSNumber* support_status = (NSNumber*)[dict objectForKey:@"support_status"];
                    [app.tabView showState:1 withState:(BOOL)[support_status integerValue]];
                    
                    if(app.tabView.tabIndex == 0){
                        self.messages = [NSArray arrayWithArray:_messagesNat];
                        
                        [app.tabView showNoticesCount:supportState withSatate:NO];
                        
                    } else {
                        self.messages = [NSArray arrayWithArray:_messagesSupport];
                        [app.tabView showNoticesCount:nutritionistState withSatate:YES];
                        
                    }
                    [_tableView reloadData];
                    if(_messages.count > 0){
                        [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_messages.count -1] animated:YES scrollPosition:UITableViewScrollPositionBottom];
                    }
                }
            }failure:^(NSString *error) {
                NSLog(@"%@",error);
            }];
            
        }
    }failure:^(NSString *error) {
        NSLog(@"%@",error);
    }];


}
#pragma mark - BASManager delegate method
- (void)icommingMessage:(BASManager*)manager withObject:(NSDictionary*)obj{
    
    [self getData];
}
@end
