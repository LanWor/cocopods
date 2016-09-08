//
//  LTdalistTableViewController.m
//  ATest
//
//  Created by 王泉 on 15/12/26.
//  Copyright © 2015年 lanou. All rights reserved.
//

#import "LTdalistTableViewController.h"
#import "LTPlayerController.h"
#import "AFHTTPSessionManager.h"
#import "LTdalistCell.h"
#import "dalistHeaderView.h"
#import "UIImageView+WebCache.h"
@interface LTdalistTableViewController ()

@property (nonatomic,retain) NSMutableArray *dataSource;
@property (nonatomic,retain) NSDictionary *album;

@end

@implementation LTdalistTableViewController

-(void)dealloc {
    self.titleName = nil;
    [super dealloc];
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}

- (NSDictionary *)album {

    if (!_album) {
        self.album = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _album;

}

- (void)loadView {
    [super loadView];
    [self readDataFromNet];

}

- (void)readDataFromNet {
//    http://a2m.duotin.com/album/track?mobile_key=00000000-Ojl8rEY14WmLNiq8mKRNso&user_key=&album_id=84702&last_data_order=0&sort=0&is_first=0&is_down=1
    NSURLSessionConfiguration *configure = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:configure];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://a2m.duotin.com/album/track?mobile_key=00000000-Ojl8rEY14WmLNiq8mKRNso&user_key=&album_id=%ld&last_data_order=0&sort=0&is_first=0&is_down=1",self.ID]]];
    NSURLSessionTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if ([responseObject[@"error_code"] integerValue] == 0) {
            [self readData:responseObject];
        } else  {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"error" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
    }];
    [task resume];

}

- (void)readData:(id)response {
    NSDictionary *data = [response valueForKey:@"data"];
    if (data) {
            self.album = [NSMutableDictionary dictionaryWithObject:data forKey:@"album"];
        [self header];

    } else {
        NSLog(@"没有取到");
    }
 
    NSArray *listArr = [data valueForKey:@"list"];
    for (NSDictionary *dic in listArr) {
        LTdalist *dalist = [[LTdalist alloc]initWithDic:dic];
        [self.dataSource addObject:dalist];
        [dalist release];
    }
    [self.tableView reloadData];
}

- (void)header {

    dalistHeaderView *header = [[dalistHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    [header.titleImage sd_setImageWithURL:[NSURL URLWithString:_album[@"album"][@"album"][@"image_url"] ]];
    [header.groundImage sd_setImageWithURL:[NSURL URLWithString:_album[@"album"][@"album"][@"image_url"] ]];
    header.nameLabel.text = _album[@"album"][@"album"][@"title"];
    header.trackLabel.text = [NSString stringWithFormat:@"节目:%@",_album[@"album"][@"album"][@"track_count"]];

    
    self.tableView.tableHeaderView = header;
    [header release];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"mvplayerlist"];
    self.tableView.rowHeight = 60;
    [self.tableView registerClass:[LTdalistCell class] forCellReuseIdentifier:@"ltdalist"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LTdalistCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ltdalist" forIndexPath:indexPath];
    LTdalist *dalist = self.dataSource[indexPath.row];
    cell.ltdalist = dalist;

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LTPlayerController *player = [[LTPlayerController alloc]init];
   LTdalist *dalist = self.dataSource[indexPath.row];

    player.image = _album[@"album"][@"album"][@"image_url"];
    player.musicArray = self.dataSource;
    player.currentNum = indexPath.row;
    player.navigationItem.title = dalist.title;
    player.titleName = _album[@"album"][@"album"][@"title"];
    [self.navigationController pushViewController:player animated:YES];
   
    [player release];

}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
