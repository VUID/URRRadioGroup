//
//  URRViewController.m
//  URRRadioGroupExample
//
//  Created by Kenta Nakai on 2014/03/17.
//  Copyright (c) 2014年 Kenta Nakai. All rights reserved.
//

#import "URRViewController.h"
#import "URRRadioGroup.h"

@interface URRViewController ()

@property(nonatomic,strong) URRRadioGroup *textGroup;
@property(nonatomic,strong) URRRadioGroup *imageGroup;
@property(nonatomic,strong) URRRadioGroup *staticImageGroup;

@end

@implementation URRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.textGroup = [URRRadioGroup new];
    [self.textGroup addButton:self.radio1 defaultText:@"1 / non-selected" selectedText:@"1 / selected"];
    [self.textGroup addButton:self.radio2 defaultText:@"2 / non-selected" selectedText:@"2 / selected"];
    [self.textGroup addButton:self.radio3 defaultText:@"3 / non-selected" selectedText:@"3 / selected"];
    [self.textGroup selectButton:self.radio1];
    
    self.imageGroup = [URRRadioGroup new];
    [self.imageGroup addButton:self.radio4 defaultImage:[UIImage imageNamed:@"check_off"] selectedImage:[UIImage imageNamed:@"check_on"]];
    [self.imageGroup addButton:self.radio5 defaultImage:[UIImage imageNamed:@"check_off"] selectedImage:[UIImage imageNamed:@"check_on"]];
    [self.imageGroup addButton:self.radio6 defaultImage:[UIImage imageNamed:@"check_off"] selectedImage:[UIImage imageNamed:@"check_on"]];
    [self.imageGroup selectButton:self.radio4];
	
	self.staticImageGroup = [URRRadioGroup new];
	[self.staticImageGroup addStaticButton:self.radio7 defaultImage:[UIImage imageNamed:@"check_off"] selectedImage:[UIImage imageNamed:@"check_on"]];
    [self.staticImageGroup addButton:self.radio8 defaultImage:[UIImage imageNamed:@"check_off_red"] selectedImage:[UIImage imageNamed:@"check_on_red"]];
    [self.staticImageGroup addButton:self.radio9 defaultImage:[UIImage imageNamed:@"check_off_blue"] selectedImage:[UIImage imageNamed:@"check_on_blue"]];
    //[self.staticImageGroup selectButton:self.radio7];
	
}

@end
