//
//  ViewController.m
//  轮播demo
//
//  Created by wsd on 16/3/4.
//  Copyright © 2016年 wsd. All rights reserved.
//

#import "ViewController.h"
#import "ZQCollectionCell.h"
#define collectionViewSections 50
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,weak)UICollectionView *collectionView;
@property(nonatomic,weak)UIPageControl *pageControl;
@property(nonatomic,strong)NSArray *pics;
@property(nonatomic,strong)NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pics = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg"];
    [self setupCollectionView];
    [self addTimer];

}

//初始化
-(void)setupCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    CGRect collectionFrame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 2);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:collectionFrame collectionViewLayout:flowLayout];
    
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.itemSize = collectionView.bounds.size;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor yellowColor];
    collectionView.showsHorizontalScrollIndicator = YES;
    collectionView.pagingEnabled = YES;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    [collectionView registerClass:[ZQCollectionCell class] forCellWithReuseIdentifier:@"collectionCell"];
    
    [collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:collectionViewSections / 2] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
//    pageControl.backgroundColor = [UIColor redColor];
    pageControl.frame = CGRectMake(0, self.view.frame.size.height / 2 - 50, self.view.frame.size.width, 50);
    pageControl.numberOfPages = self.pics.count;
    pageControl.currentPage = 0;
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;

}

//返回组数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)cZollectionView{
    return collectionViewSections;
}

//返回每组的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.pics.count;
}

//配置cell
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZQCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    
    cell.picUrl = self.pics[indexPath.row];
    
    return cell;
}

//下一页
-(void)nextPage{
    NSIndexPath *currentIndexPath = [self.collectionView indexPathsForVisibleItems].lastObject;
    
    NSIndexPath *currentRstIndexPath = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:collectionViewSections / 2];
    
    [self.collectionView scrollToItemAtIndexPath:currentRstIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    NSInteger nextIndextPathItem = currentRstIndexPath.item + 1;
    NSInteger nextIndextPathSection = currentRstIndexPath.section;
    if (nextIndextPathItem == self.pageControl.numberOfPages) {
        nextIndextPathItem = 0;
        nextIndextPathSection ++;
    }
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:nextIndextPathItem inSection:nextIndextPathSection] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

//自己用手滚的时候停止定时器
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];

}

//无论怎么滚 都要设置pageController
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([scrollView isKindOfClass:[UICollectionView class]]) {
        NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width + 0.5;
        if (self.pageControl) {
            page = page % self.pageControl.numberOfPages;
            self.pageControl.currentPage = page;
            
        }
    }
}

//滚动结束后把定时器开起来
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if ([scrollView isKindOfClass:[UICollectionView class]]) {
        [self addTimer];
    }
}


-(void)addTimer{
    if (self.timer == nil) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

-(void)removeTimer{
    [self.timer invalidate];
    self.timer = nil;
}

-(void)dealloc{
    [self removeTimer];
    NSLog(@"dealloc");
}

@end
