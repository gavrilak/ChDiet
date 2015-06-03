//
//  ThreadCell.m
//  MessageBubbles
//
//  Created by cwiles on 6/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ThreadCell.h"


@implementation ThreadCell

@synthesize msgText;
@synthesize imgName;

@synthesize tipRightward = _tipRightward;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
  if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
    
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    self.accessoryType   = UITableViewCellAccessoryNone;
    self.backgroundColor = [UIColor clearColor];
  }
  
  return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
}

- (void)layoutSubviews {
    
  [super layoutSubviews];
  
 // NSLog(@"bounds: %@", NSStringFromCGRect( self.bounds));
 // NSLog(@"bounds content: %@", NSStringFromCGRect( self.contentView.bounds));
  
  CGFloat widthForText = self.bounds.size.width  - 50;  
  CGSize size          = [ThreadCell calcTextHeight:self.msgText withinWidth:widthForText];
  UIImage *balloon     = [[UIImage imageNamed:self.imgName] stretchableImageWithLeftCapWidth:45 topCapHeight:25];
  
    
 /* if (self.tipRightward) {
    
    balloon = [UIImage imageWithCGImage: balloon.CGImage scale:1.0 orientation:(UIImageOrientationUpMirrored)];
    balloon = [balloon stretchableImageWithLeftCapWidth:24 topCapHeight:15];
  }*/
  
  CGFloat xx;
  CGFloat xx2;
  if (self.tipRightward) {
    xx = 0.0f;
      xx2 = -2.0f;
  } else {
    xx = self.frame.size.width - size.width - 24 - 10 ;
      xx2 = 5.0f;
  }
    
  UIImageView *newImage = [[UIImageView alloc] initWithFrame:CGRectMake(xx, 5.0, size.width + 35, size.height + 15)];
  UIView *newView       = [[UIView alloc] initWithFrame:CGRectMake(0.0, 5.0, self.frame.size.width, self.frame.size.height)];
  
  UILabel *txtLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 + xx - xx2 , 14, size.width, size.height)];

  txtLabel.lineBreakMode   = UILineBreakModeWordWrap;
  txtLabel.numberOfLines   = 0;
  txtLabel.text            = msgText;
  txtLabel.backgroundColor = [UIColor clearColor];
  txtLabel.font            = [UIFont fontWithName:@"GillSans-Italic" size: 16.f];
  txtLabel.tag             = 42;

  [txtLabel sizeToFit];
  
  [newImage setImage:balloon];
    
  [newView addSubview:newImage];

  [self setBackgroundView:newView];

  [[self.contentView viewWithTag:42] removeFromSuperview];
  
  [self.contentView addSubview:txtLabel];
  
  [txtLabel release];
  
  [newImage release];
  [newView release];
}

+ (CGSize)calcTextHeight:(NSString *)str {
  return [self calcTextHeight:str withinWidth:260.0];
}

+ (CGSize) calcTextHeight:(NSString *)str withinWidth:(CGFloat)width {
    
  CGSize textSize = {width, 20000.0};
  CGSize size     = [str sizeWithFont:[UIFont fontWithName:@"GillSans-Italic" size: 16.f]
                    constrainedToSize:textSize];
  
  return size;
}

- (void)dealloc {
  [msgText release];
  [imgName release];
  [super dealloc];
}


@end
