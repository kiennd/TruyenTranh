//
//  Truyen.h
//  CoGiaoEmTieuThuyet
//
//  Created by KIENND on 4/25/13.
//  Copyright (c) 2013 TechMaster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "Page.h"
@interface Truyen : UIView<AVAudioPlayerDelegate>
@property (strong) NSMutableArray * photoArray;
@property (assign) int currentPageIndex,numPage,curentEnd;
@property (strong) UIView * transparentView;
@property (strong) UILabel * pageLabel;
@property (strong) AVAudioPlayer *audioPlayer;
@property (strong) NSMutableArray* arrPage;
@property (strong) NSTimer* timer;

- (id) initWithName:(NSString*) name
              Frame:(CGRect)frame;
@end
