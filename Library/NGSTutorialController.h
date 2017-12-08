//
//  NGSTutorialController.h
//  NGSTutorialControllerDemo
//
//  Created by Vindzigelskis, Paulius on 12/8/17.
//  Copyright © 2017 Paulius Vindzigelskis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JMHoledView/JMHoledView.h>

@interface NGSItem : NSObject

@property (nonatomic, weak) UIView *target;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) CGFloat margin;
@property (nonatomic, copy) NSAttributedString *text;
@property (nonatomic, assign) JMHolePosition position;

@end

@class NGSTutorialController;
@protocol NGSTutorialControllerDataSource<NSObject>

@optional
- (NSInteger) numberOfScenesInTutorialController:(NGSTutorialController*)tutorial;

@required
- (NSInteger) tutorialController:(NGSTutorialController*)tutorial numberOfItemsInScene:(NSInteger)scene;

//NSIndexPath.section == scene
- (NGSItem*) tutorialController:(NGSTutorialController*)tutorial itemAtIndexPath:(NSIndexPath*)indexPath;

@end

@protocol NGSTutorialControllerDelegate<NSObject>
@optional
//Keep in mind that index can be NSNotFound
- (void) tutorialControllerDidReceiveTap:(NGSTutorialController*)tutorial;
- (void) tutorialController:(NGSTutorialController*)tutorial willShowLabel:(UILabel*)label atIndexPath:(NSIndexPath*)indexPath;
@end

@interface NGSTutorialController : UIViewController

@property (nonatomic, assign, readonly) NSInteger currentScene;
@property (nonatomic, weak) id<NGSTutorialControllerDataSource> dataSource;
@property (nonatomic, weak) id<NGSTutorialControllerDelegate> delegate;

- (void) loadScene:(NSInteger)scene;
- (void) loadNextScene;
- (void) loadPreviousScene;

@end
