//
//  YWRoundProgressView.m
//  FFCircularProgressView
//
//  Created by yangw on 14-3-1.
//  Copyright (c) 2014年 Fabiano Francesconi. All rights reserved.
//

#import "YWRoundProgressView.h"
#import <AVFoundation/AVFoundation.h>
#import "UIImageView+AFNetworking.h"

@interface RoundProgress : UIView {
    float _progress;
	UIColor * _filColor;
	float _filWidth;

}

@property (nonatomic, assign) float progress;

@end

@implementation RoundProgress

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
		self.opaque = NO;
        self.clipsToBounds = NO;
		_progress = 0.0f;
		_filColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0f];
		_filWidth = 6.0f;

    }
    return self;
}

- (void)setProgress:(float)progress {
	_progress = progress;
	[self setNeedsDisplay];
}

- (void)setFilColor:(UIColor *)filColor {
    _filColor = nil;
	_filColor = filColor;
	[self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	CGRect allRect = self.bounds;
	CGRect circleRect = CGRectInset(allRect, 2.0f, 2.0f);
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	if (YES) {
		// Draw background
		CGFloat lineWidth = _filWidth;
		UIBezierPath *processBackgroundPath = [UIBezierPath bezierPath];
		processBackgroundPath.lineWidth = lineWidth;
		processBackgroundPath.lineCapStyle = kCGLineCapRound;
		CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
		CGFloat radius = (self.bounds.size.width - lineWidth)/2;
		CGFloat startAngle = - ((float)M_PI / 2); // 90 degrees
		CGFloat endAngle = (2 * (float)M_PI) + startAngle;
		[processBackgroundPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
		[[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0f] set];
		[processBackgroundPath stroke];
		// Draw progress
		UIBezierPath *processPath = [UIBezierPath bezierPath];
		processPath.lineCapStyle = kCGLineCapRound;
		processPath.lineWidth = lineWidth;
		endAngle = (self.progress * 2 * (float)M_PI) + startAngle;
		[processPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
		[_filColor set];
		[processPath stroke];
	} else {
		// Draw background
		CGContextSetRGBStrokeColor(context, 1.0f, 1.0f, 1.0f, 1.0f); // white
		CGContextSetRGBFillColor(context, 1.0f, 1.0f, 1.0f, 0.0f); // translucent white
		CGContextSetLineWidth(context, 2.0f);
		CGContextFillEllipseInRect(context, circleRect);
		CGContextStrokeEllipseInRect(context, circleRect);
		// Draw progress
		CGPoint center = CGPointMake(allRect.size.width / 2, allRect.size.height / 2);
		CGFloat radius = (allRect.size.width - 4) / 2;
		CGFloat startAngle = - ((float)M_PI / 2); // 90 degrees
		CGFloat endAngle = (self.progress * 2 * (float)M_PI) + startAngle;
		CGContextSetRGBFillColor(context, 1.0f, 1.0f, 1.0f, 1.0f); // white
		CGContextMoveToPoint(context, center.x, center.y);
		CGContextAddArc(context, center.x, center.y, radius, startAngle, endAngle, 0);
		CGContextClosePath(context);
		CGContextFillPath(context);
	}
}



@end

@interface YWRoundProgressView () <AVAudioPlayerDelegate> {
    UIColor * _filColor;
	float _filWidth;

    UIImageView * _bgImageView;
    RoundProgress * _roundProgress;
    UIImageView * _maskControlView;
    
    UIButton * _playButton;
    
    AVAudioPlayer * _voicePlayer;
}

@end

@implementation YWRoundProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        _bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _bgImageView.layer.cornerRadius = CGRectGetWidth(frame)*0.5;
        _bgImageView.clipsToBounds = YES;
        [self addSubview:_bgImageView];
        
        _roundProgress = [[RoundProgress alloc] initWithFrame:self.bounds];
        _roundProgress.userInteractionEnabled = NO;
        [self addSubview:_roundProgress];
        
        _maskControlView = [[UIImageView alloc] initWithFrame:CGRectInset(self.bounds, 10, 10)];
        _maskControlView.image = [UIImage imageNamed:@"welfare_icon_picplay"];
        [self addSubview:_maskControlView];
        _maskControlView.hidden = YES;
        
//        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _playButton.frame = self.bounds;
//        [self addSubview:_playButton];
//        [_playButton addTarget:self action:@selector(playButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame bgImageName:(NSString *)imageS {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.bgImage = [UIImage imageNamed:imageS];
    }
    return self;
}

- (void)setBgImage:(UIImage *)bgImage_ {
    _bgImage = nil;
    _bgImage = bgImage_;
    
    _bgImageView.image = bgImage_;
}

- (void)setBgImageStr:(NSString *)bgImageStr_ {
    _bgImageStr = nil;
    _bgImageStr = bgImageStr_;
    
    [_bgImageView setImageWithURL:[NSURL URLWithString:bgImageStr_] placeholderImage:[UIImage imageNamed:@"default_avatar.png"]];
}

- (void)setFilColor:(UIColor *)filColor_ {
    _filColor = nil;
    _filColor = filColor_;
    [_roundProgress setFilColor:filColor_];
}

- (void)setProgress:(CGFloat)progress_ {
    _progress = progress_;
    
    _roundProgress.progress = _progress;

}

- (AVAudioPlayer *)player {
    if (_voicePlayer == nil) {
        _voicePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"voice" ofType:@"mp3"]] error:nil];
        _voicePlayer.delegate = self;
    }
    return _voicePlayer;
}

- (void)setStatus:(PPlayStatus)status_ {
    _status = status_;
    switch (status_) {
        case PPlayStatusNormal:
            _maskControlView.hidden = YES;
            _roundProgress.progress = 0;
            break;
        case PPlayStatusPlaying:
            _maskControlView.hidden = NO;
            _maskControlView.image = [UIImage imageNamed:@"welfare_icon_suspended"];
            break;
        case PPlayStatusPause:
            _maskControlView.hidden = NO;
            _maskControlView.image = [UIImage imageNamed:@"welfare_icon_picplay"];
            break;
        case PPlayStatusStop:
            _maskControlView.hidden = NO;
            _maskControlView.image = [UIImage imageNamed:@"welfare_icon_picplay"];
            break;
            
        default:
            break;
    }
}

- (void)setNeedsDisplay {
    [super setNeedsDisplay];
    [_roundProgress setNeedsDisplay];
}



@end
