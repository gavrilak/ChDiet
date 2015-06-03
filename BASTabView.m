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

@property (nonatomic,strong) UIButton* mainButton;
@property (nonatomic,strong) UIButton* magazineButton;
@property (nonatomic,strong) UIButton* leftButton;
@property (nonatomic,strong) UIButton* rightButton;
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
        UIImage* image = [UIImage imageNamed:@"butt_home_tab.png"];
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_bg@3x.png"]]];
        
        self.mainButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_mainButton setBackgroundColor:[UIColor clearColor]];
        [_mainButton setImage:image forState:UIControlStateNormal];
        [_mainButton setImage:[UIImage imageNamed:@"butt_home_tab_s.png"] forState:UIControlStateSelected];
        [_mainButton setFrame:CGRectMake(0, 0, frame.size.width / 4, self.frame.size.height)];
        if(IS_IPHONE_6 || IS_IPHONE_6_PLUS){
              [_mainButton setFrame:CGRectMake(10, 0, frame.size.width / 4, self.frame.size.height)];
        }
        [_mainButton setTitle:@"Главная" forState:UIControlStateNormal];
        [_mainButton setTitle:@"Главная" forState:UIControlStateHighlighted];
        [_mainButton setTitle:@"Главная" forState:UIControlStateSelected];
        
        [_mainButton setTitleColor:[UIColor colorWithRed:51/ 255.f green:102 / 255.f blue:0  alpha:1.0] forState:UIControlStateNormal];
        [_mainButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_mainButton.titleLabel setFont:[UIFont fontWithName:@"Gill Sans" size:13.f]];
        [_mainButton addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_mainButton];
        
        
        self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftButton setBackgroundColor:[UIColor clearColor]];
        [_leftButton setImage:[UIImage imageNamed:@"butt_nutritionist_tab.png"] forState:UIControlStateNormal];
        [_leftButton setImage:[UIImage imageNamed:@"butt_nutritionist_tab_s.png"] forState:UIControlStateSelected];
        [_leftButton setFrame:CGRectMake(frame.size.width / 4, 0, frame.size.width / 4, self.frame.size.height)];
        if(IS_IPHONE_6 || IS_IPHONE_6_PLUS){
            [_leftButton setFrame:CGRectMake(frame.size.width / 4 + 10, 0, frame.size.width / 4, self.frame.size.height)];
        }
        [_leftButton setTitle:@"Диетолог" forState:UIControlStateNormal];
        [_leftButton setTitle:@"Диетолог" forState:UIControlStateHighlighted];
        [_leftButton setTitle:@"Диетолог" forState:UIControlStateSelected];
        
        [_leftButton setTitleColor:[UIColor colorWithRed:51/ 255.f green:102 / 255.f blue:0  alpha:1.0] forState:UIControlStateNormal];
        [_leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_leftButton.titleLabel setFont:[UIFont fontWithName:@"Gill Sans" size:13.f]];
        [_leftButton addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_leftButton];
        [_leftButton setSelected:YES];
        
        self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setBackgroundColor:[UIColor clearColor]];
        [_rightButton setImage:[UIImage imageNamed:@"butt_support_tab.png"] forState:UIControlStateNormal];
        [_rightButton setImage:[UIImage imageNamed:@"butt_support_tab_s.png"] forState:UIControlStateSelected];
        [_rightButton setFrame:CGRectMake(frame.size.width / 2, 0, frame.size.width / 4 + 10, self.frame.size.height)];
        if(IS_IPHONE_6 || IS_IPHONE_6_PLUS){
           [_rightButton setFrame:CGRectMake(frame.size.width / 2 +10, 0, frame.size.width / 4 + 10, self.frame.size.height)];
        }
        [_rightButton setTitle:@"Техподдержка" forState:UIControlStateNormal];
        [_rightButton setTitle:@"Техподдержка" forState:UIControlStateHighlighted];
        [_rightButton setTitle:@"Техподдержка" forState:UIControlStateSelected];
        
        [_rightButton setTitleColor:[UIColor colorWithRed:51/ 255.f green:102 / 255.f blue:0  alpha:1.0] forState:UIControlStateNormal];
        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_rightButton.titleLabel setFont:[UIFont fontWithName:@"Gill Sans" size:13.f]];
        [_rightButton addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_rightButton];
        
        
        
        self.magazineButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_magazineButton setBackgroundColor:[UIColor clearColor]];
        [_magazineButton setImage:[UIImage imageNamed:@"butt_magaz_tab.png"] forState:UIControlStateNormal];
        [_magazineButton setImage:[UIImage imageNamed:@"butt_magaz_tab_s.png"] forState:UIControlStateSelected];
        [_magazineButton setFrame:CGRectMake((frame.size.width / 4) * 3, 0, frame.size.width / 4, self.frame.size.height)];
        if(IS_IPHONE_6_PLUS ){
            [_magazineButton setFrame:CGRectMake((frame.size.width / 4) * 3 +10, 0, frame.size.width / 4, self.frame.size.height)];
        }
        [_magazineButton setTitle:@"Магазин" forState:UIControlStateNormal];
        [_magazineButton setTitle:@"Магазин" forState:UIControlStateHighlighted];
        [_magazineButton setTitle:@"Магазин" forState:UIControlStateSelected];
        
        [_magazineButton setTitleColor:[UIColor colorWithRed:51/ 255.f green:102 / 255.f blue:0  alpha:1.0] forState:UIControlStateNormal];
        [_magazineButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_magazineButton.titleLabel setFont:[UIFont fontWithName:@"Gill Sans" size:13.f]];
        [_magazineButton addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_magazineButton];
        
        
        if(IS_IPHONE_5){
            [_mainButton setImageEdgeInsets:UIEdgeInsetsMake(- 10.f, 10.f, 0, 0)];
            [_magazineButton setImageEdgeInsets:UIEdgeInsetsMake(- 10.f, 10.f, 0, 0)];
            [_leftButton setImageEdgeInsets:UIEdgeInsetsMake(- 10.f, 10.f, 0, 0)];
            [_rightButton setImageEdgeInsets:UIEdgeInsetsMake(- 10.f, 10.f, 0, 0)];
            
            [_mainButton setTitleEdgeInsets:UIEdgeInsetsMake(35.f, -50.f, 0, 0)];
            [_magazineButton setTitleEdgeInsets:UIEdgeInsetsMake(35.f, -50.f, 0, 0)];
            [_leftButton setTitleEdgeInsets:UIEdgeInsetsMake(35.f, -50.f, 0, 0)];
            [_rightButton setTitleEdgeInsets:UIEdgeInsetsMake(35.f, -60.f, 0, 0)];

        } else if(IS_IPHONE_6){
            [_mainButton setImageEdgeInsets:UIEdgeInsetsMake(- 10.f, 10.f, 0, 0)];
            [_magazineButton setImageEdgeInsets:UIEdgeInsetsMake(- 10.f, 10.f, 0, 0)];
            [_leftButton setImageEdgeInsets:UIEdgeInsetsMake(- 10.f, 10.f, 0, 0)];
            [_rightButton setImageEdgeInsets:UIEdgeInsetsMake(- 10.f, 10.f, 0, 0)];
            
            [_mainButton setTitleEdgeInsets:UIEdgeInsetsMake(35.f, -70.f, 0, 0)];
            [_magazineButton setTitleEdgeInsets:UIEdgeInsetsMake(35.f, -50.f, 0, 0)];
            [_leftButton setTitleEdgeInsets:UIEdgeInsetsMake(35.f, -70.f, 0, 0)];
            [_rightButton setTitleEdgeInsets:UIEdgeInsetsMake(35.f, -80.f, 0, 0)];


        } else if(IS_IPHONE_6_PLUS){
            [_mainButton setImageEdgeInsets:UIEdgeInsetsMake(- 10.f, 10.f, 0, 0)];
            [_magazineButton setImageEdgeInsets:UIEdgeInsetsMake(- 10.f, 10.f, 0, 0)];
            [_leftButton setImageEdgeInsets:UIEdgeInsetsMake(- 10.f, 10.f, 0, 0)];
            [_rightButton setImageEdgeInsets:UIEdgeInsetsMake(- 10.f, 10.f, 0, 0)];
            
            [_mainButton setTitleEdgeInsets:UIEdgeInsetsMake(35.f, -75.f, 0, 0)];
            [_magazineButton setTitleEdgeInsets:UIEdgeInsetsMake(35.f, -80.f, 0, 0)];
            [_leftButton setTitleEdgeInsets:UIEdgeInsetsMake(35.f, -75.f, 0, 0)];
            [_rightButton setTitleEdgeInsets:UIEdgeInsetsMake(35.f, -80.f, 0, 0)];


        }
        
       // [self showNoticesCount:3 withSatate:NO];
        
    }
    return  self;
}

