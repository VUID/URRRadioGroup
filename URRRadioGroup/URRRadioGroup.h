//
//  URRRadioGroup.h
//  URRRadioGroupExample
//
//  Created by Kenta Nakai on 2014/03/17.
//  Copyright (c) 2014年 Kenta Nakai. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol URRRadioGroupDelegate;

@interface URRRadioGroup : NSObject

@property (weak, nonatomic) UIButton *selectedButton;
@property (readonly, nonatomic) NSArray *buttons;
@property (assign, nonatomic) id<URRRadioGroupDelegate> delegate;

- (void)addButton:(UIButton *)button defaultText:(NSString *)defaultText selectedText:(NSString *)selectedText;
- (void)addButton:(UIButton *)button defaultImage:(UIImage *)defaultImage selectedImage:(UIImage *)selectedImage;
- (void)selectButton:(UIButton *)button;

@end

@protocol URRRadioGroupDelegate <NSObject>

@optional
- (void)radioGroup:(URRRadioGroup *)radioGroup didSelectButton:(id)button;

@end
