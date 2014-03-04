//
//  TopRatedViewController.m
//  rbox
//
//  Created by Wan Wei on 14-2-26.
//  Copyright (c) 2014年 Wan Wei. All rights reserved.
//

#import "TopRatedViewController.h"
#import "MP.h"
#import "UIImageView+AFNetworking.h"
#import <AVFoundation/AVFoundation.h>
#import "FFCircularProgressView.h"
#import "UIColor+iOS7.h"
#import "UIScrollView+SVPullToRefresh.h"    
#import "UIScrollView+SVInfiniteScrolling.h"
#import "YWRoundProgressView.h"

#define PlayingCellTag 100

@interface TopRatedViewController ()

@end

@implementation TopRatedViewController {
    NSMutableArray *allRingtones;
    AVPlayer *anAudioStreamer;
    NSTimer * audioTimer;
    MPQuery *query;
    NSInteger currentIndex;
    CGFloat playingProgress;
    PPlayStatus currentPlayingStatus;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"cancel" style:UIBarButtonItemStyleBordered target:self action:nil];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    if (allRingtones == nil) {
        allRingtones = [[NSMutableArray alloc] init];
    }
    
    __weak TopRatedViewController *weakSelf = self;

    // setup pull-to-refresh
    [self.tableView addPullToRefreshWithActionHandler:^{
        [weakSelf reloadData];
    }];
    
    // setup infinite scrolling
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf loadMoreData];
    }];
    
    query = [MPQuery queryWithClassName:@"ringtones"];
    [self reloadData];
    
}

-(void) reloadData
{
    query.skip = 0;
    [query orderByAscending:@"share"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"load ringtones error: %@", error);
        } else {
            [allRingtones removeAllObjects];
            [allRingtones addObjectsFromArray:objects];
            [self.tableView reloadData];
        }

        [self.tableView.pullToRefreshView stopAnimating];
    }];
}

-(void) loadMoreData
{
    query.skip += query.limit;
    [query orderByAscending:@"share"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"load ringtones error: %@", error);
        } else {
            [allRingtones addObjectsFromArray:objects];
            [self.tableView reloadData];
        }
        
        [self.tableView.infiniteScrollingView stopAnimating];
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [allRingtones count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    YWRoundProgressView * roundview = (YWRoundProgressView *)[cell viewWithTag:1000];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

        if (roundview) {
            [roundview removeFromSuperview];
            roundview = nil;
        }
        roundview = [[YWRoundProgressView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
        roundview.bgImage = [UIImage imageNamed:@"default_avatar.png"];
        roundview.filColor = [UIColor blueColor];
        [cell addSubview:roundview];
        roundview.tag = 1000;
    }
    
    MPObject *object = allRingtones[indexPath.row];
    cell.textLabel.text = object[@"name"];
    
    roundview.bgImageStr = object[@"icon"];
    
    if (currentIndex == indexPath.row+PlayingCellTag) {
        roundview.status = currentPlayingStatus;
        roundview.progress = playingProgress;
    }else {
        roundview.status = PPlayStatusNormal;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MPObject *object = allRingtones[indexPath.row];
    NSLog(@"mp3=%@", object[@"url"]);
    [self playSampleSong:object[@"url"] withIndex:indexPath.row];
    
}

- (void)playSampleSong:(NSString *)aSongURL withIndex:(int)index {
    if (audioTimer) {
        [audioTimer invalidate];
        audioTimer = nil;
    }
    AVPlayerItem *aPlayerItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:aSongURL]];
    if (anAudioStreamer == nil) {
        anAudioStreamer = [[AVPlayer alloc] initWithPlayerItem:aPlayerItem];
    }
    
    if (index == currentIndex-PlayingCellTag) {
        YWRoundProgressView * view = [self getRoundPlayingViewWithIndex:currentIndex-PlayingCellTag];
        if (view) {
            if (view.status == PPlayStatusNormal || view.status == PPlayStatusStop) {// 如果是播放结束了 则继续播放
                view.status = PPlayStatusPlaying;
                [anAudioStreamer replaceCurrentItemWithPlayerItem:aPlayerItem];
                [anAudioStreamer play];
                [self setAudioPlayTimer];
            }
            else if (view.status == PPlayStatusPause) {//暂停  则播放
                view.status = PPlayStatusPlaying;
                [anAudioStreamer play];
                [self setAudioPlayTimer];
            }
            else if (view.status == PPlayStatusPlaying) {
                [anAudioStreamer pause];
                view.status = PPlayStatusPause;
            }
            
            currentPlayingStatus = view.status;
        }
    }else {
        YWRoundProgressView * tempview = [self getRoundPlayingViewWithIndex:currentIndex-PlayingCellTag];
        if (tempview) {
            tempview.status = PPlayStatusNormal;
        }
        currentIndex = index+PlayingCellTag;
        YWRoundProgressView * view = [self getRoundPlayingViewWithIndex:index];
        if (view) {
            view.status = PPlayStatusPlaying;
        }

        [anAudioStreamer pause];
        [anAudioStreamer replaceCurrentItemWithPlayerItem:aPlayerItem];
        [anAudioStreamer play];
        [self setAudioPlayTimer];
        
        currentPlayingStatus = view.status;

    }
    
}

- (void)setAudioPlayTimer {
    audioTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(setPlayerState) userInfo:nil repeats:YES];
}

-(void) setPlayerState {
    // Access Current Time
    NSTimeInterval aCurrentTime = CMTimeGetSeconds(anAudioStreamer.currentTime);
    
    // Access Duration
    NSTimeInterval aDuration = CMTimeGetSeconds(anAudioStreamer.currentItem.duration);
    
    NSLog(@"currentTime=%f duration=%f progress=%f", aCurrentTime, aDuration,aCurrentTime/aDuration);
    
    YWRoundProgressView * view = [self getRoundPlayingViewWithIndex:currentIndex-PlayingCellTag];
    if (view) {
        view.progress = aCurrentTime/aDuration;
        playingProgress = view.progress;
    }
    
    if (fabs(aCurrentTime - aDuration) < FLT_EPSILON) {
        [audioTimer invalidate];
        audioTimer = nil;
        if (view) {
            view.status = PPlayStatusStop;
        }
    }
}

- (YWRoundProgressView *)getRoundPlayingViewWithIndex:(int)index {
    UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    YWRoundProgressView * view = (YWRoundProgressView *)[cell viewWithTag:1000];
    if (view && [view isKindOfClass:[YWRoundProgressView class]]) {
        return view;
    }
    return nil;
}

- (void)setPlayingIndex:(int)index {
    if (currentIndex != index+PlayingCellTag ) {
        YWRoundProgressView * tempview = [self getRoundPlayingViewWithIndex:currentIndex-100];
        if (tempview) {
            tempview.status = PPlayStatusNormal;
        }
        currentIndex = index+PlayingCellTag;
        YWRoundProgressView * view = [self getRoundPlayingViewWithIndex:index];
        if (view) {
            view.status = PPlayStatusPlaying;
        }
    }
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
