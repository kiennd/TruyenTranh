//
//  ViewController.m
//  TruyenTranh
//
//  Created by KIENND on 4/25/13.
//  Copyright (c) 2013 KIENND. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    Truyen* tr =  [[Truyen alloc] initWithName:@"ChuCuoiCungTrang" Frame:self.view.bounds];
    [self.view addSubview:tr];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
