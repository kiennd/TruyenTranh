//
//  Page.m
//  CoGiaoEmTieuThuyet
//
//  Created by KIENND on 4/25/13.
//  Copyright (c) 2013 TechMaster. All rights reserved.
//

#import "Page.h"

@implementation Page

- (id)initWithFrame:(CGRect)frame
          startTime: (float) startTime
          endTime: (float) endTime
          imageName: (NSString*) imageName
{
    self = [super initWithFrame:frame];
    if (self) {
        _startTime = startTime;
        _endTime = endTime;
        _imagePage = [UIImage imageNamed:imageName];
        self.image = _imagePage;
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
