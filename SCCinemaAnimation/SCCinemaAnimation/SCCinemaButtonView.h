//
//  SCCinemaButtonView.h
//  SCCinemaAnimation
//
//  Created by Yh c on 15/11/8.
//  Copyright © 2015年 Yh c. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalHeader.h"

@interface SCCinemaButtonView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;

@property (copy) void (^DidTapped)();
@end
