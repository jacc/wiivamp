#import "WIIRootListController.h"

@implementation WIIAppearanceSettings

-(UIColor *)tintColor {
    return [UIColor colorWithRed:0.52 green:0.73 blue:0.93 alpha:1.0];
}

-(UIColor *)statusBarTintColor {
    return [UIColor whiteColor];
}

-(UIColor *)navigationBarTitleColor {
    return [UIColor whiteColor];
}

-(UIColor *)navigationBarTintColor {
    return [UIColor whiteColor];
}

-(UIColor *)tableViewCellSeparatorColor {
    return [UIColor colorWithWhite:0 alpha:0];
}

-(UIColor *)navigationBarBackgroundColor {
    return [UIColor colorWithRed:0.20 green:0.60 blue:0.80 alpha:1.0];
}

-(BOOL)translucentNavigationBar {
    return NO;
}

@end
