//
//  ZQCollectionCell.h
//  ZQJiemian
//
//  Created by czq on 15/12/14.
//  Copyright (c) 2015年 陈樟权. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZQCollectionCell : UICollectionViewCell

@property(nonatomic,copy)void(^imageClick)(NSInteger page);


@property(nonatomic,copy)NSString *picUrl;

@property(nonatomic,assign)NSInteger page;


@end
