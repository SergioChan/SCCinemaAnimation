//
//  ViewController.m
//  SCCinemaAnimation
//
//  Created by Yh c on 15/11/8.
//  Copyright © 2015年 Yh c. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    SCCinemaView *cinemaView = [[SCCinemaView alloc]initWithFrame:CGRectMake(20.0f, 80.0f, ScreenWidth - 40.0f, ScreenHeight - 160.0f) buttonTitle:@"Buy Now" price:@"$29.9"];
    cinemaView.posterView.layer.position = CGPointMake(cinemaView.width / 2.0f, 0.0f);
    [self.view addSubview:cinemaView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
