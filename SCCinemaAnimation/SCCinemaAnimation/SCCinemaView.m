//
//  SCCinemaView.m
//  SCCinemaAnimation
//
//  Created by Yh c on 15/11/8.
//  Copyright © 2015年 Yh c. All rights reserved.
//

#import "SCCinemaView.h"
#import <QuartzCore/CoreAnimation.h>

@implementation SCCinemaView

- (id)initWithFrame:(CGRect)frame buttonTitle:(NSString *)title price:(NSString *)price
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor whiteColor];
        self.posterView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.width, (self.height / 10.0f ) * 4.0f)];
        _posterView.contentMode = UIViewContentModeScaleAspectFill;
        _posterView.layer.anchorPoint = CGPointMake(0.5, 0);
        //一开始就设置好anchorPoint
        
        //_posterView.layer.masksToBounds = YES;
        // DEBUG: 这里留作教训吧，如果设置了masksToBounds或者clipsToBounds，在transform过程中应该会有多余的边界操作，导致会留下残影，找了半天，原因应该是这个
        
        _posterView.backgroundColor = [UIColor blackColor];
        _posterView.layer.contents = (id)[UIImage imageNamed:@"background"].CGImage;
        // 如果用image的话，旋转的时候渲染操作太多，会导致残影
        
        //_posterView.image = [UIImage imageNamed:@"background"];
        [self addSubview:_posterView];
        
        self.button = [[SCCinemaButtonView alloc]initWithFrame:CGRectMake(30.0f, ((self.height / 10.0f ) * 4.0f) - 20.0f, self.width - 60.0f, 60.0f)];
        _button.titleLabel.text = title;
        _button.detailLabel.text = price;
        
        __weak SCCinemaView *weakSelf = self;
        _button.DidTapped = ^{
            [weakSelf cinemaAnimated];
        };
        [self addSubview:_button];
        
        self.descriptionView = [[UITextView alloc] initWithFrame:CGRectMake(30.0f, _button.bottom + 10.0f, self.width - 60.0f, self.height - _button.bottom - 50.0f)];
        _descriptionView.font = [UIFont systemFontOfSize:14.0f];
        _descriptionView.backgroundColor = [UIColor clearColor];
        _descriptionView.editable = NO;
        _descriptionView.textColor = Global_cinemaGray;
        _descriptionView.text = Global_desc;
        [self addSubview:_descriptionView];
        
        self.backButton = [[UIButton alloc]initWithFrame:CGRectMake(30.0f, self.height - 60.0f, 40.0f, 30.0f)];
        [_backButton setTitle:@"Back" forState:UIControlStateNormal];
        _backButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [_backButton setTitleColor:Global_cinemaBlue forState:UIControlStateNormal];
        _backButton.alpha = 0.0f;
        _backButton.hidden = YES;
        [self addSubview:_backButton];
    }
    return self;
}

- (void)cinemaAnimated
{
    CGFloat width = self.width;
    CGFloat height = (self.height / 10.0f ) * 4.0f;
    if(_backButton.hidden)
    {
        _backButton.hidden = NO;
        [self bringSubviewToFront:self.button];
    
        [UIView animateWithDuration:0.2f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.posterView.left = 0.1f * width;
            self.posterView.top = 0.1f * height;
            self.posterView.width = 0.8f * width;
            self.posterView.height = 0.8f * height;
        } completion:^(BOOL finished) {
            
        }];
        
        CABasicAnimation* rotationAnimation;
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
        rotationAnimation.fromValue = [NSValue valueWithCATransform3D:getTransForm3DWithAngle_r(0.0f)];
        rotationAnimation.toValue = [NSValue valueWithCATransform3D:getTransForm3DWithAngle(-M_PI/2.0f)];
        rotationAnimation.duration = 0.4f;
        rotationAnimation.cumulative = YES;
        rotationAnimation.repeatCount = 1;
        rotationAnimation.removedOnCompletion=NO;
        rotationAnimation.fillMode=kCAFillModeForwards;
        rotationAnimation.autoreverses = NO;
        [_posterView.layer addAnimation:rotationAnimation forKey:@"rotationFisrt"];
        
        [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.descriptionView.height = 0.0f;
            
            self.descriptionView.left = self.width - 80.0f;
            self.descriptionView.width = 0.0f;
            self.descriptionView.top = self.height - 60.0f;
            
            self.button.top = self.height - 90.0f;
            self.button.left = self.width - 180.0f;
            self.button.width = 160.0f;
            self.button.titleLabel.text = @"Done";
            self.button.detailLabel.text = @"";
            self.backButton.alpha = 1.0f;
        } completion:^(BOOL finished) {
            [_posterView.layer removeAnimationForKey:@"rotationSecond"];
        }];
    }
    else
    {
        _backButton.hidden = YES;
        self.descriptionView.width = self.width - 60.0f;
        [self bringSubviewToFront:self.button];
        
        [UIView animateWithDuration:0.2f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.posterView.left = 0.0f;
            self.posterView.top = 0.0f;
            self.posterView.width = width;
            self.posterView.height =  height;
        } completion:^(BOOL finished) {
            
        }];
        
        CABasicAnimation* rotationAnimation;
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
        rotationAnimation.fromValue = [NSValue valueWithCATransform3D:getTransForm3DWithAngle(-M_PI/2.0f)];
        rotationAnimation.toValue = [NSValue valueWithCATransform3D:getTransForm3DWithAngle_r(0.0f)];
        rotationAnimation.duration = 0.3f;
        rotationAnimation.cumulative = YES;
        rotationAnimation.repeatCount = 1;
        rotationAnimation.removedOnCompletion=NO;
        rotationAnimation.fillMode=kCAFillModeForwards;
        rotationAnimation.autoreverses = NO;
        [_posterView.layer addAnimation:rotationAnimation forKey:@"rotationSecond"];
        
        [UIView animateWithDuration:0.5f animations:^{
            
            self.button.frame = CGRectMake(30.0f, _posterView.bottom - 20.0f, self.width - 60.0f, 60.0f);
            self.button.titleLabel.text = @"Buy Now";
            self.button.detailLabel.text = @"$29.9";
            
            self.descriptionView.top = _button.bottom + 10.0f;
            self.descriptionView.left = 30.0f;
            self.descriptionView.height = self.height - _button.bottom - 50.0f;
            self.backButton.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [_posterView.layer removeAnimationForKey:@"rotationFisrt"];
        }];
    }
}
@end
