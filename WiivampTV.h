#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#define SETTINGS_PLIST_PATH @"/var/mobile/Library/Preferences/us.diatr.WiivampTV.plist"

@interface UIViewController (WiivampTV)
- (void)playSong:(NSString *)songName restartTime:(CMTime)time;
- (void)viewDidAppear:(BOOL)arg1;
@end
