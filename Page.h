//
//  Page.h
//  CoGiaoEmTieuThuyet
//
//  Created by KIENND on 4/25/13.
//  Copyright (c) 2013 TechMaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Page : UIImageView

@property (assign) float startTime;
@property (assign) float endTime;
@property (strong) UIImage *imagePage;
- (id)initWithFrame:(CGRect)frame
          startTime: (float) startTime
          endTime: (float) endTime
          imageName: (NSString*) imageName;
@end
