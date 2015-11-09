//
//  SCCinemaButtonView.m
//  SCCinemaAnimation
//
//  Created by Yh c on 15/11/8.
//  Copyright © 2015年 Yh c. All rights reserved.
//

#import "SCCinemaButtonView.h"

@implementation SCCinemaButtonView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.layer.shadowOffset = CGSizeMake(0, 10);
        self.layer.shadowOpacity = 0.8f;
        self.layer.shadowRadius = 10.0f;
        self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15.0f, 17.0f, 100.0f, 20.0f)];
        _titleLabel.font = [UIFont systemFontOfSize:17.0f];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titleLabel];
        
        self.detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.width - 90.0f, 17.0f, 50.0f, 20.0f)];
        _detailLabel.font = [UIFont systemFontOfSize:17.0f];
        _detailLabel.textColor = [UIColor whiteColor];
        _detailLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_detailLabel];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect frameSize = self.bounds;
    
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint (context, frameSize.size.width, 0);
    CGContextAddLineToPoint (context, frameSize.size.width - 30.0f, frameSize.size.height);
    CGContextAddLineToPoint (context, 0, frameSize.size.height);
    CGContextClosePath(context);
    
    [Global_cinemaBlue setFill];
    CGContextDrawPath(context, kCGPathFill);
    
    // 这里不需要调用release，因为这个对象不是你创建的，你也没有retain，因此不需要release
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if(touches.count == 1)
    {
        for(UITouch *touch in touches)
        {
            if(touch.phase == UITouchPhaseEnded || touch.phase == UITouchPhaseCancelled)
            {
                if (self.DidTapped) {
                    self.DidTapped();
                }
            }
        }
    }
}
@end