- (void)clicked:(id)sender{
    UIButton * button = (UIButton*)sender;
    
    [_mainButton setSelected:NO];
    [_magazineButton setSelected:NO];
    [_leftButton setSelected:NO];
    [_rightButton setSelected:NO];
    if([button isEqual:_leftButton]){
        _tabIndex = 0;
        [_leftButton setSelected:YES];
    } else if ([button isEqual:_rightButton])  {
        _tabIndex = 1;
        [_rightButton setSelected:YES];
    } else if ([button isEqual:_mainButton])  {
        _tabIndex = -1;
        [_mainButton setSelected:YES];
    } else if ([button isEqual:_magazineButton])  {
        _tabIndex = 2;
        [_magazineButton setSelected:YES];
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
   /* if(type == 0){
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
    } */
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
                                               withBadgeFrame:NO
                                          withBadgeFrameColor:[UIColor whiteColor]
                                                    withScale:0.7
                                                  withShining:NO];
        _customBadge.tag = 111;
        CGRect frame = [[UIScreen mainScreen]bounds];
        if(!state){
            if(IS_IPHONE_5){
                [_customBadge setFrame:CGRectMake(frame.size.width - 125.f, -3, 18.f, 18.f)];
                
            } else if(IS_IPHONE_6){
                [_customBadge setFrame:CGRectMake(frame.size.width  - 150.f, -3, 18.f, 18.f)];
                
            } else if(IS_IPHONE_6_PLUS){
                [_customBadge setFrame:CGRectMake(frame.size.width  - 170.f, -3, 18.f, 18.f)];
                
            }
        } else {
            if(IS_IPHONE_5){
                [_customBadge setFrame:CGRectMake(118.f, -3, 18.f, 18.f)];
                
            } else if(IS_IPHONE_6){
                [_customBadge setFrame:CGRectMake(130.f, -3, 18.f, 18.f)];
                
            } else if(IS_IPHONE_6_PLUS){
                [_customBadge setFrame:CGRectMake(140.f, -3, 18.f, 18.f)];
                
            }
        }
        
        [self addSubview:_customBadge];
    }
    
}
@end
