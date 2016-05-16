//
//  ViewController.m
//  CollectionViewProgrammatically
//
//  Created by zyang on 16/4/14.
//  Copyright © 2016年 ssn. All rights reserved.
//

#import "ViewController.h"
#import "CustomCollectionViewCell.h"
#import "CustomCollectionReusableView.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign) CGPoint offSet;
@property (nonatomic, strong) UIView *sourceDraggableView;
@property (nonatomic, strong) UIView *overDroppableView;
@property (nonatomic, strong) UIView *representationImageView;

@property (nonatomic, strong) NSIndexPath* draggingPathOfCellBeingDragged ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    // header size
    layout.headerReferenceSize = CGSizeMake(self.collectionView.frame.size.width, 40.f);
    _collectionView=[[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    
    [_collectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [_collectionView registerClass:[CustomCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"supplementCell"];
    [_collectionView setBackgroundColor:[UIColor colorWithRed:0.18 green:0.24 blue:0.31 alpha:1.00]];
    
    [self.view addSubview:_collectionView];
    
    UILongPressGestureRecognizer *rec = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(updateForLongPress:)];
    rec.delegate = self;
    rec.minimumPressDuration = 0.3;
    [self.collectionView addGestureRecognizer:rec];
}
#pragma mark - other
- (BOOL)canDragAtPoint:(CGPoint)touchPoint {
    return [_collectionView indexPathForItemAtPoint:touchPoint] != nil;
}

- (UIImageView *)representationImageAtPoint:(CGPoint)touchPoint {
    UIImageView *imageView ;
    NSIndexPath *index = [_collectionView indexPathForItemAtPoint:touchPoint];
    UICollectionViewCell *cell = [_collectionView cellForItemAtIndexPath:index];
    if (cell) {
        UIGraphicsBeginImageContextWithOptions(cell.bounds.size, cell.opaque, 0);
        [cell.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        imageView = [[UIImageView alloc] init];
        imageView.image = image;
        imageView.frame = cell.frame;
    }
    
    return imageView;
}

- (BOOL)canDropAtRect:(CGRect)touchRect {
    return [self indexPathForCellOverlappingRect:touchRect] != nil;
}

- (NSIndexPath *)indexPathForCellOverlappingRect:( CGRect)rect {
    
    CGFloat  overlappingArea = 0.0;
    UICollectionViewCell * cellCandidate ;
    
    NSArray *visibleCells = [_collectionView visibleCells];
    
    if (visibleCells.count == 0) {
        return [NSIndexPath indexPathForRow:0 inSection:0];
    }
    
    if  (rect.origin.y > self.collectionView.contentSize.height) {
            
        return [NSIndexPath indexPathForRow:visibleCells.count - 1 inSection:0 ];
    }
    
    for ( CustomCollectionViewCell* visible in visibleCells ) {
        
        CGRect intersection = CGRectIntersection(visible.frame, rect);
        // 这个时候 overlappingArea 有用了，只有覆盖面最大的保留
        if ( (intersection.size.width * intersection.size.height) > overlappingArea ){
            
            overlappingArea = intersection.size.width * intersection.size.width;
            
            cellCandidate = visible;
            NSLog(@"cellCandidate %@", visible);
        }
        
    }
    
    if (cellCandidate) {
        
        return [_collectionView indexPathForCell:cellCandidate];
    }
    
    return nil;
}

- (void) didMoveItem:(NSObject *)item inRect: (CGRect)rect  {
    NSIndexPath *touchIndex = [self indexPathForCellOverlappingRect:rect ];
    if  ( touchIndex ) {
            
            if (touchIndex != _draggingPathOfCellBeingDragged) {
                NSLog(@"move %@, %@", touchIndex, _draggingPathOfCellBeingDragged);
                _draggingPathOfCellBeingDragged = touchIndex;
                [UIView animateWithDuration:5.0 delay:0.0 options:0 animations:^{
                    [_collectionView performBatchUpdates:^{
                        [_collectionView moveItemAtIndexPath:_draggingPathOfCellBeingDragged toIndexPath: touchIndex];
                        
                    } completion:^(BOOL finished) {
                        
                        //[_collectionView reloadData];
                    }];
                } completion:^(BOOL finished) {
//                    [_collectionView reloadData];
                }];
                
                
            }
        }
    
}



#pragma mark - gesture
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    CGPoint touchPointInCollection = [touch locationInView:_collectionView];
    if ([self canDragAtPoint:touchPointInCollection]) {
        UIImageView *imgView = [self representationImageAtPoint:touchPointInCollection];
        if (imgView) {
            imgView.alpha = 0.7;
            imgView.frame = [self.view convertRect:imgView.frame fromView:_collectionView];
            CGPoint pointOnCanvas = [touch locationInView:self.view];
            self.offSet = CGPointMake(pointOnCanvas.x - imgView.frame.origin.x, pointOnCanvas.y - imgView.frame.origin.y);
            self.sourceDraggableView = _collectionView;
            self.overDroppableView = _collectionView;
            self.representationImageView = imgView;
            
            return true;
        }
    }
    return NO;
}

- (void)updateForLongPress:(UILongPressGestureRecognizer *)rec {
    if (_representationImageView) {
        CGPoint pointOnCanvas = [rec locationInView:rec.view];
        CGPoint pointOnSourceDraggable = [rec locationInView:_sourceDraggableView];
        
        switch (rec.state) {
            case UIGestureRecognizerStateBegan: {
                [self.view addSubview:_representationImageView];
                self.draggingPathOfCellBeingDragged = [_collectionView indexPathForItemAtPoint:pointOnSourceDraggable];
                [_collectionView reloadData];
                
                break;
            }
            case UIGestureRecognizerStateChanged: {
                // 图片移动
                CGRect repImgFrame = _representationImageView.frame;
                // NSLog(@"%@, %@, %@", NSStringFromCGRect(_representationImageView.frame), NSStringFromCGPoint(pointOnCanvas),NSStringFromCGPoint(_offSet));
                repImgFrame.origin = CGPointMake(pointOnCanvas.x - _offSet.x, pointOnCanvas.y - _offSet.y + 64);// uicollectionview 全屏
                _representationImageView.frame = repImgFrame;
                
                // 是否需要交换
                CGRect rect = [self.view convertRect:repImgFrame toView: _collectionView];
                if ( [ self canDropAtRect:rect ]) {
                    
                    [self didMoveItem:nil  inRect: rect];
                    
                }
                
                break;
            }
            case UIGestureRecognizerStateEnded: {
                _draggingPathOfCellBeingDragged = nil;
                [_representationImageView removeFromSuperview];
                [self.collectionView reloadData];
                break;
            }
            default:
                break;
        } // end switch
        
    }
    
}

#pragma mark - data

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    CustomCollectionReusableView *reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"supplementCell" forIndexPath:indexPath];

    if (kind == UICollectionElementKindSectionHeader) {
        reusableview.lblTitle.text = @"hello";
    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        reusableview.lblTitle.text = @"world";
    }
    
    return reusableview;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCollectionViewCell  *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        cell.backgroundColor = [UIColor colorWithRed:0.23 green:0.60 blue:0.85 alpha:1.00];
    } else {
        cell.backgroundColor = [UIColor colorWithRed:0.19 green:0.68 blue:0.39 alpha:1.00];
    }
    cell.lblTitle.text = [NSString stringWithFormat:@"%d, %d", (int)indexPath.section , (int)indexPath.row];
    
    if (_draggingPathOfCellBeingDragged &&
        _draggingPathOfCellBeingDragged.item == indexPath.item) {
        
        cell.hidden = YES;
    } else {
        cell.hidden = NO;
    }
    
    return cell;
}

#pragma mark - flow 

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float width = [self itemWidth];
    return CGSizeMake(width, width);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return [self itemSpacing];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return [self itemSpacing];
}

// Layout: Set Edges
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0,0,0,0);  // top, left, bottom, right
    // return UIEdgeInsetsMake(0,8,0,8);
}

- (float)itemSpacing {
    int cellsInLine = 3;
    float width = [self itemWidth];
    float spacing = ((CGRectGetWidth(self.view.frame) - cellsInLine * width) / (cellsInLine -1));
    
    return spacing;
}

- (float)itemWidth {
    int cellsInLine = 3;
    float width = roundf(( CGRectGetWidth(self.view.frame) - cellsInLine + 1) / 3);
    return width;
}

@end

