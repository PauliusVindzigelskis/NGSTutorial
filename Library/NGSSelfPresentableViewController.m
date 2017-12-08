//
//  NGSSelfPresentableViewController.m
//  Pods
//
//  Created by Vindzigelskis, Paulius on 12/8/17.
//

#import "NGSSelfPresentableViewController.h"

@interface NGSSelfPresentableViewController ()

@property (nonatomic, strong) UIWindow *presentWindow;

@end

@implementation NGSSelfPresentableViewController

- (void)showAnimated:(BOOL)animated
{
    [self showAnimated:animated completion:nil];
}

- (void)showAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    self.presentWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.presentWindow.rootViewController = [[UIViewController alloc] init];
    
    id<UIApplicationDelegate> delegate = [UIApplication sharedApplication].delegate;
    // Applications that does not load with UIMainStoryboardFile might not have a window property:
    if ([delegate respondsToSelector:@selector(window)]) {
        // we inherit the main window's tintColor
        self.presentWindow.tintColor = delegate.window.tintColor;
    }
    
    // window level is above the top window (this makes the alert, if it's a sheet, show over the keyboard)
    UIWindow *topWindow = [UIApplication sharedApplication].windows.lastObject;
    self.presentWindow.windowLevel = topWindow.windowLevel + 1;
    
    [self.presentWindow makeKeyAndVisible];
    [self.presentWindow.rootViewController presentViewController:self animated:animated completion:completion];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    // precaution to insure window gets destroyed
    self.presentWindow.hidden = YES;
    self.presentWindow = nil;
}

@end
