//
//  SecondViewController.m
//  rbox
//
//  Created by Wan Wei on 14-2-26.
//  Copyright (c) 2014年 Wan Wei. All rights reserved.
//

#import "SecondViewController.h"
#import "FFCircularProgressView.h"
#import "UIColor+iOS7.h"

@interface SecondViewController ()

@property (strong) FFCircularProgressView *circularPV;

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.circularPV = [[FFCircularProgressView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    _circularPV.center = self.view.center;
    
    [self.view addSubview:_circularPV];
    
    [_circularPV startSpinProgressBackgroundLayer];
    
    double delayInSeconds = 2.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void){
        for (float i=0; i<1.1; i+=0.01F) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [_circularPV setProgress:i];
            });
            usleep(10000);
        }
        
        double delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [_circularPV setProgress:0];
        });
    });
    
    delayInSeconds = 2;
    popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [_circularPV stopSpinProgressBackgroundLayer];
    });

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
