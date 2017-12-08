//
//  ViewController.m
//  NGSTutorialControllerDemo
//
//  Created by Vindzigelskis, Paulius on 12/8/17.
//  Copyright © 2017 Paulius Vindzigelskis. All rights reserved.
//

#import "ViewController.h"
#import <NGSTutorial/NGSTutorial.h>

@interface ViewController () <NGSTutorialControllerDataSource>
@property (weak, nonatomic) IBOutlet UIStackView *stackView;

@end

@implementation ViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor yellowColor];
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NGSTutorialController *controller = [[NGSTutorialController alloc] init];
    controller.dataSource = self;
    [controller showAnimated:YES];
}

#pragma mark - NGSTutorialController Data Source

-(NSInteger)numberOfScenesInTutorialController:(NGSTutorialController *)tutorial
{
    return 2;
}

-(NSInteger)tutorialController:(NGSTutorialController *)tutorial numberOfItemsInScene:(NSInteger)scene
{
    NSInteger count = [self.stackView arrangedSubviews].count / 2;
    return count;
}

-(NGSItem *)tutorialController:(NGSTutorialController *)tutorial itemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray<UIView*> *views = [self.stackView arrangedSubviews];
    NSInteger itemsPerScene = [self.stackView arrangedSubviews].count / 2;
    UIView *view = views[indexPath.item + (indexPath.section * itemsPerScene)];
    
    NSString *text = [NSString stringWithFormat:@"Item No.%lu", indexPath.item];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:text attributes:@{
                                                                                                  NSFontAttributeName : [UIFont systemFontOfSize:14.f]
                                                                                                  }];
    
    NGSItem *item = [[NGSItem alloc] init];
    item.target = view;
    item.cornerRadius = 5.f;
    item.text = attrString;
    item.position = indexPath.section == 0 ? JMPositionRight : JMPositionLeft;
    item.margin = 20.f;
    
    return item;
}


@end
