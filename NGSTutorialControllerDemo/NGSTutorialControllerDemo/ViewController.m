//
//  ViewController.m
//  NGSTutorialControllerDemo
//
//  Created by Vindzigelskis, Paulius on 12/8/17.
//  Copyright © 2017 Paulius Vindzigelskis. All rights reserved.
//

#import "ViewController.h"
#import <NGSTutorial/NGSTutorial.h>

typedef NS_ENUM(NSInteger, TargetType)
{
    TargetTypePlain,
    TargetTypeRounded,
    TargetTypeCircle
};

@interface DemoItem : NGSItem
@property (nonatomic, assign) TargetType type;
@property (nonatomic, assign) BOOL borderedText;
@end

@implementation DemoItem
@end

@interface ViewController () <NGSTutorialControllerDataSource, NGSTutorialControllerDelegate>
@property (weak, nonatomic) IBOutlet UIStackView *stackView;
@property (strong, nonatomic) NSMutableArray< NSMutableArray<DemoItem*> * > *scenes;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray<UIView*> *allViews = self.stackView.arrangedSubviews;
    self.scenes = [@[] mutableCopy];
    
    NSInteger sceneIndex = [self addScene];
    
    //Scene 1
    [self addItemWithTarget:allViews[0]
                    comment:@"Uno button"
               borderedText:NO
                   position:JMPositionLeft
                       type:TargetTypePlain
                    inScene:sceneIndex];
    
    [self addItemWithTarget:allViews[1] comment:@"Tap to continue"
               borderedText:NO
                   position:JMPositionBottom
                       type:TargetTypeCircle
                    inScene:sceneIndex];
    
    //Scene 2
    sceneIndex = [self addScene];
    
    [self addItemWithTarget:allViews[2] comment:@"Tres text again\nSecond line here\nn' here"
               borderedText:NO
                   position:JMPositionRight
                       type:TargetTypePlain
                    inScene:sceneIndex];
    
    //Scene 3
    sceneIndex = [self addScene];
    [self addItemWithTarget:allViews[3] comment:@"Quattro text"
               borderedText:NO
                   position:JMPositionRight
                       type:TargetTypePlain
                    inScene:sceneIndex];
    
    //Scene 4 with button and label in bordered labels
    sceneIndex = [self addScene];
    [self addItemWithTarget:allViews[4] comment:@"Pinto over here"
               borderedText:YES
                   position:JMPositionRight
                       type:TargetTypeRounded
                    inScene:sceneIndex];
    
    [self addItemWithTarget:allViews[5] comment:@"Sixto is a label?"
               borderedText:YES
                   position:JMPositionBottom
                       type:TargetTypePlain
                    inScene:sceneIndex];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NGSTutorialController *controller = [[NGSTutorialController alloc] init];
    controller.dataSource = self;
    controller.delegate = self;
    [controller showAnimated:YES];
}
    
#pragma mark - Scene Handling
    
- (NSInteger) addScene
{
    NSInteger index = self.scenes.count;
    NSMutableArray<DemoItem*> *obj = [@[] mutableCopy];
    [self.scenes addObject:obj];
    return index;
}

- (void) addItemWithTarget:(UIView*)target comment:(NSString*)comment borderedText:(BOOL)bordered position:(JMHolePosition)position type:(TargetType)type inScene:(NSInteger)sceneIndex
{
    DemoItem *item = [[DemoItem alloc] init];
    item.text = [[NSAttributedString alloc] initWithString:comment
                                                attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14.f]}];
    item.target = target;
    item.position = position;
    item.margin = 20.f;
    item.type = type;
    item.borderedText = bordered;
    
    switch (type) {
        case TargetTypeCircle:
        {
            CGFloat dimension = MIN(target.frame.size.width, target.frame.size.height);
            item.cornerRadius = dimension / 2.f;
        } break;
        
        case TargetTypeRounded:
        item.cornerRadius = 5.f;
        break;
        
        case TargetTypePlain: break;
    }
                 
    [self.scenes[sceneIndex] addObject:item];
}

#pragma mark - NGSTutorialController Data Source

-(NSInteger)numberOfScenesInTutorialController:(NGSTutorialController *)tutorial
{
    return self.scenes.count;
}

-(NSInteger)tutorialController:(NGSTutorialController *)tutorial numberOfItemsInScene:(NSInteger)scene
{
    return self.scenes[scene].count;
}

-(NGSItem *)tutorialController:(NGSTutorialController *)tutorial itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.scenes[indexPath.section][indexPath.item];
}

#pragma mark - NGSTutorialController delegate

-(void)tutorialController:(NGSTutorialController *)tutorial willShowLabel:(UILabel *)label atIndexPath:(NSIndexPath *)indexPath
{
    DemoItem *item = self.scenes[indexPath.section][indexPath.item];
    
    if (item.borderedText)
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
