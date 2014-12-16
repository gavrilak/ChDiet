//
//  BASProgViewController.m
//  OfigennoParser
//
//  Created by Sergey Bekker on 15.08.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASProgViewController.h"

@interface BASProgViewController ()

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSArray* contentData;

@end

@implementation BASProgViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSMutableArray *temp = [NSMutableArray new];
        NSDictionary* data1 = @{@"image": [UIImage imageNamed:@"ic_directory.png"],
                                @"text":[NSString stringWithFormat:@"Справочник Лекарственных Средств"],
                                @"link":[NSString stringWithFormat:@"https://itunes.apple.com/ru/app/spravocnik-lekarstvennyh-sredstv/id789721612?mt=8"]
                                };
        [temp  addObject:data1];
        NSDictionary* data2 = @{@"image": [UIImage imageNamed:@"ic_football.png"],
                                @"text":[NSString stringWithFormat:@"Весь Футбол"],
                                @"link":[NSString stringWithFormat:@"https://itunes.apple.com/ru/app/ves-futbol/id768137478?mt=8"]
                                };
        [temp  addObject:data2];
        NSDictionary* data3 = @{@"image": [UIImage imageNamed:@"ic_seven.png"],
                                @"text":[NSString stringWithFormat:@"Дюкан Экспресс - Похудей за 7 Дней!"],
                                @"link":[NSString stringWithFormat:@"https://itunes.apple.com/ru/app/dukan-ekspress-pohudej-za/id882601416?mt=8"]
                                };
        [temp  addObject:data3];
        NSDictionary* data4 = @{@"image": [UIImage imageNamed:@"ic_schedule.png"],
                                @"text":[NSString stringWithFormat:@"Умное Расписание ЖД"],
                                @"link":[NSString stringWithFormat:@"https://itunes.apple.com/ru/app/umnoe-raspisanie-zd/id849806022?mt=8"]
                                };
        [temp  addObject:data4];
        NSDictionary* data5 = @{@"image": [UIImage imageNamed:@"ic_diet_dukan.png"],
                                @"text":[NSString stringWithFormat:@"Диета Дюкана + Более 500 рецептов!"],
                                @"link":[NSString stringWithFormat:@"https://itunes.apple.com/ru/app/dieta-dukana-+-bolee-500-receptov!/id813912029?mt=8"]
                                };
        [temp  addObject:data5];
   
        
        self.contentData = [NSArray arrayWithArray:temp];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
  
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];

    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.userInteractionEnabled = YES;
    _tableView.bounces = NO;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tableView setBackgroundColor:[UIColor clearColor]];
    _tableView.delegate = (id)self;
    _tableView.dataSource = (id)self;

    [self.view addSubview:_tableView];
    [_tableView reloadData];

}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.topItem.title = @"";
    [self removeTitleImage];
    [self setupNavBtn:BACKTYPE];
    [self customTitle:@"Приложения"];
    CGRect frame = [[UIScreen mainScreen]bounds];
    [_tableView setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - self.navigationController.navigationBar.frame.size.height - 20.f)];
}
- (void)viewWillDisappear:(BOOL)animated{

    [self customTitle:@""];
    [super viewWillDisappear:animated];
}

#pragma mark -
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _contentData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"simpleCell";
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    NSDictionary* dict = (NSDictionary*)[_contentData objectAtIndex:[indexPath row]];
 
    UIImage *image = (UIImage*)[dict objectForKey:@"image"];
    UIImageView *imgView= [[UIImageView alloc]initWithImage:image];
    [imgView setFrame:CGRectMake(15.f, cell.contentView.frame.size.height / 2 - image.size.height / 8 - 3.f, image.size.width / 2 , image.size.height / 2)];
    [cell.contentView addSubview:imgView];
    
    UILabel *lbView = [[UILabel alloc] init];
    lbView.backgroundColor = [UIColor clearColor];
    lbView.font = [UIFont fontWithName:@"Helvetica-Light" size:14.0];
    lbView.textColor = [UIColor whiteColor];
    lbView.textAlignment = NSTextAlignmentLeft;
    lbView.numberOfLines = 2;
    lbView.lineBreakMode = NSLineBreakByWordWrapping;
    lbView.text = (NSString*)[dict objectForKey:@"text"];
    [lbView setFrame:CGRectMake(imgView.frame.origin.x + imgView.frame.size.width + 10.f, 12.f, cell.contentView.frame.size.width - (imgView.frame.origin.x + imgView.frame.size.width + 20.f), cell.contentView.frame.size.height  - 10.f)];
    [cell.contentView addSubview:lbView];
    
    image = [UIImage imageNamed:@"separator_menu.png"];
    UIImageView* separator = [[UIImageView alloc]initWithImage:image];
    [separator setFrame:CGRectMake(0, cell.contentView.frame.size.height + 15 , image.size.width, image.size.height)];
    [cell.contentView addSubview:separator];
    
    [cell.contentView setBackgroundColor:[UIColor colorWithRed:80.0/255.0 green:111.0/255.0 blue:80.0/255.0 alpha:1.0]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
}
#pragma mark -
#pragma mark Table delegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60.f;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary* dict = (NSDictionary*)[_contentData objectAtIndex:[indexPath row]];
    NSString* link = (NSString*)[dict objectForKey:@"link"];
    
    if([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:link]]){
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:link]];
    }
    
}

@end
