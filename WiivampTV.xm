@import Foundation;
@import UIKit;
@import AVFoundation;

#define SETTINGS_PLIST_PATH @"/var/mobile/Library/Preferences/us.diatr.WiivampTV.plist"

NSDictionary *WiivampTVPrefs = [[[NSDictionary alloc] initWithContentsOfFile:SETTINGS_PLIST_PATH]?:[NSDictionary dictionary] copy];
NSBundle *audio = [NSBundle bundleWithPath:@"/Library/Application Support/WiivampTV/"];
AVQueuePlayer *songPlayer = [[AVQueuePlayer alloc] init];
AVPlayerLooper *songLooper;

static BOOL TVAppStoreEnabled = (BOOL)[[WiivampTVPrefs objectForKey:@"TVAppStoreEnabled"]?:@YES boolValue];
static BOOL NitoTVEnabled = (BOOL)[[WiivampTVPrefs objectForKey:@"NitoTVEnabled"]?:@YES boolValue];
static BOOL TVPhotosEnabled = (BOOL)[[WiivampTVPrefs objectForKey:@"TVPhotosEnabled"]?:@YES boolValue];
BOOL hasPlayedAppStore = NO;
BOOL hasPlayedNitoTV = NO;
BOOL hasPlayedPhotos = NO;

//HBLogInfo(@"###WiivampTVPrefs: %@", WiivampPrefs);

%hook UIViewController
-(void)viewDidAppear:(BOOL)arg1 {
    %orig;
    if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.TVAppStore"] && TVAppStoreEnabled) {
        AVPlayerItem *song = [AVPlayerItem playerItemWithURL:[audio URLForResource:@"store" withExtension:@"mp3"]];
        if (!hasPlayedAppStore) {
            //NSLog(@"WiivampTV: Playing AppStore audio...");
            songLooper = [[AVPlayerLooper alloc] initWithPlayer:songPlayer templateItem:song timeRange:kCMTimeRangeInvalid];
            songPlayer.volume = 0.3;
            [songPlayer play];
            hasPlayedAppStore = YES;
        }    
    }

    if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.nito.nitoTV4"] && NitoTVEnabled) {
        AVPlayerItem *song = [AVPlayerItem playerItemWithURL:[audio URLForResource:@"hbc" withExtension:@"mp3"]];
        if (!hasPlayedNitoTV) {
            //NSLog(@"WiivampTV: Playing NitoTV audio...");
            songLooper = [[AVPlayerLooper alloc] initWithPlayer:songPlayer templateItem:song timeRange:kCMTimeRangeInvalid];
            songPlayer.volume = 0.3;
            [songPlayer play];
            hasPlayedNitoTV = YES;
        }    
    }     

    if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.TVPhotos"] && TVPhotosEnabled) {
        AVPlayerItem *song = [AVPlayerItem playerItemWithURL:[audio URLForResource:@"photo" withExtension:@"mp3"]];
        if (!hasPlayedPhotos) {
            //NSLog(@"WiivampTV: Playing Photos audio...");
            songLooper = [[AVPlayerLooper alloc] initWithPlayer:songPlayer templateItem:song timeRange:kCMTimeRangeInvalid];
            songPlayer.volume = 0.3;
            [songPlayer play];
            hasPlayedPhotos = YES;
        }    
    }    

/*  Currently plays everywhere, need to find a new way to check current app
    AVPlayerItem *start = [AVPlayerItem playerItemWithURL:[audio URLForResource:@"menustart" withExtension:@"mp3"]];
    AVPlayerItem *end = [AVPlayerItem playerItemWithURL:[audio URLForResource:@"menuend" withExtension:@"mp3"]];
    if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.PineBoard"]) {
        if (!hasPlayedHomeScreen) {
            AVQueuePlayer *songPlayer = [[AVQueuePlayer alloc] initWithItems:@[start]];
            songPlayer.volume = 0.3;
            [songPlayer play];
            hasPlayedHomeScreen = YES;
            double delayInSeconds = 0.4;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                hasPlayedHomeScreenStart = YES;
            });
        }    
        if(!hasPlayedHomeScreenEnd && hasPlayedHomeScreenStart){
            AVQueuePlayer *songPlayer = [[AVQueuePlayer alloc] init];
            songPlayer.volume = 0.3;
            songLooper = [[AVPlayerLooper alloc] initWithPlayer:songPlayer templateItem:end timeRange:kCMTimeRangeInvalid];
            [songPlayer play];
            hasPlayedHomeScreenEnd = YES;
        }
    }*/
}
%end
