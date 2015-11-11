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
        
        CGFloat seatTop = ((self.height / 10.0f ) * 4.0f) * 0.15f + 80.0f;
        self.seatView = [[SCCinemaSeatView alloc]initWithFrame:CGRectMake(15.0f, seatTop, self.width - 30.0f, self.height - 100.0f - seatTop)];
        _seatView.alpha = 0.0f;
        _seatView.layer.masksToBounds = YES;
        [self addSubview:_seatView];
        
        self.posterHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.width, 0.0f)];
        _posterHeaderView.backgroundColor = Global_cinemaBlue;
        [self addSubview:_posterHeaderView];
        
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
        
        // 这是海报图上面的蓝色顶部
        
        self.button = [[SCCinemaButtonView alloc]initWithFrame:CGRectMake(30.0f, ((self.height / 10.0f ) * 4.0f) - 20.0f, self.width - 60.0f, 60.0f)];
        _button.titleLabel.text = title;
        _button.detailLabel.text = price;
        //_button.layer.anchorPoint = CGPointMake(0, 0.5);
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
        
        self.backButton = [[UIButton alloc]initWithFrame:CGRectMake(20.0f, self.height - 90.0f, 60.0f, 60.0f)];
        //[_backButton setTitle:@"Back" forState:UIControlStateNormal];
        //_backButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        //[_backButton setTitleColor:Global_cinemaBlue forState:UIControlStateNormal];
        _backButton.contentMode = UIViewContentModeScaleAspectFill;
        _backButton.layer.shadowOffset = CGSizeMake(0, 10);
        _backButton.layer.shadowOpacity = 0.5f;
        _backButton.layer.shadowRadius = 10.0f;
        _backButton.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        
        [_backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        _backButton.alpha = 0.0f;
        [_backButton addTarget:self action:@selector(cinemaAnimated) forControlEvents:UIControlEventTouchUpInside];
        _backButton.hidden = YES;
        [self addSubview:_backButton];
    }
    return self;
}

- (void)cinemaAnimated
{
    CGFloat width = self.width;
    CGFloat height = (self.height / 10.0f ) * 4.0f;
    
    [self bringSubviewToFront:self.posterView];
    [self bringSubviewToFront:self.button];
    if(_backButton.hidden)
    {
        _backButton.hidden = NO;
        self.posterHeaderView.left = 0.05f * width;
        self.posterHeaderView.top = 0.15f * height - 0.5f;
        self.posterHeaderView.width = 0.9f * width;
        self.posterHeaderView.height = 5.0f;
        self.posterHeaderView.alpha = 0.0f;
        
        [_posterView.layer addAnimation:[self rotationAnimationDisappear] forKey:@"rotationFisrt"];
        [_seatView.layer addAnimation:[self scaleAnimationSmaller] forKey:@"scaleFirst"];
        //[_button.layer addAnimation:[self BezierMoveAnimation] forKey:@"moveFirst"];
        
        [UIView animateWithDuration:0.3f delay:0.2f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.posterHeaderView.alpha = 1.0f;
        } completion:^(BOOL finished) {
        }];
        
        [UIView animateWithDuration:0.4f delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.posterView.left = 0.05f * width;
            self.posterView.top = 0.15f * height;
            self.posterView.width = 0.9f * width;
            self.posterView.height = 0.7f * height;
            
            self.descriptionView.alpha = 0.0f;
            self.descriptionView.left = self.width/3.0f;
            self.descriptionView.top = self.height - 60.0f;
            
            self.seatView.alpha = 1.0f;
            
            self.button.top = self.height - 90.0f;
            self.button.left = self.width/3.0f;
            self.button.width = (self.width/3.0f) * 2.0f - 20.0f;
            self.button.titleLabel.text = @"Done";
            self.button.detailLabel.text = @"";
            
            self.backButton.alpha = 1.0f;
        } completion:^(BOOL finished) {
            [_posterView.layer removeAnimationForKey:@"rotationSecond"];
            [_seatView.layer removeAnimationForKey:@"scaleSecond"];
            [_button.layer removeAnimationForKey:@"moveSecond"];
            //self.button.frame = CGRectMake(self.width/3.0f, self.height - 90.0f, (self.width/3.0f) * 2.0f - 20.0f, 60.0f);
        }];
    }
    else
    {
        _backButton.hidden = YES;
        self.descriptionView.width = self.width - 60.0f;
        self.posterHeaderView.width = width;
        self.posterHeaderView.height = 0.0f;
        self.posterHeaderView.left = 0.0f;
        self.posterHeaderView.top = 0.0f;
        self.posterHeaderView.alpha = 0.0f;
        
        [_posterView.layer addAnimation:[self rotationAnimationAppear] forKey:@"rotationSecond"];
        [_seatView.layer addAnimation:[self scaleAnimationBigger] forKey:@"scaleSecond"];
        //[_button.layer addAnimation:[self BezierMoveAnimationBack] forKey:@"moveSecond"];
        
        [UIView animateWithDuration:0.4f delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.posterView.left = 0.0f;
            self.posterView.top = 0.0f;
            self.posterView.width = width;
            self.posterView.height =  height;
            
            self.descriptionView.alpha = 1.0f;

            self.seatView.alpha = 0.0f;
            
            self.button.width = self.width - 60.0f;
            self.button.top = ((self.height / 10.0f ) * 4.0f) - 20.0f;
            self.button.left = 30.0f;
            self.button.titleLabel.text = @"Buy Now";
            self.button.detailLabel.text = @"$29.9";
            
            self.descriptionView.top = _posterView.bottom + 50.0f;
            self.descriptionView.left = 30.0f;
            self.backButton.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [_posterView.layer removeAnimationForKey:@"rotationFisrt"];
            [_seatView.layer removeAnimationForKey:@"scaleFirst"];
            [_button.layer removeAnimationForKey:@"moveFirst"];
            //self.button.frame = CGRectMake(30.0f, _posterView.bottom - 20.0f, self.width - 60.0f, 60.0f);
        }];
    }
}

