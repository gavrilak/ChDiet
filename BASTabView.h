//
//  BASTabView.h
//  ChatDieta
//
//  Created by Sergey on 10.11.14.
//  Copyright (c) 2014 BestAppStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BASTabView;

@protocol BASTabViewDelegate <NSObject>

- (void)BASTabView:(BASTabView*)view withTabClicked:(NSInteger)index;

@end
@interface BASTabView : UIView

@property (nonatomic,assign) id<BASTabViewDelegate> delegate;
@property (nonatomic,assign) NSInteger tabIndex;

- (void)showNoticesCount:(NSUInteger)noticesCnt  withSatate:(BOOL)state;
- (void)showState:(NSInteger)type withState:(BOOL)state;

@end
