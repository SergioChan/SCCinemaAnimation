# SCCinemaAnimation
An iOS native implementation of a Cinema Animation Application. See more at https://dribbble.com/shots/2339238-Animation-for-Cinema-Application.

iOS上电影购票的动效实现。微博上看到@壹了人拾做的设计，实现了一个demo。

## Preview

![image](https://raw.githubusercontent.com/SergioChan/SCCinemaAnimation/master/Image/preview.png)

![image](https://raw.githubusercontent.com/SergioChan/SCCinemaAnimation/master/Image/preview.gif)

## Intro

设计创意和动效全部来自于[Xer.Lee](https://dribbble.com/xerlee)在Dribbble上的作品：[https://dribbble.com/shots/2339238-Animation-for-Cinema-Application](https://dribbble.com/shots/2339238-Animation-for-Cinema-Application)。这是一个在iOS上原生实现的相似交互的开源库，没有百分百和设计原稿一致。

没什么特别的……就是一个效果的展示吧。觉得酷炫所以就做了。实现的有些匆忙。

The design was originated from [Xer.Lee](https://dribbble.com/xerlee)'s work on Dribbble:[https://dribbble.com/shots/2339238-Animation-for-Cinema-Application](https://dribbble.com/shots/2339238-Animation-for-Cinema-Application). This is an open-sourced iOS-native libray similar to this design, not 100% equivalent to the original desgin.


## Version 

1.0

## Environment

iOS 8.0 以上 iPhone 5s/iPhone6/iPhone6 Plus 测试通过 iOS 8.0 Above iPhone 5s/6/6 Plus Tested

## Usage

The initialization is very simple. Just like the sample below:

```Objective-C
SCCinemaView *cinemaView = [[SCCinemaView alloc]initWithFrame:CGRectMake(20.0f, 80.0f, ScreenWidth - 40.0f, ScreenHeight - 160.0f) buttonTitle:@"Buy Now" price:@"$29.9"];

cinemaView.posterView.layer.position = CGPointMake(cinemaView.width / 2.0f, 0.0f);
```
