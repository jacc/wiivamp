#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <SparkAppList.h>

#define SETTINGS_PLIST_PATH @"/var/mobile/Library/Preferences/com.jacc.wiiprefs.plist"

AVPlayer* songPlayer;
AVPlayerLooper* songLooper;

@interface UIViewController (Wiivamp)
- (void)playSong:(NSString *)songName restartTime:(CMTime)time;
- (void)viewDidAppear:(BOOL)arg1;
@end
