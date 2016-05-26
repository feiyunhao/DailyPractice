//
//  ViewController.m
//  CoreTextDemo
//
//  Created by feiyun on 16/5/24.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import "ViewController.h"
#import "SYCTDisplayView.h"
#import "SYCTFrameParserConfig.h"
#import "SYCTFrameParser.h"
#import "SYCTImageData.h"
#import "SYCTData.h"
#import "SYCTLinkData.h"
#import "ImageViewController.h"
#import "WebContentViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet SYCTDisplayView *ctView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNotifications];
    
    NSLog(@"%s",__func__);
    SYCTFrameParserConfig *config = [[SYCTFrameParserConfig alloc] init];
    config.width = self.ctView.width;

    NSString *path = [[NSBundle mainBundle] pathForResource:@"contentWithImage" ofType:@"json"];
    SYCTData *data = [SYCTFrameParser  parseTemplateFile:path config:config];
    self.ctView.data = data;
    self.ctView.height = data.height;
    self.ctView.backgroundColor = [UIColor cyanColor];
    
}

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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
