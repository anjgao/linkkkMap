//
//  PlaceListVC.m
//  linkkkMap
//
//  Created by andregao on 13-3-25.
//  Copyright (c) 2013年 linkkk.com. All rights reserved.
//

#import "PlaceListVC.h"
#import "ASIHTTPRequest.h"

@interface PlaceListVC () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation PlaceListVC
{
    UITableView * _table;
    UIActivityIndicatorView * _footer;
    
    NSMutableArray * _data;
    
    ASIHTTPRequest * _listRequest;
    
    BOOL _bRefreshRequest;
    BOOL _bLoadFinish;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addTable];
    
//    [self requestData:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITable
-(void)addTable
{
    _table = [[UITableView alloc] initWithFrame:self.view.bounds];
    _table.dataSource = self;
    _table.delegate = self;
    _table.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
    
    _footer = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _footer.frame = CGRectMake(0, 0, _table.bounds.size.width, 30);
    _footer.hidesWhenStopped = YES;
    _table.tableFooterView = _footer;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* reuseID = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell)
        cell = [self createTableCell:reuseID];
    
    [self fillCell:cell data:[_data objectAtIndex:indexPath.row] index:indexPath forHeight:NO];
    return cell;
}

-(UITableViewCell*)createTableCell:(NSString*)reuseID
{
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    [self createCellSubviews:cell];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cellForH;
    if (!cellForH)
        cellForH = [self createTableCell:nil];
    [self fillCell:cellForH data:[_data objectAtIndex:indexPath.row] index:indexPath forHeight:YES];
    return cellForH.frame.size.height;
}

/////////////////
-(void)fillCell:(UITableViewCell*)cell data:(id)data index:(NSIndexPath *)index forHeight:(BOOL)bForHeight
{
    
}

-(void)createCellSubviews:(UITableViewCell*)cell
{
    
}

#pragma mark - request data
-(NSURL*)requestUrlPath:(BOOL)bRefresh
{
    NSNumber * start = @2147483647;     // todo news id超过该数值时
    if (_data.count > 0 && !bRefresh) {
//        Json_experience* last = (Json_experience*)[_data lastObject];
//        start = last.id;
    }
//    NSString* urlPath = [NSString stringWithFormat:@"/api/alpha/experience/search/?id__lt=%@&limit=20&&order_by=-id&user=%@",start.stringValue,_userID.stringValue];
//    return [NSURL URLWithString:[@"http://map.linkkk.com" stringByAppendingString:urlPath]];
}

-(void)requestData:(BOOL)bRefresh
{
    if (_listRequest)
        return;
        
    _listRequest = [ASIHTTPRequest requestWithURL:[self requestUrlPath:bRefresh]];
    _listRequest.delegate = self;
    _listRequest.didFinishSelector = @selector(dataLoadFinished:);
    _listRequest.didFailSelector = @selector(dataLoadFailed:);
    [_listRequest startAsynchronous];
    
    _bRefreshRequest = bRefresh;
    [_footer startAnimating];
}

- (void)dataLoadFinished:(ASIHTTPRequest *)request
{
    _listRequest = nil;
    [_footer stopAnimating];
    
    if (_bRefreshRequest) {
//        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_table];
        [_data removeAllObjects];
        _bLoadFinish = NO;
        [self loadSuccess:request bRefresh:YES];
        [_table reloadData];
    }
    else {
        uint old = _data.count;
        [self loadSuccess:request bRefresh:NO];
        uint new = _data.count;
        
        NSMutableArray * insertArr = [NSMutableArray arrayWithCapacity:20];
        for (uint i = old; i < new; i++) {
            [insertArr addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }
        [_table insertRowsAtIndexPaths:insertArr withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)dataLoadFailed:(ASIHTTPRequest *)request
{
    _listRequest = nil;
    
//    LKLog([request responseString]);
//    LKLog([[request error] localizedDescription]);
    
    [_footer stopAnimating];
    
//    [self loadFailed:request bRefresh:_bRefreshRequest];
}

/////////////////
-(void)loadSuccess:(ASIHTTPRequest *)request bRefresh:(BOOL)bRefresh
{
//    json2obj(request.responseData, PeopleStreamResponse)
//    [_data addObjectsFromArray:repObj.objects];
//    if (repObj.objects.count < 20) {
//        _bLoadFinish = YES;
//    }
}



@end
