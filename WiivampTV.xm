#import "WiivampTV.h"

NSDictionary *WiivampTVPrefs = [[[NSDictionary alloc] initWithContentsOfFile:SETTINGS_PLIST_PATH]?:[NSDictionary dictionary] copy];
NSBundle *audioPath = [NSBundle bundleWithPath:@"/Library/Application Support/WiivampTV/"];

static BOOL TVAppStoreEnabled = (BOOL)[[WiivampTVPrefs objectForKey:@"TVAppStoreEnabled"]?:@YES boolValue];
static BOOL NitoTVEnabled = (BOOL)[[WiivampTVPrefs objectForKey:@"NitoTVEnabled"]?:@YES boolValue];
static BOOL TVPhotosEnabled = (BOOL)[[WiivampTVPrefs objectForKey:@"TVPhotosEnabled"]?:@YES boolValue];
BOOL hasPlayedAppStore = NO;
BOOL hasPlayedNitoTV = NO;
BOOL hasPlayedPhotos = NO;

// HBLogInfo(@"###WiivampTVPrefs: %@", WiivampPrefs);

%hook UIViewController
-(void)viewDidAppear:(BOOL)arg1 {
    %orig;
    if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.TVAppStore"] && TVAppStoreEnabled && !hasPlayedAppStore) {
        [self playSong:@"store"];
        hasPlayedAppStore = YES;
    }

    if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.nito.nitoTV4"] && NitoTVEnabled && !hasPlayedNitoTV) {
        [self playSong:@"hbc"];
        hasPlayedNitoTV = YES;    
    }     

    if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.TVPhotos"] && TVPhotosEnabled && !hasPlayedPhotos) {
        [self playSong:@"photos"];
        hasPlayedPhotos = YES;  
    }
}
%new
-(void)playSong:(NSString *)songName {
    // NSLog(@"###WiivampTV: Playing audio: %@", songName);
    AVPlayerItem *song = [AVPlayerItem playerItemWithURL:[audioPath URLForResource:songName withExtension:@"mp3"]];
    AVPlayer *songPlayer = [[AVPlayer alloc] initWithPlayerItem:song];
    songPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(itemDidFinishPlaying:)
                                               name:AVPlayerItemDidPlayToEndTimeNotification
                                             object:[songPlayer currentItem]];
    songPlayer.volume = 0.3;
    [songPlayer play];
} 
%new
- (void)itemDidFinishPlaying:(NSNotification *)notification {
    AVPlayerItem *item = [notification object];
    [item seekToTime:kCMTimeZero];
}
%end
