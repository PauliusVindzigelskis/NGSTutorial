//
//  NGSTutorialController.m
//  NGSTutorialControllerDemo
//
//  Created by Vindzigelskis, Paulius on 12/8/17.
//  Copyright © 2017 Paulius Vindzigelskis. All rights reserved.
//

#import "NGSTutorialController.h"
#import <Masonry/Masonry.h>

@implementation NGSItem
@end

@interface NGSTutorialController () <JMHoledViewDelegate>

@property (nonatomic, assign, readwrite) NSInteger currentScene;
@property (nonatomic, weak) JMHoledView *holedView;

@end

@implementation NGSTutorialController

#pragma mark - Public API

-(void)loadScene:(NSInteger)scene
{
    NSInteger sceneCount = [self numberOfScenes];
    if (scene >= sceneCount)
    {
        return;
    }

    [self.holedView removeHoles];
    
    NSInteger items = [self.dataSource tutorialController:self numberOfItemsInScene:scene];
    for (int i = 0; i < items; i++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:scene];
        NGSItem *item = [self.dataSource tutorialController:self itemAtIndexPath:indexPath];
        
        CGRect itemRect = item.target.frame;
        CGRect localRect = [self.view convertRect:itemRect fromView:item.target.superview];
        
        [self.holedView addHoleRoundedRectOnRect:localRect
                                    cornerRadius:item.cornerRadius
                                  attributedText:item.text
                                      onPosition:item.position
                                          margin:item.margin];
    }
}

-(void)loadNextScene
{
    NSInteger sceneCount = [self numberOfScenes];
    NSInteger scene = MIN(sceneCount-1, self.currentScene+1);
    if (scene != self.currentScene)
    {
        [self loadScene:scene];
    }
}

-(void)loadPreviousScene
{
    NSInteger scene = MAX(0, self.currentScene-1);
    if (scene != self.currentScene)
    {
        [self loadScene:scene];
    }
}

#pragma mark - Private API

- (NSInteger) numberOfScenes
{
    NSInteger scenes = 1;
    
    if ([self.dataSource respondsToSelector:@selector(numberOfScenesInTutorialController:)])
    {
        scenes = [self.dataSource numberOfScenesInTutorialController:self];
    }
    
    return scenes;
}

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JMHoledView *holedView = [[JMHoledView alloc] init];
    [self.view addSubview:holedView];
    [holedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.holedView = holedView;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadScene:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - JMHoledView delegate

-(void)holedView:(JMHoledView *)holedView didSelectHoleAtIndex:(NSUInteger)index
{
    //index is useless as all holes and labels have indexes
    if ([self.delegate respondsToSelector:@selector(tutorialControllerDidReceiveTap:)])
    {
        [self.delegate tutorialControllerDidReceiveTap:self];
    }
}

-(void)holedView:(JMHoledView *)holedView willAddLabel:(UILabel *)label atIndex:(NSUInteger)index
{
    if ([self.delegate respondsToSelector:@selector(tutorialController:willShowLabel:atIndexPath:)])
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:self.currentScene];
        [self.delegate tutorialController:self willShowLabel:label atIndexPath:indexPath];
    }
}

@end
