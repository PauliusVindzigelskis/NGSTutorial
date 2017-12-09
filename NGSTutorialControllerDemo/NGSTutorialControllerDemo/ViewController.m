//
//  ViewController.m
//  NGSTutorialControllerDemo
//
//  Created by Vindzigelskis, Paulius on 12/8/17.
//  Copyright © 2017 Paulius Vindzigelskis. All rights reserved.
//

#import "ViewController.h"
#import <NGSTutorial/NGSTutorial.h>

@interface ViewController () <NGSTutorialControllerDataSource, NGSTutorialControllerDelegate>
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
    controller.delegate = self;
    [controller showAnimated:YES];
}

#pragma mark - NGSTutorialController Data Source

-(NSInteger)numberOfScenesInTutorialController:(NGSTutorialController *)tutorial
{
    return [self.stackView arrangedSubviews].count/2;
}

-(NSInteger)tutorialController:(NGSTutorialController *)tutorial numberOfItemsInScene:(NSInteger)scene
{
    return 2;
}

-(NGSItem *)tutorialController:(NGSTutorialController *)tutorial itemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray<UIView*> *views = [self.stackView arrangedSubviews];
    NSInteger itemsPerScene = 2;
    UIView *view = views[indexPath.item + (indexPath.section * itemsPerScene)];
    
    NSString *text = [NSString stringWithFormat:@"Item No.%lu", indexPath.item];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:text attributes:@{
                                                                                                  NSFontAttributeName : [UIFont systemFontOfSize:14.f]
                                                                                                  }];
    
    NGSItem *item = [[NGSItem alloc] init];
    item.target = view;
    CGFloat cornerRadius = 0.f;
    JMHolePosition position = indexPath.section % 2 == 0 ? JMPositionRight : JMPositionLeft;
    
    if ([view isKindOfClass:[UIButton class]])
    {
        UIButton *button = (UIButton*)view;
        if (button.buttonType != UIButtonTypeCustom)
        {
            //info button. make it round
            cornerRadius = button.frame.size.height/2.f;
        }
    } else if ([view isKindOfClass:[UILabel class]])
    {
        cornerRadius = 0.f;
        position = JMPositionBottom;
    }
    
    item.cornerRadius = cornerRadius;
    item.text = attrString;
    item.position = position;
    item.margin = 20.f;
    
    return item;
}

#pragma mark - NGSTutorialController delegate

-(void)tutorialController:(NGSTutorialController *)tutorial willShowLabel:(UILabel *)label atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section > 1)
    {
        //add rounded border
        label.layer.cornerRadius = 3.f;
        label.layer.borderWidth = 1.f;
        label.layer.borderColor = [UIColor whiteColor].CGColor;
        
        CGFloat margin = label.layer.borderWidth + 4;
        CGRect frame = label.frame;
        frame.origin.x -= margin;
        frame.origin.y -= margin;
        frame.size.width += margin*2;
        frame.size.height += margin*2;
        label.frame = frame;
    }
}


@end
