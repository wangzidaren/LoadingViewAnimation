//
//  ShapeLoadingView.m
//  TestEducation
//
//  Created by tracy wang on 15/12/4.
//  Copyright © 2015年 tracy wang. All rights reserved.
//

#import "ShapeLoadingView.h"



@interface ShapeLoadingView ()

@property (nonatomic, assign) int stepNumber;
@property (nonatomic, assign) BOOL isAnimating;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, copy) NSString *titleString;


@end

@implementation ShapeLoadingView


#define ANIMATION_DURATION_SECS 0.5f


- (id)initWithFrame:(CGRect)frame title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        self.titleString=title;
        
        [self step];
        
    }
    
    return self;
}


-(void) step
{


    
    _shapView=[[UIImageView alloc] init];
    _shapView.frame=CGRectMake(self.frame.size.width/2-31/2, 0, 31, 31);
    _shapView.image=[UIImage imageNamed:@"loading_circle"];
    _shapView.contentMode=UIViewContentModeScaleAspectFit;
    [self addSubview:_shapView];

    
    //阴影
    _shadowView=[[UIImageView alloc] init];
    _shadowView.frame=CGRectMake(self.frame.size.width/2-37/2, self.frame.size.height-2.5-30, 37, 2.5);
    _shadowView.image=[UIImage imageNamed:@"loading_shadow"];
    [self addSubview:_shadowView];
    
    
    UILabel *_label=[[UILabel alloc] init];
    _label.frame=CGRectMake(0, self.frame.size.height-20, self.frame.size.width, 20);
    _label.textColor=[UIColor grayColor];
    _label.textAlignment=NSTextAlignmentCenter;
    _label.text=_titleString;
    _label.font=[UIFont systemFontOfSize:13.0f];
    
    [self addSubview:_label];

    
    
    _fromValue=_shapView.frame.size.height/2;
    _toValue=self.frame.size.height-30-_shapView.frame.size.height/2-_shadowView.frame.size.height;
    
    
    _scalefromValue=0.3f;
    _scaletoValue=1.0f;
    
    self.alpha=0;
    
}


-(void) startAnimating
{

    if (!_isAnimating)
    {
        _isAnimating = YES;
        
        self.alpha=1;

        _timer = [NSTimer scheduledTimerWithTimeInterval:ANIMATION_DURATION_SECS target:self selector:@selector(animateNextStep) userInfo:nil repeats:YES];
    }

    



}


-(void) stopAnimating
{
    
    _isAnimating = NO;

    [_timer invalidate];
    
    _stepNumber = 0;
    
    self.alpha=0;

    
    [_shapView.layer removeAllAnimations];
    
    [_shadowView.layer removeAllAnimations];

    _shapView.image=[UIImage imageNamed:@"loading_circle"];


}


-(void)animateNextStep
{
    switch (_stepNumber)
    {
        case 0:
        {
            
            
            _shapView.image=[UIImage imageNamed:@"loading_circle"];
            
            
            [self loadingAnimation:_fromValue toValue:_toValue timingFunction:kCAMediaTimingFunctionEaseIn];
            
            [self scaleAnimation:_scalefromValue toValue:_scaletoValue timingFunction:kCAMediaTimingFunctionEaseIn];
            
            
        }
            break;
        case 1:
        {
            
            
            _shapView.image=[UIImage imageNamed:@"loading_square"];
            
            [self loadingAnimation:_toValue toValue:_fromValue timingFunction:kCAMediaTimingFunctionEaseOut];

            [self scaleAnimation:_scaletoValue toValue:_scalefromValue timingFunction:kCAMediaTimingFunctionEaseIn];

        }
            break;
        case 2:
        {
        
        
            
            _shapView.image=[UIImage imageNamed:@"loading_square"];

            [self loadingAnimation:_fromValue toValue:_toValue timingFunction:kCAMediaTimingFunctionEaseIn];

            [self scaleAnimation:_scalefromValue toValue:_scaletoValue timingFunction:kCAMediaTimingFunctionEaseIn];


        }
            break;
            
        case 3:
        {

            _shapView.image=[UIImage imageNamed:@"loading_triangle"];

        
            [self loadingAnimation:_toValue toValue:_fromValue timingFunction:kCAMediaTimingFunctionEaseOut];

            [self scaleAnimation:_scaletoValue toValue:_scalefromValue timingFunction:kCAMediaTimingFunctionEaseIn];

            

        }
            
            break;
            
        case 4:
        {
            
            _shapView.image=[UIImage imageNamed:@"loading_triangle"];
            
            [self loadingAnimation:_fromValue toValue:_toValue timingFunction:kCAMediaTimingFunctionEaseIn];

            
            [self scaleAnimation:_scalefromValue toValue:_scaletoValue timingFunction:kCAMediaTimingFunctionEaseIn];

        }
            
            break;
        case 5:
        {
            
            _shapView.image=[UIImage imageNamed:@"loading_circle"];
            
            [self loadingAnimation:_toValue toValue:_fromValue timingFunction:kCAMediaTimingFunctionEaseOut];
            
            [self scaleAnimation:_scaletoValue toValue:_scalefromValue timingFunction:kCAMediaTimingFunctionEaseIn];

            
            _stepNumber = -1;
            
        }
            
            break;

        default:
            break;
    }
    
    _stepNumber++;
}


-(void) loadingAnimation:(float)fromValue toValue:(float)toValue timingFunction:(NSString * const)tf
{


    //位置
    CABasicAnimation *panimation = [CABasicAnimation animation];
    panimation.keyPath = @"position.y";
    panimation.fromValue =@(fromValue);
    panimation.toValue = @(toValue);
    panimation.duration = ANIMATION_DURATION_SECS;
    
    panimation.timingFunction = [CAMediaTimingFunction functionWithName:tf];
    
    
    //旋转
    CABasicAnimation *ranimation = [CABasicAnimation animation];
    ranimation.keyPath = @"transform.rotation";
    ranimation.fromValue =@(0);
    ranimation.toValue = @(M_PI_2);
    ranimation.duration = ANIMATION_DURATION_SECS;
    
    ranimation.timingFunction = [CAMediaTimingFunction functionWithName:tf];
    


    //组合
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.animations = @[ panimation,ranimation];
    group.duration = ANIMATION_DURATION_SECS;
    group.beginTime = 0;
    group.fillMode=kCAFillModeForwards;
    group.removedOnCompletion = NO;


    [_shapView.layer addAnimation:group forKey:@"basic"];
    
   



}

-(void) scaleAnimation:(float) fromeValue toValue:(float)toValue timingFunction:(NSString * const)tf
{

    //缩放
    CABasicAnimation *sanimation = [CABasicAnimation animation];
    sanimation.keyPath = @"transform.scale";
    sanimation.fromValue =@(fromeValue);
    sanimation.toValue = @(toValue);
    sanimation.duration = ANIMATION_DURATION_SECS;
    
    sanimation.fillMode = kCAFillModeForwards;
    sanimation.timingFunction = [CAMediaTimingFunction functionWithName:tf];
    sanimation.removedOnCompletion = NO;

    [_shadowView.layer addAnimation:sanimation forKey:@"shadow"];
    

}


- (BOOL)isAnimating
{
    return _isAnimating;
}



- (void)dealloc
{
    


    
}




@end
