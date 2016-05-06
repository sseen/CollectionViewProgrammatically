//
//  CustomCollectionViewCell.m
//  CollectionViewProgrammatically
//
//  Created by sseen on 16/5/6.
//  Copyright © 2016年 ssn. All rights reserved.
//

#import "CustomCollectionViewCell.h"

CGFloat width = 30;

@implementation CustomCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"%f, %f\n", self.center.x, self.center.y);
        self.lblTitle = [[UILabel alloc] init];
        self.lblTitle.frame = CGRectMake(width, width, width, width);
        [self addSubview:self.lblTitle];
        
    }
    return self;
}

@end
