//
//  ShapeLoadingView.h
//  TestEducation
//
//  Created by tracy wang on 15/12/4.
//  Copyright © 2015年 tracy wang. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 *模仿58同城的loading视图
 */
@interface ShapeLoadingView : UIView
{


    
    
    
    UIImageView *_shapView;
    
    UIImageView *_shadowView;
    
    
    
    
    float _toValue;
    float _fromValue;
    
    
    
    float _scaletoValue;
    float _scalefromValue;
    
    
    

}

- (id)initWithFrame:(CGRect)frame title:(NSString *)title;



-(void) step;

-(void) startAnimating;

-(void) stopAnimating;



@end
