//
//  URRRadioGroup.m
//  URRRadioGroupExample
//
//  Created by Kenta Nakai on 2014/03/17.
//  Copyright (c) 2014年 Kenta Nakai. All rights reserved.
//

#import "URRRadioGroup.h"

@interface URRRadio : NSObject
@property(nonatomic,strong) UIButton *control;
@property(nonatomic,strong) NSString *defaultText;
@property(nonatomic,strong) NSString *selectedText;
@property(nonatomic,strong) UIImage *defaultImage;
@property(nonatomic,strong) UIImage *selectedImage;

- (void)selected;
- (void)deselected;
@end

@implementation URRRadio

- (void)selected {
	if(self.selectedImage){
		[self.control setImage:self.selectedImage forState:UIControlStateNormal];
		[self.control setImage:self.selectedImage forState:UIControlStateHighlighted];
		[self.control setImage:self.selectedImage forState:UIControlStateSelected];
	}else{
		[self.control setTitle:self.selectedText forState:UIControlStateNormal];
	}
}

- (void)deselected {
	if(self.defaultImage){
		[self.control setImage:self.defaultImage forState:UIControlStateNormal];
		[self.control setImage:self.defaultImage forState:UIControlStateHighlighted];
		[self.control setImage:self.defaultImage forState:UIControlStateSelected];
	}else{
		[self.control setTitle:self.defaultText forState:UIControlStateNormal];
	}
}

@end


@interface URRRadioGroup()
{
    NSMutableArray *_buttons;
	NSInteger staticIndex;
}

@end

@implementation URRRadioGroup

- (id)init
{
    self = [super init];
    if(!self){
        return nil;
    }
    
    _buttons = [[NSMutableArray alloc] initWithCapacity:0];
    staticIndex = -1;
	
    return self;
}

- (void)dealloc
{
    [_buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if([obj isKindOfClass:[URRRadio class]]){
            UIButton *button = [(URRRadio *)obj control];
            for(UIGestureRecognizer *recognizer in [button gestureRecognizers]){
                [button removeGestureRecognizer:recognizer];
            }
        }
    }];
    
    [_buttons removeAllObjects];
}

- (void)addButton:(UIButton *)button defaultText:(NSString *)defaultText selectedText:(NSString *)selectedText
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [button addGestureRecognizer:tap];
    
    URRRadio *radio = [URRRadio new];
    radio.control = button;
    radio.defaultText = defaultText;
    radio.selectedText = selectedText;
    
    [_buttons addObject:radio];
}

- (void)addButton:(UIButton *)button defaultImage:(UIImage *)defaultImage selectedImage:(UIImage *)selectedImage
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [button addGestureRecognizer:tap];
    
    URRRadio *radio = [URRRadio new];
    radio.control = button;
    radio.defaultImage = defaultImage;
    radio.selectedImage = selectedImage;
    
    [_buttons addObject:radio];
}

- (void)addStaticButton:(UIButton *)button defaultText:(NSString *)defaultText selectedText:(NSString *)selectedText {
	[self addButton:button defaultText:defaultText selectedText:selectedText];
	if (staticIndex == -1) {
		staticIndex = [_buttons count]-1;
		[(URRRadio *)[_buttons objectAtIndex:staticIndex] selected];
	}
}

- (void)addStaticButton:(UIButton *)button defaultImage:(UIImage *)defaultImage selectedImage:(UIImage *)selectedImage
{
	[self addButton:button defaultImage:defaultImage selectedImage:selectedImage];
	if (staticIndex == -1) {
		staticIndex = [_buttons count]-1;
		[(URRRadio *)[_buttons objectAtIndex:staticIndex] selected];
	}
}

- (void)tap:(UITapGestureRecognizer *)recognizer
{
    __weak UIButton *button = (UIButton *)recognizer.view;
    
    [self selectButton:button];
}

- (void)selectButton:(UIButton *)button
{
    [_buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        URRRadio *radio = (URRRadio *)obj;
        if(button == radio.control){
			if (staticIndex>=0) {
				[self swapRadioButtons:idx];
			}
			[radio selected];
        }else{
			[radio deselected];
        }
    }];
}

- (void)swapRadioButtons:(NSUInteger)index {
	if (staticIndex == index) return;
	URRRadio *staticButton = (URRRadio *)[_buttons objectAtIndex:staticIndex];
	URRRadio *selectedButton = (URRRadio *)[_buttons objectAtIndex:index];
	
	[staticButton deselected];
	
	CGRect frame = [[staticButton control] frame];
	[[staticButton control] setFrame:[[selectedButton control] frame]];
	[[selectedButton control] setFrame:frame];
	
	NSMutableIndexSet *indicies = [[NSMutableIndexSet alloc] init];
	[indicies addIndex:staticIndex];
	[indicies addIndex:index];
	
	[_buttons removeObjectsAtIndexes:indicies];
	[_buttons insertObjects:@[selectedButton, staticButton] atIndexes:indicies];
}


@end
