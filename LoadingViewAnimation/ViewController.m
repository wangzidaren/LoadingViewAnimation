//
//  ViewController.m
//  LoadingViewAnimation
//
//  Created by tracy wang on 16/1/30.
//  Copyright © 2016年 tracy wang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];


    
    _loadingView=[[UIView alloc] init];
    _loadingView.frame=CGRectMake(self.view.frame.size.width/2-100/2, self.view.frame.size.height/2-120/2, 100, 120);
    _loadingView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_loadingView];

    _shapeView=[[ShapeLoadingView alloc] initWithFrame:CGRectMake(0, 0, 100, 120) title:@"加载中..."];
    _shapeView.backgroundColor=[UIColor clearColor];
    [_loadingView addSubview:_shapeView];

    _loadingView.alpha=0;

    
    UIButton *_startButton=[UIButton buttonWithType:UIButtonTypeSystem];
    _startButton.frame=CGRectMake(50, _loadingView.frame.origin.y+_loadingView.frame.size.height+40, 60, 30);
    [_startButton setTitle:@"开始" forState:UIControlStateNormal];
    [self.view addSubview:_startButton];
    [_startButton addTarget:self action:@selector(startPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *_stopButton=[UIButton buttonWithType:UIButtonTypeSystem];
    _stopButton.frame=CGRectMake(self.view.frame.size.width-60-50, _loadingView.frame.origin.y+_loadingView.frame.size.height+40, 60, 30);
    [_stopButton setTitle:@"结束" forState:UIControlStateNormal];
    [self.view addSubview:_stopButton];
    [_stopButton addTarget:self action:@selector(stopPressed:) forControlEvents:UIControlEventTouchUpInside];
    
}


-(void) startPressed:(UIButton *)button
{



    _loadingView.alpha=1;
    
    [_shapeView startAnimating];
    
    


}


-(void) stopPressed:(UIButton *)button
{
    
    
    
    _loadingView.alpha=0;
    
    [_shapeView stopAnimating];
    
    
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
