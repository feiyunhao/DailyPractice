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

- (UIProgressView*)reserveProgressView {
    RNAssertQueue(self.pendingQueue);
    
    __block UIProgressView *availableProgressView;
    dispatch_sync(dispatch_get_main_queue(), ^{
        for (UIProgressView *progressView in self.progressViews) {
            if (progressView.isHidden) {
                availableProgressView = progressView;
                break;
            }
        }
        availableProgressView.hidden = NO;
        availableProgressView.progress = 0;
    });
    
    NSAssert(availableProgressView, @"There should always be one available here.");
    return availableProgressView;
}
- (IBAction)runProcess:(UIButton *)sender {
    RNAssertMainQueue();
    [self adjustPendingJobCountBy:1];
    dispatch_async(self.pendingQueue, ^{
        
        dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
        UIProgressView *availableProgressView = [self reserveProgressView];
        
        dispatch_async(self.workQueue, ^{
            
            [self performWorkWithProgressView:availableProgressView];
            [self releaseProgressView:availableProgressView];
            [self adjustPendingJobCountBy:-1];
            dispatch_semaphore_signal(self.semaphore);
        });
    });
}

- (void)performWorkWithProgressView:(UIProgressView *)progressView {
    RNAssertQueue(self.workQueue);
    
    for (NSUInteger p = 0; p <= 100; ++p) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            progressView.progress = p/100.0;
        });
        usleep(50000);
    }
}

- (void)releaseProgressView:(UIProgressView *)progressView {
    RNAssertQueue(self.workQueue);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        progressView.hidden = YES;
    });
}

- (void)adjustPendingJobCountBy:(NSInteger)value {
    // Safe on any queue
    dispatch_async(dispatch_get_main_queue(), ^{
        self._pendingJobCount += (int)value;
        self.inQueueLabel.text = [NSString stringWithFormat:@"%d", self._pendingJobCount];
    });
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
