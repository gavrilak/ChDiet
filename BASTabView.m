//
//  BASTabView.m
//  ChatDieta
//
//  Created by Sergey on 10.11.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import "BASTabView.h"
#import "CustomBadge.h"

@interface BASTabView()

@property (nonatomic,strong) UIButton* leftButton;
@property (nonatomic,strong) UIButton* rightButton;
@property (nonatomic,strong) UILabel* leftLabel;
@property (nonatomic,strong) UILabel* rightLabel;
@property (nonatomic, strong) CustomBadge *customBadge;

@end
@implementation BASTabView
- (void)setTabIndex:(NSInteger)tabIndex{
    _tabIndex = tabIndex;
    [_leftButton setSelected:YES];
    [_rightButton setSelected:NO];
    if(tabIndex){
        [_leftButton setSelected:NO];
        [_rightButton setSelected:YES];
    }
}
- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.tabIndex = 0;
        CGRect frame = [[UIScreen mainScreen]bounds];
        UIImage* image = [UIImage imageNamed:@"icon_nut.png"];
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_bg.png"]]];
        
        self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftButton setBackgroundColor:[UIColor clearColor]];
        [_leftButton setImage:image forState:UIControlStateNormal];
        [_leftButton setImage:[UIImage imageNamed:@"icon_nut_s.png"] forState:UIControlStateSelected];
        [_leftButton setFrame:CGRectMake(0, 0, frame.size.width / 2, self.frame.size.height)];
        [_leftButton setTitle:@"Диетолог" forState:UIControlStateNormal];
        [_leftButton setTitle:@"Диетолог" forState:UIControlStateHighlighted];
        [_leftButton setTitle:@"Диетолог" forState:UIControlStateSelected];
        
        [_leftButton setTitleColor:[UIColor colorWithRed:154.f / 255.f green:199.f / 255.f blue:153.f / 255.f alpha:1.0] forState:UIControlStateNormal];
        [_leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_leftButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:15.f]];
        [_leftButton addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_leftButton];
        [_leftButton setSelected:YES];
        
        self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setBackgroundColor:[UIColor clearColor]];
        [_rightButton setImage:[UIImage imageNamed:@"icon_t_s.png"] forState:UIControlStateNormal];
        [_rightButton setImage:[UIImage imageNamed:@"icon_t_s_s.png"] forState:UIControlStateSelected];
        [_rightButton setFrame:CGRectMake(frame.size.width / 2, 0, frame.size.width / 2, self.frame.size.height)];
        [_rightButton setTitle:@"Техподдержка" forState:UIControlStateNormal];
        [_rightButton setTitle:@"Техподдержка" forState:UIControlStateHighlighted];
        [_rightButton setTitle:@"Техподдержка" forState:UIControlStateSelected];
        
        [_rightButton setTitleColor:[UIColor colorWithRed:154.f / 255.f green:199.f / 255.f blue:153.f / 255.f alpha:1.0] forState:UIControlStateNormal];
        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_rightButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:15.f]];
        [_rightButton addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_rightButton];
        
        self.leftLabel = [[UILabel alloc]init];
        [_leftLabel setBackgroundColor:[UIColor clearColor]];
        [_leftLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12.f]];
        [_leftLabel setText:@"Offline"];
        [_leftLabel setTextAlignment:NSTextAlignmentCenter];
        [_leftLabel setTextColor:[UIColor colorWithRed:154.f / 255.f green:199.f / 255.f blue:153.f / 255.f alpha:1.0]];
        [_leftLabel setTextColor:[UIColor redColor]];
        [self addSubview:_leftLabel];
        
        self.rightLabel = [[UILabel alloc]init];
        [_rightLabel setBackgroundColor:[UIColor clearColor]];
        [_rightLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12.f]];
        [_rightLabel setText:@"Offline"];
        [_rightLabel setTextAlignment:NSTextAlignmentCenter];
        [_rightLabel setTextColor:[UIColor colorWithRed:154.f / 255.f green:199.f / 255.f blue:153.f / 255.f alpha:1.0]];
        [_rightLabel setTextColor:[UIColor redColor]];
        [self addSubview:_rightLabel];
        
        
        [_leftLabel setFrame:CGRectMake(0.f, 2.f, frame.size.width / 2, 12.f)];
        [_rightLabel setFrame:CGRectMake(frame.size.width / 2, 2, frame.size.width / 2, 12.f)];
        if(IS_IPHONE_5){
            [_leftButton setImageEdgeInsets:UIEdgeInsetsMake(- 3.f, 64.f, 0, 0)];
            [_leftButton setTitleEdgeInsets:UIEdgeInsetsMake(43.f, -26.f, 0, 0)];
            [_rightButton setImageEdgeInsets:UIEdgeInsetsMake(- 3.f, 60.f, 0, 0)];
            [_rightButton setTitleEdgeInsets:UIEdgeInsetsMake(43.f, -22.f, 0, 0)];

        } else if(IS_IPHONE_6){
            [_leftButton setImageEdgeInsets:UIEdgeInsetsMake(- 3.f, 74.f, 0, 0)];
            [_leftButton setTitleEdgeInsets:UIEdgeInsetsMake(43.f, -25, 0, 0)];
            [_rightButton setImageEdgeInsets:UIEdgeInsetsMake(- 3.f, 77.5f, 0, 0)];
            [_rightButton setTitleEdgeInsets:UIEdgeInsetsMake(43.f, -18, 0, 0)];

        } else if(IS_IPHONE_6_PLUS){
            [_leftButton setImageEdgeInsets:UIEdgeInsetsMake(- 3.f, 74.f, 0, 0)];
            [_leftButton setTitleEdgeInsets:UIEdgeInsetsMake(43.f, -27.f, 0, 0)];
            [_rightButton setImageEdgeInsets:UIEdgeInsetsMake(- 3.f, 87.5f, 0, 0)];
            [_rightButton setTitleEdgeInsets:UIEdgeInsetsMake(43.f, -25.f, 0, 0)];

        }
        
        //[self showNoticesCount:3];
        
    }
    return  self;
}

