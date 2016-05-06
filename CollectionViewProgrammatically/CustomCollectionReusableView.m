//
//  CustomCollectionReusableView.m
//  CollectionViewProgrammatically
//
//  Created by sseen on 16/5/6.
//  Copyright © 2016年 ssn. All rights reserved.
//

#import "CustomCollectionReusableView.h"

@implementation CustomCollectionReusableView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat height = 20;
        CGFloat width  = 50;
        self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        
        [self addSubview:_lblTitle];
    }
    return self;
}
@end
