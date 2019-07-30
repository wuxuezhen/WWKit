//
//  BDBaseCollectionViewViewController.m
//  AZURestWeidu3
//
//  Created by 吴振振 on 2017/12/12.
//  Copyright © 2017年 coreface. All rights reserved.
//

#import "BDBaseCollectionViewViewController.h"
#import "BDPageNetwork.h"
@interface BDBaseCollectionViewViewController ()
@property (nonatomic, strong) BDPageNetwork *pageNet;

@end

@implementation BDBaseCollectionViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    // Do any additional setup after loading the view.
}


#pragma mark - BDCollectionViewProtocol
-(void)bd_collectionViewDefault{
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuide);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
    }];
}

-(void)bd_collectionViewForFill{
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuide);
    }];
}


-(UICollectionViewScrollDirection)scrollDirection{
    return UICollectionViewScrollDirectionVertical;
}
-(CGFloat)minimumInteritemSpacing{
    return 0;
}
-(CGFloat)minimumLineSpacing{
    return 0;
}

#pragma mark -  BDRefreshProtocol
/**
 mj_pageRefresh
 */
-(void)mj_pageRefresh{
    [self mj_pageRefreshForHeader];
    [self mj_pageRefreshForFooter];
}

-(void)mj_pageRefreshForHeader{
    [self.collectionView bd_headerRefreshTarget:self.pageNet selecter:@selector(getFirstPage)];
}
-(void)mj_pageRefreshForFooter{
    [self.collectionView bd_footerRefreshTarget:self.pageNet selecter:@selector(getNextPage)];
}

/**
 MJRefresh
 */
- (void)mj_refresh {
    [self mj_headerRefresh];
    [self mj_footerRefresh];
}

-(void)mj_headerRefresh{
    [self.collectionView bd_headerRefreshTarget:self selecter:@selector(mj_headerRefreshAction)];
}

-(void)mj_footerRefresh{
    [self.collectionView bd_footerRefreshTarget:self selecter:@selector(mj_footerRefreshAction)];
}

-(void)mj_headerRefreshAction{
    
}
-(void)mj_footerRefreshAction{
    
}

-(void)bd_beginLoadRequest{
    [self.collectionView beginRefreshing];
}

-(void)bd_refreshData{
    [self.pageNet refreshParams:[self bd_params]];
}


#pragma mark - BDNetConfigProtocol
-(NSString *)bd_pageUrl{
    return nil;
}
-(Class)bd_pageModelClass{
    return nil;
}
-(NSDictionary *)bd_params{
    return nil;
}
-(NSString *)bd_parsingKey{
    return nil;
}

#pragma mark - UICollectionViewDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [UICollectionViewCell new];
}


#pragma mark - UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return collectionView.frame.size;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}

#pragma mark - noInsetAdjustmentBehavior
-(void)bd_noInsetAdjustmentBehavior{
    if (@available(iOS 11.0, *)) {
        if ([self.collectionView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
            self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.edgesForExtendedLayout =  UIRectEdgeAll;
}

#pragma mark - 懒加载
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _collectionView.dataSource = self;
        _collectionView.delegate  = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}
-(UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc]init];
        _layout.scrollDirection = [self scrollDirection];
        _layout.minimumInteritemSpacing = [self minimumInteritemSpacing];
        _layout.minimumLineSpacing = [self minimumLineSpacing];
    }
    return _layout;
}

- (BDPageNetwork *)pageNet {
    if (!_pageNet) {
        NSString *url      = [self bd_pageUrl];
        NSString *key      = [self bd_parsingKey];
        NSDictionary *para = [self bd_params];
        Class class        = [self bd_pageModelClass];
        
        if (para) {
            _pageNet = [[BDPageNetwork alloc] initWithJSONModelClass:class
                                                                  key:key
                                                              apiPath:url
                                                               params:para];
        }else{
            _pageNet = [[BDPageNetwork alloc] initWithJSONModelClass:class
                                                                  key:key
                                                              apiPath:url];
        }
        
        __weak typeof(self) wself = self;
        
        _pageNet.RefreshHandler = ^{
            __strong typeof(self) strongSelf = wself;
            if (strongSelf) {
                if (!strongSelf.dataArray) {
                    strongSelf.dataArray = [NSMutableArray array];
                } else {
                    [strongSelf.dataArray removeAllObjects];
                }
            }
        };
        _pageNet.NextPageHandler = ^(NSArray *results, BOOL isAllLoaded) {
            __strong typeof(self) strongSelf = wself;
            if (strongSelf) {
                [strongSelf.dataArray addObjectsFromArray:results];
                if (isAllLoaded) {
                    [strongSelf.collectionView endRefreshAllLoad:isAllLoaded];
                }else{
                    [strongSelf.collectionView endRefresh];
                }
            }
        };
        
        _pageNet.AllLoadedHandler = ^{
            __strong typeof(self) strongSelf = wself;
            if (strongSelf) {
                [strongSelf.collectionView endRefreshAllLoad:YES];
            }
        };
        
        _pageNet.NetworkingErrorHandler = ^(NSError *error, NSString *message) {
            __strong typeof(self) strongSelf = wself;
            if (strongSelf) {
                [strongSelf.collectionView endRefresh];
            }
        };
    }
    return _pageNet;
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

@end
