//
//  PhotoClipView.h
//  ZuoYe
//
//  Created by vision on 2018/8/4.
//  Copyright © 2018年 vision. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PhotoClipViewDelegate <NSObject>

//取消
-(void)photoClipViewCancelTakePhoto;

//确定
-(void)photoClipViewConfirmTakeImage:(UIImage *)image;

//重拍
-(void)photoClipViewRemakePhoto;

@end

@interface PhotoClipView : UIView

@property (nonatomic ,weak )id<PhotoClipViewDelegate>delegate;

@property (nonatomic ,strong)UIImage *image;


@end
