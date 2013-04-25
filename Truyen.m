//
//  Truyen.m
//  CoGiaoEmTieuThuyet
//
//  Created by KIENND on 4/25/13.
//  Copyright (c) 2013 TechMaster. All rights reserved.
//

#import "Truyen.h"

@implementation Truyen



- (id) initWithName:(NSString*) name
              Frame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _timer  = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                   target:self
                                                 selector:@selector(checkDuration)
                                                 userInfo:nil
                                                  repeats:YES];
        NSString* path = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
        NSLog(@"%@",path);
        _arrPage = [NSMutableArray arrayWithContentsOfFile:path];
        
        _numPage = [_arrPage count]-1;
        _photoArray = [[NSMutableArray alloc] initWithCapacity:_numPage];
        for (NSDictionary *pg in _arrPage) {
          
            Page* page = [[Page alloc] initWithFrame:self.frame
                                           startTime:[pg[@"startTime"] intValue]
                                             endTime:[pg[@"endTime"] intValue]
                                           imageName:pg[@"imageName"]];
            
            
            page.contentMode = UIViewContentModeScaleToFill;
            page.userInteractionEnabled = YES;
            
            UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeft:)];
            swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
            
            UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRight:)];
            
            swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
            
            [page addGestureRecognizer:swipeRight];
            [page addGestureRecognizer:swipeLeft];
            
            [_photoArray addObject:page];
            NSLog(@"%d",[_photoArray count]);
            
        }
        
        _currentPageIndex = 0;
        _transparentView = [[UIView alloc] initWithFrame:self.frame];
        [self addSubview:_transparentView];
        [_transparentView addSubview: _photoArray[_currentPageIndex]];
        
        _pageLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 480, self.bounds.size.width, 30)];
        _pageLabel.text = [self pageText: _currentPageIndex];
        _pageLabel.textAlignment = NSTextAlignmentCenter;
        _pageLabel.backgroundColor = [[UIColor alloc] initWithRed:0.1 green:0.1 blue:0.1 alpha:0.5];
        _pageLabel.textColor = [UIColor whiteColor];
        [_photoArray[_currentPageIndex] addSubview:_pageLabel];
        
        
        NSString *pathMp3 = [[NSBundle mainBundle] pathForResource:@"ChuCuoiCungTrang" ofType:@"mp3" inDirectory:nil];
        NSURL *audioURL = [NSURL fileURLWithPath:pathMp3];
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audioURL error:nil];
        _audioPlayer.numberOfLoops = -1;
        _curentEnd = ((Page*)_photoArray[_currentPageIndex]).endTime;
        [self playAtTime:0];
        //audioPlayer.

        
    }
    return self;
}

- (void) checkDuration{
    if (_audioPlayer.currentTime > _curentEnd) {
        [_audioPlayer stop];
        if (_currentPageIndex <_numPage) {
            [self curlUpPage];
        }

    }
}

- (void) playAtTime: (float) time{
    if([_audioPlayer isPlaying])
        [_audioPlayer stop];
    _audioPlayer.currentTime = time;
    [_audioPlayer play];
}

- (NSString *) pageText: (NSInteger) pageIndex
{
    return [NSString stringWithFormat:@"%d - %d", pageIndex, _numPage];
}

- (void) curlUpPage{
    //Curl Up - page next
    if (_currentPageIndex == _numPage) return;
    
    [UIView transitionWithView:_transparentView duration:1 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        UILabel *backupLabel = _pageLabel;
        [_pageLabel removeFromSuperview];
        backupLabel.text = [self pageText: _currentPageIndex + 1];
        [_photoArray[_currentPageIndex + 1] addSubview:backupLabel];
        [_transparentView addSubview: _photoArray[_currentPageIndex + 1]];
        _curentEnd = ((Page*)_photoArray[_currentPageIndex+1]).endTime;
        
        [_photoArray[_currentPageIndex] removeFromSuperview];
    } completion:^(BOOL finished){
        _currentPageIndex = _currentPageIndex + 1;

        [self playAtTime:((Page*)_photoArray[_currentPageIndex]).startTime];
        //[_transparentView bringSubviewToFront:_pageLabel];
    }];
}

- (void) handleSwipeLeft: (UISwipeGestureRecognizer *)gesture
{
   [self curlUpPage];
}

- (void) handleSwipeRight: (UISwipeGestureRecognizer *)gesture
{
    //Curl Down - page previous
    if (_currentPageIndex == 0) return;
    
    [UIView transitionWithView:_transparentView duration:1 options:UIViewAnimationOptionTransitionCurlDown animations:^{
        UILabel *backupLabel = _pageLabel;
        [_pageLabel removeFromSuperview];
        backupLabel.text = [self pageText: _currentPageIndex - 1];
        [_photoArray[_currentPageIndex - 1] addSubview:backupLabel];
        
        
        [_transparentView addSubview: _photoArray[_currentPageIndex - 1]];
        [_photoArray[_currentPageIndex] removeFromSuperview];
        _curentEnd = ((Page*)_photoArray[_currentPageIndex+1]).endTime;
    } completion:^(BOOL finished){
        _currentPageIndex = _currentPageIndex - 1;

        [self playAtTime:((Page*)_photoArray[_currentPageIndex]).startTime];
        //[_transparentView bringSubviewToFront:_pageLabel];
    }];
}



@end
