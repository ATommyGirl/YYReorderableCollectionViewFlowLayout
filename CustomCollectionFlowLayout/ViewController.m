//
//  ViewController.m
//  CustomCollectionFlowLayout
//
//  Created by xiaotian on 2018/3/28.
//  Copyright © 2018年 YYLittleCat. All rights reserved.
//

#import "ViewController.h"
#import "YTReorderableCollectionViewFlowLayout.h"
#import "APPCell.h"

@interface ViewController () {
    NSMutableArray *_apps;
    BOOL _edit;
}

@end

@implementation ViewController

- (instancetype)init {
    YTReorderableCollectionViewFlowLayout *layout = [[YTReorderableCollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self = [super initWithCollectionViewLayout:layout];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    _apps = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Apps" ofType:@"plist"]];

    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"APPCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
}

#pragma mark - collectionview delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [_apps[section] count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return _apps.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(80, 80);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    APPCell *cell;
    NSDictionary *dic = _apps[indexPath.section][indexPath.row];

    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.icon.image = [UIImage imageNamed:dic[@"i"]];
    cell.name.text = dic[@"n"];

    return cell;
}

#pragma mark - YTReorderableCollectionView delegate
- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath willMoveToIndexPath:(NSIndexPath *)toIndexPath {
    NSDictionary *app = _apps[fromIndexPath.section][fromIndexPath.row];

    [_apps[fromIndexPath.section] removeObject:app];
    [_apps[toIndexPath.section] insertObject:app atIndex:toIndexPath.row];
}

-  (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        return NO;
    }

    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath canMoveToIndexPath:(NSIndexPath *)toIndexPath {

    if (toIndexPath.section == 2) {
        return NO;
    }

    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout willBeginDraggingItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"will begin drag");
}

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didBeginDraggingItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"did begin drag");
    [collectionView reloadData];
}

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout willEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"will end drag");
}

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"did end drag");
    [collectionView reloadData];
}


@end
