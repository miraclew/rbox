//
//  YWRoundProgressView.h
//  FFCircularProgressView
//
//  Created by yangw on 14-3-1.
//  Copyright (c) 2014年 Fabiano Francesconi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    PPlayStatusNormal = 0,
    PPlayStatusPlaying,
    PPlayStatusPause,
    PPlayStatusStop,
}PPlayStatus;

@interface YWRoundProgressView : UIView

@property (nonatomic, retain)UIImage * bgImage;
@property (nonatomic, retain)NSString * bgImageStr;
@property (nonatomic, retain)UIColor * filColor;
@property (nonatomic, assign)CGFloat progress;
@property (nonatomic, retain)NSURL * voiceUrl;
@property (nonatomic, assign)PPlayStatus status;

@end
