//
//  LTDetailCollectionViewController.m
//  ATest
//
//  Created by 王泉 on 15/12/25.
//  Copyright © 2015年 lanou. All rights reserved.
//

#import "LTDetailCollectionViewController.h"
#import "LTPlayerController.h"
#import "LTdalistTableViewController.h"
#import "AFHTTPSessionManager.h"
#import "LTDetail.h"
#import "LTDetailCell.h"
#define  keyURL @"http://a2m.duotin.com/recommend/more"
@interface LTDetailCollectionViewController ()<UICollectionViewDelegateFlowLayout>

@property (nonatomic,retain) NSMutableArray *dataSource;

@end

@implementation LTDetailCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)dealloc {
    self.titlle = nil;
    [super dealloc];
}


- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.titlle;
    [self.collectionView registerClass:[LTDetailCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self readFromNet];
}

- (void)readFromNet {
    
    NSURLSessionConfiguration *configure = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:configure];
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://a2m.duotin.com/recommend/more?mobile_key=00000000-Ojl8rEY14WmLNiq8mKRNso&user_key=&category_id=%ld&last_data_order=0",(long)self.ID]]];
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [self readData:responseObject];
    }];
//    http://a2m.duotin.com/recommend/more?mobile_key=00000000-Ojl8rEY14WmLNiq8mKRNso&user_key=&category_id=1&last_data_order=0
    
    [task resume];
    
}


- (void)readData:(NSDictionary *)dic {
    NSArray *listArr = [[dic valueForKey:@"data"] valueForKey:@"list"];
    for (NSDictionary *listDic in listArr) {
        LTDetail *detail = [[LTDetail alloc]init];
        [detail setValuesForKeysWithDictionary:listDic];
        [self.dataSource addObject:detail];
        [detail release];
    }
    [self.collectionView reloadData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LTDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    LTDetail *detail = self.dataSource[indexPath.row];
    cell.detail = detail;
    
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LTDetail *detail = self.dataSource[indexPath.row];
        LTdalistTableViewController *dalist = [[LTdalistTableViewController alloc]init];
        [self.navigationController pushViewController:dalist animated:YES];
    dalist.ID = [detail.album_id integerValue];
    dalist.titleName = detail.title;
//    dalist.flag = self.section;
        [dalist release];
   
    
    
}




#pragma - uicollectionViewFlowLayout -

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(20, 40, 20, 40);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(150, 170);
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
