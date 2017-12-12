//
//  NGSTutorialController.h
//  NGSTutorialControllerDemo
//
//  Created by Vindzigelskis, Paulius on 12/8/17.
//  Copyright © 2017 Paulius Vindzigelskis. All rights reserved.
//

#import "NGSSelfPresentableViewController.h"
#import <JMHoledView/JMHoledView.h>

/**
 Description of one tutorial item to be displayed. Item consists of hole location provided by 'target' view and attributed string from 'text' property.
*/
@interface NGSItem : NSObject
/**
 The target view to highlight an element being described. Makes a hole in tinted background to see through
 */
@property (nonatomic, weak) UIView *target;
/**
 Corner radius of target view hole
 */
@property (nonatomic, assign) CGFloat cornerRadius;
/**
 Margin between text and target view hole
 */
@property (nonatomic, assign) CGFloat margin;
/**
 Describe an element (target) presented
 */
@property (nonatomic, copy) NSAttributedString *text;
/**
 Position of text label relative to target hole.
 
 E.x. 'Left' would mean H:[label]-(margin)-[target]
 
 @warning It doesn't check screen bounds
 */
@property (nonatomic, assign) JMHolePosition position;

@end

@class NGSTutorialController;
@protocol NGSTutorialControllerDataSource<NSObject>

@optional
/**
 Optional: Number of scenes to be presented. Default is 1
 */
- (NSInteger) numberOfScenesInTutorialController:(NGSTutorialController*)tutorial;

@required
/**
 Required: Number of items to be presented in scene
 */
- (NSInteger) tutorialController:(NGSTutorialController*)tutorial numberOfItemsInScene:(NSInteger)scene;

/**
 Required: Item description at specified index path. Uses section and item of NSIndexPath
 */
- (NGSItem*) tutorialController:(NGSTutorialController*)tutorial itemAtIndexPath:(NSIndexPath*)indexPath;

@end

@protocol NGSTutorialControllerDelegate<NSObject>
@optional
/**
 Optional: Feedback about received tap anywhere on tutorial screen. If not implemented, by default calls loadNextScene: if there are more scenes to be presented and dismissViewControllerAnimated:completion: with no more scenes available.
 */
- (void) tutorialControllerDidReceiveTap:(NGSTutorialController*)tutorial;
/**
 Optional: The label is about to be presented for item at provided index path. Use this to make necessary modifications to UILabel, including frame and layer properties.
 */
- (void) tutorialController:(NGSTutorialController*)tutorial willShowLabel:(UILabel*)label atIndexPath:(NSIndexPath*)indexPath;
@end

/**
 Mechanism to show tutorial guidelines on screen by providing points of interest with texts nearby.
 
 ## How it works
 
 Scene consists of collection of NGSItem objects passed by dataSource. Tutorial can have 1 or more Scenes (section in NSIndexPath) which navigation can be controlled by loadScene: (or its equivalent) method.
 
 By default, each user tap navigates to next scene (closes tutorial on last), but this can be overriden with tutorialControllerDidReceiveTap: delegate method.
 
 */
@interface NGSTutorialController : NGSSelfPresentableViewController

/**
 Current scene being presented
 */
@property (nonatomic, assign, readonly) NSInteger currentScene;
/**
 The object that acts as the data source of the tutorial controller.
 The data source must adopt the NGSTutorialControllerDataSource protocol. The data source is not retained.
*/
@property (nonatomic, weak) id<NGSTutorialControllerDataSource> dataSource;
/**
 The object that acts as the delegate of the tutorial controller.
 The delegate must adopt the NGSTutorialControllerDelegate protocol. The delegate is not retained.
 */
@property (nonatomic, weak) id<NGSTutorialControllerDelegate> delegate;
/**
 Color of tinted background. Default is black with 75% transparancy
 */
@property (nonatomic, strong) UIColor *tintColor;

/**
 @param scene index of scene being fetched from data source
 @return True if provided scene is in bounds and able to load
 */
- (BOOL) loadScene:(NSInteger)scene;
/**
 Loads scene at (currentIndex + 1) index
 @return True if scene is in bounds and able to load
 */
- (BOOL) loadNextScene;
/**
 Loads scene at (currentIndex - 1) index
 @return True if scene is in bounds and able to load
 */
- (BOOL) loadPreviousScene;
/**
 Reloads scene at currentIndex index
 @return True if scene is in bounds and able to load
 */
- (BOOL) reloadCurrentScene;

@end
