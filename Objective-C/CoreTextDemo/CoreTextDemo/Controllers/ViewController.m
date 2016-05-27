//
//  ViewController.m
//  CoreTextDemo
//
//  Created by feiyun on 16/5/26.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import "ViewController.h"

#import "SYCTFrameParser.h"
#import "SYCTFrameParserConfig.h"
#import "SYCTData.h"
#import "SYCTDisPlayView.h"
#import "SYCTImageData.h"
#import "SYCTLinkData.h"
#import "ImageViewController.h"
#import "WebContentViewController.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet SYCTDisplayView *disPlayView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNotifications];
    
    NSArray *dataArray = [self getDataArrFromSomeWhere];
    SYCTFrameParserConfig  *config= [[SYCTFrameParserConfig alloc] init];
    SYCTData *ctData = [SYCTFrameParser parseTempateArray:dataArray config:config];
    
    self.disPlayView.ctData = ctData;
    
    
    
}

#pragma mark - 处理点击事件

- (void)setupNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imagePressed:)
                                                 name:SYCTDisplayViewImagePressedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(linkPressed:)
                                                 name:SYCTDisplayViewLinkPressedNotification object:nil];
    
}

- (void)imagePressed:(NSNotification*)notification {
    NSDictionary *userInfo = [notification userInfo];
    SYCTImageData *imageData = userInfo[@"imageData"];
    
    ImageViewController *vc = [[ImageViewController alloc] init];
    vc.image = [UIImage imageNamed:imageData.name];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)linkPressed:(NSNotification*)notification {
    NSDictionary *userInfo = [notification userInfo];
    SYCTLinkData *linkData = userInfo[@"linkData"];
    
    WebContentViewController *vc = [[WebContentViewController alloc] init];
    vc.urlTitle = linkData.title;
    vc.url = linkData.urlStr;
    [self presentViewController:vc animated:YES completion:nil];
}


- (NSArray*)getDataArrFromSomeWhere {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"contentWithImage" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSArray *dataArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    return dataArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
