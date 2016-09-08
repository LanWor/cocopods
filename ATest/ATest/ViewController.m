//
//  ViewController.m
//  ATest
//
//  Created by 王泉 on 15/12/23.
//  Copyright © 2015年 lanou. All rights reserved.
//

#import "ViewController.h"
#import "BannerScrollView.h"
#import "LTViewCell.h"
#import "HeaderReusableView.h"
#import "AFHTTPSessionManager.h"
#import "LTlistModel.h"
#import "LTDetailCollectionViewController.h"
#import "LTPlayerController.h"
#import "LTdalistTableViewController.h"
#define Kwidht self.view.frame.size.width
#define Kheight self.view.frame.size.height

@interface ViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,retain) NSMutableArray *dataSource;
@property (nonatomic,retain) NSMutableArray *dataBannerSource;
@property (nonatomic,retain) NSMutableArray *dataHeaderSource;
@property (nonatomic,retain) UICollectionView *collection;

@end

@implementation ViewController

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}

- (NSMutableArray *)dataBannerSource {
    if (!_dataBannerSource) {
        self.dataBannerSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataBannerSource;
}

- (NSMutableArray *)dataHeaderSource {

    if (!_dataHeaderSource) {
        self.dataHeaderSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataHeaderSource;

}



- (void)loadView {
    [super loadView];
    [self requesDataFromNet];
}

- (void)requesDataFromNet {
    NSURLSessionConfiguration *configure = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configure];
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:LTMainListURL]];
    
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [self readData:responseObject];
        [self setUpViews];
    }];
    [task resume];
}

- (void)readData:(NSDictionary *)dic {
    NSDictionary *dict = [dic valueForKey:@"data"];
    NSArray *arr = [dict valueForKey:@"focus_list"];
    NSArray *cateArr = [dict valueForKey:@"category_list"];
   for (NSDictionary *diccc in arr) {
       [self.dataBannerSource addObject:[diccc valueForKey:@"image_url"]];
       
           }
   
    for (NSDictionary *listDic in cateArr) {
        NSDictionary *category = [listDic valueForKey:@"category"];
        [self.dataHeaderSource addObject:category];
        NSArray *listArr = [listDic valueForKey:@"list"];
        [self.dataSource addObject:listArr];
    }
    [self.dataHeaderSource insertObject:@"firstheader" atIndex:0];
    [self.dataSource insertObject:@"focus" atIndex:0];
    [_collection reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"聆听世界";
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationController.navigationBar.titleTextAttributes = dic;
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor yellowColor];
}

- (void)setUpViews{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //3.)设置最小行间距
    layout.minimumLineSpacing = 10;
    //4.)设置最小的item的间距
    layout.minimumInteritemSpacing = 10;

    self.collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    _collection.backgroundColor = [UIColor whiteColor];
    _collection.delegate = self;
    _collection.dataSource = self;
    _collection.showsVerticalScrollIndicator = NO;
    _collection.multipleTouchEnabled = NO;
    [self.view addSubview:_collection];
    [_collection release];
    [layout release];
    

    [_collection registerClass:[LTViewCell class] forCellWithReuseIdentifier:@"ltcell"];
    [_collection registerClass:[HeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [_collection registerClass:[BannerScrollView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"banner"];

    
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSource.count ;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0 || section == 4 || section == 6) {
        return 0;
    }
    return  [self.dataSource[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LTViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ltcell" forIndexPath:indexPath];
        NSDictionary *dic = self.dataSource[indexPath.section][indexPath.row];
    LTlistModel *model = [[LTlistModel alloc]init];
    [model setValuesForKeysWithDictionary:dic];
        cell.listModel = model;
    
    return cell;
}

//设置分区缩进量
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return UIEdgeInsetsZero;
    }
    
    return UIEdgeInsetsMake(10, 20, 10, 20);
}

//返回页眉/补充View
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        BannerScrollView *baner =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"banner" forIndexPath:indexPath];
        baner.backgroundColor = [UIColor redColor];
        baner.databannerarr = self.dataBannerSource;
        return baner;
    } else {
        HeaderReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        
        headerView.backgroundColor = [UIColor whiteColor];
        headerView.titleLabel.text = [self.dataHeaderSource[indexPath.section] valueForKey:@"title"];
        headerView.ID = [self.dataHeaderSource[indexPath.section] valueForKey:@"id"];
        headerView.title = [self.dataHeaderSource[indexPath.section] valueForKey:@"title"];
        [headerView headerModelidWithBlock:^(NSString *modelID,NSString *title) {
            
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
            layout.itemSize = CGSizeMake(110, 130);
            layout.minimumLineSpacing = 10;
            layout.minimumInteritemSpacing = 10;
            LTDetailCollectionViewController *ltdetail = [[LTDetailCollectionViewController alloc]initWithCollectionViewLayout:layout];
            [self.navigationController pushViewController:ltdetail animated:YES];
            ltdetail.ID = [modelID integerValue];
            ltdetail.titlle = title;
            [ltdetail release];
            
        }];
        
        return headerView;
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    LTdalistTableViewController *dalist = [[LTdalistTableViewController alloc]init];
    NSString *albumid = self.dataSource[indexPath.section][indexPath.row][@"album_id"];
    dalist.ID = [albumid integerValue];
    
    [self.navigationController pushViewController:dalist animated:YES];
    [dalist release];

}




//设置分区页眉大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(0, 200);
    } else if (section == 4 || section == 6) {
        return CGSizeZero;
    }
    return  CGSizeMake(0, 40);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
        return CGSizeMake(110, 150);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
