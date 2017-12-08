//
//  NGSSelfPresentableViewController.h
//  Pods
//
//  Created by Vindzigelskis, Paulius on 12/8/17.
//

#import <UIKit/UIKit.h>

@interface NGSSelfPresentableViewController : UIViewController

- (void)showAnimated:(BOOL)animated;
- (void)showAnimated:(BOOL)animated completion:(void (^)(void))completion;

@end
