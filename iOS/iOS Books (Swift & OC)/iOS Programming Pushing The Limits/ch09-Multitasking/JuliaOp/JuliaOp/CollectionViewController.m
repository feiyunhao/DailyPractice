//
//  CollectionViewController.m
//  JuliaOp
//
//  Created by feiyun on 16/7/15.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import "CollectionViewController.h"
#import "JuliaCell.h"
#include <sys/sysctl.h>

@interface CollectionViewController ()
@property (nonatomic, readwrite, strong) NSOperationQueue *queue;
@property (nonatomic, readwrite, strong) NSArray *scales;
@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"JuliaCell";

unsigned int countOfCores() {
    unsigned int ncpu;
    size_t len = sizeof(ncpu);
    sysctlbyname("hw.ncpu", &ncpu, &len, NULL, 0);
    
    return ncpu;
}

- (void)useAllScales {
    CGFloat maxScale = [[UIScreen mainScreen] scale];
    NSUInteger kIterations = 6;
    CGFloat minScale = maxScale/pow(2, kIterations);
    
    NSMutableArray *scales = [NSMutableArray new];
    for (CGFloat scale = minScale; scale <= maxScale; scale *= 2) {
        [scales addObject:@(scale)];
    }
    self.scales = scales;
}

- (void)useMinimumScales {
    self.scales = [self.scales subarrayWithRange:NSMakeRange(0, 1)];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    
    // Do any additional setup after loading the view.
    
    self.queue = [[NSOperationQueue alloc] init];
    [self useAllScales];
    
    // No longer needed in iOS 7
    self.queue.maxConcurrentOperationCount = countOfCores();
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.queue cancelAllOperations];
    [self useMinimumScales];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    [self useAllScales];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JuliaCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    [cell configureWithSeed:indexPath.row queue:self.queue scales:self.scales];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
