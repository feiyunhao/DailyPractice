//
//  ViewController.m
//  ProducerConsumer
//
//  Created by feiyun on 16/7/14.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import "ViewController.h"
#import "RNQueue.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *inQueueLabel;
@property (strong, nonatomic) IBOutletCollection(UIProgressView) NSArray *progressViews;

@property (nonatomic) dispatch_semaphore_t semaphore;
@property (nonatomic) dispatch_queue_t pendingQueue;
@property (nonatomic) dispatch_queue_t workQueue;
@property (nonatomic) int _pendingJobCount;

@end

@implementation ViewController

- (IBAction)runProcess:(UIButton *)sender {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.semaphore = dispatch_semaphore_create([self.progressViews count]);
    self.pendingQueue = RNQueueCreateTagged("ProducerConsumer.pending",DISPATCH_QUEUE_SERIAL);
    self.workQueue = RNQueueCreateTagged("ProducerConsumer.work", DISPATCH_QUEUE_CONCURRENT);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