- (void)clicked:(id)sender{
    UIButton * button = (UIButton*)sender;
    
    [_leftButton setSelected:NO];
    [_rightButton setSelected:NO];
    if([button isEqual:_leftButton]){
        _tabIndex = 0;
        [_leftButton setSelected:YES];
    } else {
        _tabIndex = 1;
        [_rightButton setSelected:YES];
    }
    if([self.delegate respondsToSelector:@selector(BASTabView:withTabClicked:)]){
        [_delegate BASTabView:self withTabClicked:_tabIndex];
    }
}
- (void)showState:(NSInteger)type withState:(BOOL)state{
    
    UIColor *color = [UIColor colorWithRed:179.f / 255.f green:235.f / 255.f blue:44.f / 255.f alpha:1.0];
    /*NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:[NSDate date]];
    NSInteger hour = [components hour];
    if(hour >= 11 && hour < 20){
        [_leftLabel setTextColor:color];
        [_leftLabel setText:@"Online"];
         [_rightLabel setTextColor:color];
        [_rightLabel setText:@"Online"];
        return;
    }*/
    if(type == 0){
        [_leftLabel setText:@"Offline"];
        [_leftLabel setTextColor:[UIColor redColor]];
        if(state){
            [_leftLabel setTextColor:color];
            
            [_leftLabel setText:@"Online"];
        }
        
    } else {
        [_rightLabel setText:@"Offline"];
        [_rightLabel setTextColor:[UIColor redColor]];
        if(state){
            [_rightLabel setTextColor:color];
            
            [_rightLabel setText:@"Online"];
        }
    }
}
- (void)showNoticesCount:(NSUInteger)noticesCnt withSatate:(BOOL)state
{
    TheApp;
    [self.customBadge removeFromSuperview];
    self.customBadge = nil;
    if(noticesCnt > 0){
        self.customBadge = [CustomBadge customBadgeWithString:[NSString stringWithFormat:@"%d",noticesCnt]
                                              withStringColor:[UIColor whiteColor]
                                               withInsetColor:[UIColor redColor]
                                               withBadgeFrame:YES
                                          withBadgeFrameColor:[UIColor whiteColor]
                                                    withScale:1.0
                                                  withShining:YES];
        _customBadge.tag = 111;
        CGRect frame = [[UIScreen mainScreen]bounds];
        if(!state){
            if(IS_IPHONE_5){
                [_customBadge setFrame:CGRectMake(frame.size.width  - 70.f, 12, 22.f, 22.f)];
                
            } else if(IS_IPHONE_6){
                [_customBadge setFrame:CGRectMake(frame.size.width  - 80.f, 12, 22.f, 22.f)];
                
            } else if(IS_IPHONE_6_PLUS){
                [_customBadge setFrame:CGRectMake(frame.size.width  - 95.f, 12, 22.f, 22.f)];
                
            }
        } else {
            if(IS_IPHONE_5){
                [_customBadge setFrame:CGRectMake(85.f, 12, 22.f, 22.f)];
                
            } else if(IS_IPHONE_6){
                [_customBadge setFrame:CGRectMake(100.f, 12, 22.f, 22.f)];
                
            } else if(IS_IPHONE_6_PLUS){
                [_customBadge setFrame:CGRectMake(110.f, 12, 22.f, 22.f)];
                
            }
        }
        
        [self addSubview:_customBadge];
    }
    
}
@end
