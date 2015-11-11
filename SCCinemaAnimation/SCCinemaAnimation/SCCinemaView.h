//
//  SCCinemaView.h
//  SCCinemaAnimation
//
//  Created by Yh c on 15/11/8.
//  Copyright © 2015年 Yh c. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalHeader.h"
#import "SCCinemaButtonView.h"
#import "SCCinemaSeatView.h"

@interface SCCinemaView : UIView
{
    CGPoint controlPoint;
}
@property (nonatomic, strong) UIView *posterView;
@property (nonatomic, strong) UIView *posterHeaderView;

@property (nonatomic, strong) SCCinemaSeatView *seatView;

@property (nonatomic, strong) SCCinemaButtonView *button;
@property (nonatomic, strong) UITextView *descriptionView;
@property (nonatomic, strong) UIButton *backButton;

- (id)initWithFrame:(CGRect)frame buttonTitle:(NSString *)title price:(NSString *)price;
@end
