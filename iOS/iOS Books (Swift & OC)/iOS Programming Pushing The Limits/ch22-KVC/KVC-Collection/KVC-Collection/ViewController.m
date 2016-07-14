//
//  ViewController.m
//  KVC-Collection
//
//  Created by feiyun on 16/7/14.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import "ViewController.h"
#import "KVCTableViewController.h"

@interface ViewController ()
@property (nonatomic, readwrite, strong) TimesTwoArray *array;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *entryLabel;

@end

@implementation ViewController

- (void)awakeFromNib {
    self.array = [TimesTwoArray new];
}

- (void)refresh {
    NSArray *items = [self.array valueForKey:@"numbers"];
    NSUInteger count = [items count];
    self.countLabel.text = [NSString stringWithFormat:@"%ld", count];
    self.entryLabel.text = [[items lastObject] description];
}

- (IBAction)performAdd:(id)sender {
    [self.array incrementCount];
    [self refresh];
}

- (void)viewWillAppear:(BOOL)animated {
    [self refresh];
    [super viewWillAppear:animated];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [(KVCTableViewController *)segue.destinationViewController setArray:self.array];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
