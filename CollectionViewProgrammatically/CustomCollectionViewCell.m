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
        
        UIButton *bt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        [bt setTitle:@"关闭" forState:UIControlStateNormal];
        [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [bt addTarget:self action:@selector(tapClose:) forControlEvents:UIControlEventTouchUpInside];
        
        self.lblTitle = [[UILabel alloc] init];
        self.lblTitle.frame = CGRectMake(width, width, width, width);
        
        [self addSubview:self.lblTitle];
        [self addSubview:bt];
        
    }
    return self;
}

- (void)tapClose:(UIButton *)sender {
    _block(_indexPath);
}

@end



