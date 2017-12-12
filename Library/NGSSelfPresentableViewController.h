//
//  NGSSelfPresentableViewController.h
//  Pods
//
//  Created by Vindzigelskis, Paulius on 12/8/17.
//

#import <UIKit/UIKit.h>
/**
 Ability to show UIViewController within it's own UIWindow. Useful when needs to be presented on top of other view controller or presenting view controller is unknown.
*/
@interface NGSSelfPresentableViewController : UIViewController

/**
 Presents a view controller modally on top of it's own UIWindow. Window gets destroyed with controller being hidden (dismissed)
 
 @param animated Pass YES to animate the presentation; otherwise, pass NO.
 */
- (void)showAnimated:(BOOL)animated;
/**
 Presents a view controller modally on top of it's own UIWindow. Window gets destroyed with controller being hidden (dismissed)
 
 @param animated Pass YES to animate the presentation; otherwise, pass NO.
 @param completion The block to execute after the presentation finishes. This block has no return value and takes no parameters. You may specify nil for this parameter.
 */
- (void)showAnimated:(BOOL)animated completion:(void (^)(void))completion;

@end
