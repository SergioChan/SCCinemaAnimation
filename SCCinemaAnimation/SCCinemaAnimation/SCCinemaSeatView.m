//
//  SCCinemaSeatView.m
//  SCCinemaAnimation
//
//  Created by Yh c on 15/11/10.
//  Copyright © 2015年 Yh c. All rights reserved.
//

#import "SCCinemaSeatView.h"

@implementation SCCinemaSeatView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.seatButtonArray = [NSMutableArray array];
        CGFloat buttonWidth = self.width / 12.75f;
        CGFloat nextX = buttonWidth / 4.0f;
        CGFloat nextY = 0.0f;
        int count = 0;
        while(nextX < self.width && nextY < self.height - buttonWidth)
        {
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(nextX, nextY, buttonWidth, buttonWidth)];
            button.backgroundColor = Global_cinemaLightGray;
            [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:button];
            count += 1;
            nextX += buttonWidth * 1.25f;
            if(count == 2 || count == 6)
            {
                nextX += buttonWidth * 1.25f;
            }
            
            if(nextX >= self.width)
            {
                count = 0;
                nextX = buttonWidth / 4.0f;
                nextY += buttonWidth * 1.25f;
            }
            [self.seatButtonArray addObject:button];
        }
    }
    return self;
}

- (void)buttonTapped:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if([button.backgroundColor isEqual:Global_cinemaBlue])
    {
        button.backgroundColor = Global_cinemaLightGray;
    }
    else
    {
        button.backgroundColor = Global_cinemaBlue;
    }
}
@end
