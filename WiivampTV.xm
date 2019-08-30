#import "WiivampTV.h"

NSDictionary *WiivampTVPrefs = [[[NSDictionary alloc] initWithContentsOfFile:SETTINGS_PLIST_PATH]?:[NSDictionary dictionary] copy];
NSBundle *audioPath = [NSBundle bundleWithPath:@"/Library/Application Support/WiivampTV/"];

static BOOL TVAppStoreEnabled = (BOOL)[[WiivampTVPrefs objectForKey:@"TVAppStoreEnabled"]?:@YES boolValue];
static BOOL NitoTVEnabled = (BOOL)[[WiivampTVPrefs objectForKey:@"NitoTVEnabled"]?:@YES boolValue];
static BOOL TVPhotosEnabled = (BOOL)[[WiivampTVPrefs objectForKey:@"TVPhotosEnabled"]?:@YES boolValue];
static BOOL PineBoardEnabled = (BOOL)[[WiivampTVPrefs objectForKey:@"PineBoardEnabled"]?:@YES boolValue];
BOOL hasPlayedAppStore = NO;
BOOL hasPlayedNitoTV = NO;
BOOL hasPlayedPhotos = NO;
BOOL hasPlayedPineBoard = NO;

#ifdef DEBUG
    #define DEBUGLOG(...) NSLog(__VA_ARGS__);
#else
    #define DEBUGLOG(...) {}
#endif

%hook UIViewController
- (void)viewDidAppear:(BOOL)arg1 {
    %orig;
    DEBUGLOG(@"###WiivampTVPrefs: %@", WiivampTVPrefs);
    DEBUGLOG(@"###WiivampTV: Main Bundle Identifier: %@", [[NSBundle mainBundle] bundleIdentifier]);

    if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.TVAppStore"] && TVAppStoreEnabled && !hasPlayedAppStore) {
        [self playSong:@"shop" restartTime:CMTimeMake(7, 1)];
        hasPlayedAppStore = YES;
    }

    if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.nito.nitoTV4"] && NitoTVEnabled && !hasPlayedNitoTV) {
        [self playSong:@"hbc" restartTime:CMTimeMake(8, 1)];
        hasPlayedNitoTV = YES; 
    }

    if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.TVPhotos"] && TVPhotosEnabled && !hasPlayedPhotos) {
        [self playSong:@"photos" restartTime:CMTimeMake(10, 1)];
        hasPlayedPhotos = YES;  
    }

    if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.HeadBoard"] && PineBoardEnabled && !hasPlayedPineBoard) {
        [self playSong:@"mainmenu" restartTime:CMTimeMake(20, 1)];
        hasPlayedPineBoard = YES;
    }
}
%new
- (void)playSong:(NSString *)songName restartTime:(CMTime)time {
    DEBUGLOG(@"###WiivampTV: Playing audio: %@", songName);
    AVPlayerItem *song = [AVPlayerItem playerItemWithURL:[audioPath URLForResource:songName withExtension:@"m4a"]];
    AVPlayer *songPlayer = [[AVPlayer alloc] initWithPlayerItem:song];
    songPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    NSNotificationCenter *noteCenter = [NSNotificationCenter defaultCenter];
    [noteCenter addObserverForName:AVPlayerItemDidPlayToEndTimeNotification 
                                                    object:[songPlayer currentItem] 
                                                    queue:nil 
                                                    usingBlock:^(NSNotification *note) {
                                                        [song seekToTime:time];
                                                    }];

    [noteCenter addObserverForName:UIApplicationDidEnterBackgroundNotification 
                                                    object:nil
                                                    queue:nil 
                                                    usingBlock:^(NSNotification *note) {
                                                        DEBUGLOG(@"###WiivampTV: %@ did enter background!", [[NSBundle mainBundle] bundleIdentifier]);
                                                        [songPlayer pause];
                                                    }];

    [noteCenter addObserverForName:UIApplicationWillEnterForegroundNotification 
                                                    object:nil
                                                    queue:nil 
                                                    usingBlock:^(NSNotification *note) {
                                                        DEBUGLOG(@"###WiivampTV: %@ did enter foreground!", [[NSBundle mainBundle] bundleIdentifier]);
                                                        usleep(1000000);
                                                        [songPlayer play];
                                                    }];

    [noteCenter addObserverForName:UIApplicationWillTerminateNotification 
                                                    object:nil
                                                    queue:nil 
                                                    usingBlock:^(NSNotification *note) {
                                                        [songPlayer release];
                                                        DEBUGLOG(@"###WiivampTV: Released from %@!", [[NSBundle mainBundle] bundleIdentifier]);
                                                    }];
                                                    
    songPlayer.volume = 0.3;
    usleep(1000000);
    [songPlayer play];
}
%new
-(void)killPineBoard {
    system("killall -9 PineBoard");
}
%end
