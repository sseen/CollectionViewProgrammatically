//
//  CustomCollectionViewCell.h
//  CollectionViewProgrammatically
//
//  Created by sseen on 16/5/6.
//  Copyright © 2016年 ssn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^tapCloseDoneBlock)(NSIndexPath *);

@interface CustomCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) tapCloseDoneBlock block;

@end