- (CABasicAnimation *)rotationAnimationDisappear
{
    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    rotationAnimation.fromValue = [NSValue valueWithCATransform3D:getTransForm3DWithAngle_r(0.0f)];
    rotationAnimation.toValue = [NSValue valueWithCATransform3D:getTransForm3DWithAngle(-radians(89.0f))];
    rotationAnimation.duration = 0.4f;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 1;
    rotationAnimation.removedOnCompletion=NO;
    rotationAnimation.fillMode=kCAFillModeForwards;
    rotationAnimation.autoreverses = NO;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    return rotationAnimation;
}

- (CABasicAnimation *)rotationAnimationAppear
{
    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    rotationAnimation.fromValue = [NSValue valueWithCATransform3D:getTransForm3DWithAngle(-M_PI/2.0f)];
    rotationAnimation.toValue = [NSValue valueWithCATransform3D:getTransForm3DWithAngle_r(0.0f)];
    rotationAnimation.duration = 0.4f;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 1;
    rotationAnimation.removedOnCompletion=NO;
    rotationAnimation.fillMode=kCAFillModeForwards;
    rotationAnimation.autoreverses = NO;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    return rotationAnimation;
}

- (CABasicAnimation *)scaleAnimationSmaller
{
    CABasicAnimation *scaleAnimation;
    scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.3f];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    scaleAnimation.duration = 0.4f;
    scaleAnimation.cumulative = YES;
    scaleAnimation.repeatCount = 1;
    scaleAnimation.removedOnCompletion=NO;
    scaleAnimation.fillMode=kCAFillModeForwards;
    scaleAnimation.autoreverses = NO;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    return scaleAnimation;
}

- (CABasicAnimation *)scaleAnimationBigger
{
    CABasicAnimation *scaleAnimation;
    scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.3f];
    scaleAnimation.duration = 0.4f;
    scaleAnimation.cumulative = YES;
    scaleAnimation.repeatCount = 1;
    scaleAnimation.removedOnCompletion=NO;
    scaleAnimation.fillMode=kCAFillModeForwards;
    scaleAnimation.autoreverses = NO;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    return scaleAnimation;
}

- (CAAnimationGroup *)BezierMoveAnimation
{
    CABasicAnimation *scaleAnimation;
    scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    scaleAnimation.duration = 0.4f;
    scaleAnimation.cumulative = YES;
    scaleAnimation.repeatCount = 1;
    scaleAnimation.removedOnCompletion=NO;
    scaleAnimation.fillMode=kCAFillModeForwards;
    scaleAnimation.autoreverses = NO;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration=0.5f;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount=1;
    animation.calculationMode = kCAAnimationCubicPaced;
    animation.autoreverses = NO;

    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL, self.width/2.0f, ((self.height / 10.0f ) * 4.0f) + 10.0f);
    CGFloat top = self.height - 60.0f;
    CGFloat left = (self.width / 3.0f) * 2.0f - 10.0f;
    CGPathAddQuadCurveToPoint(curvedPath, NULL,self.width/2.0f + 30.0f,self.height/2.0f + 30.0f,left,top);
    
    animation.path=curvedPath;
    CGPathRelease(curvedPath);
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = [NSArray arrayWithObjects:scaleAnimation,animation, nil];
    group.duration = 0.5f;
    group.removedOnCompletion = NO;
    group.autoreverses = NO;
    group.fillMode = kCAFillModeForwards;
    return group;
}

- (CAAnimationGroup *)BezierMoveAnimationBack
{
    CABasicAnimation *scaleAnimation;
    scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    scaleAnimation.duration = 0.4f;
    scaleAnimation.cumulative = YES;
    scaleAnimation.repeatCount = 1;
    scaleAnimation.removedOnCompletion=NO;
    scaleAnimation.fillMode=kCAFillModeForwards;
    scaleAnimation.autoreverses = NO;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration=0.5f;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount=1;
    animation.calculationMode = kCAAnimationCubicPaced;
    animation.autoreverses = NO;
    
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL, (self.width / 3.0f) * 2.0f - 10.0f,self.height - 60.0f);
    CGFloat left = self.width/2.0f;
    CGFloat top = ((self.height / 10.0f ) * 4.0f) + 10.0f;
    CGPathAddQuadCurveToPoint(curvedPath, NULL,self.width/2.0f + 30.0f,self.height/2.0f + 30.0f,left,top);
    
    animation.path=curvedPath;
    CGPathRelease(curvedPath);
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = [NSArray arrayWithObjects:scaleAnimation,animation, nil];
    group.duration = 0.5f;
    group.removedOnCompletion = NO;
    group.autoreverses = NO;
    group.fillMode = kCAFillModeForwards;
    return group;
}
@end
