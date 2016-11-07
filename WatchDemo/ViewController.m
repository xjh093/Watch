//
//  ViewController.m
//  WatchDemo
//
//  Created by Lightech on 15-6-18.
//  Copyright (c) 2015年 Lightech. All rights reserved.
//

#import "ViewController.h"
#import "WatchView.h"
#import "FVGravityView.h"

@interface ViewController ()
{
    FVGravityView *gravityView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //self.view.backgroundColor = [UIColor blackColor];
    
    [self initBackgroundImageView];
    [self initView];
}

- (void)initBackgroundImageView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = [UIScreen mainScreen].bounds;
    imageView.image = [UIImage imageNamed:@"background.jpg"];
    [self.view addSubview:imageView];
}

- (void)initView
{
    /**
     *100 - 4
     *110 - 6.5
     *120 - 9
     *130 - 11.5
     *140 - 14
     *150 - 16.5
     *160 - 19
     *170 - 21.5
     *WatchView的width=180时，TimeView的width=130.90914, font-24
     *WatchView的width=190时，TimeView的width=138.18187, font-26.5
     *WatchView的width=200时，TimeView的width=145.4546,  font-29
     *WatchView的width=210时，TimeView的width=152.72733, font-31.5
     *WatchView的width=220时，TimeView的width=160,       font-34
     */
    WatchView *view = [[WatchView alloc] initWithFrame:CGRectMake(5, 20, 220, 220) andFont:34];
    //view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view];
    
    WatchView *view1 = [[WatchView alloc] initWithFrame:CGRectMake(135, 225, 180, 180) andFont:24];
    //view1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view1];
    
    WatchView *view2 = [[WatchView alloc] initWithFrame:CGRectMake(10, 355, 150, 150) andFont:16.5];
    //view2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view2];
    
    WatchView *view3 = [[WatchView alloc] initWithFrame:CGRectMake(170, 425, 120, 120) andFont:9];
    //view3.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view3];
    
//    gravityView = [[FVGravityView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
//    [gravityView setBackgroundColor:[UIColor blueColor]];
//    [self.view addSubview:gravityView];
//    [gravityView setIsDragable:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
