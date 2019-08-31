// My social media:
// Twitter: twitter.com/jvvks
// Github: github.com/jacc

#import "Wiivamp.h"

NSBundle *audio = [NSBundle bundleWithPath:@"/Library/Application Support/Wiivamp/"];

BOOL hasPlayedApp = NO;
BOOL hasPlayedWeather = NO;
BOOL hasPlayedCydia = NO;
BOOL hasPlayedNews = NO;
BOOL hasPlayedPhotos = NO;
BOOL hasPlayedContacts = NO;
BOOL hasPlayedHealth = NO;
BOOL hasPlayedHomeScreen = NO;
BOOL hasPlayedFMF = NO;

#ifdef DEBUG
    #define DEBUGLOG(...) NSLog(__VA_ARGS__);
#else
    #define DEBUGLOG(...) {}
#endif

static NSDictionary *preferences;

static BOOL PreferencesValue(NSString* key, BOOL fallback)
{
    return [preferences objectForKey:key] ? [[preferences objectForKey:key] boolValue] : fallback;
}

static void PreferencesChangedCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    CFStringRef appID = CFSTR("com.jacc.wiiprefs");
    CFArrayRef keyList = CFPreferencesCopyKeyList(appID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
    if (!keyList) {
        DEBUGLOG(@"There's been an error getting the key list!");
        return;
    }
    preferences = (NSDictionary *)CFPreferencesCopyMultiple(keyList, appID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
    if (!preferences) {
        DEBUGLOG(@"There's been an error getting the preferences dictionary!");
    }
    CFRelease(keyList);
}

%hook UIViewController
-(void)viewDidAppear:(BOOL)arg1 {
    %orig;

    if([SparkAppList doesIdentifier:@"com.jacc.wiiprefs" andKey:@"storeApp" containBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] && PreferencesValue(@"ENABLE_APPSTORE",YES) && !hasPlayedApp) {
        [self playSong:@"shop" restartTime:CMTimeMake(7, 1)];
        hasPlayedApp = YES;
    }

     if([SparkAppList doesIdentifier:@"com.jacc.wiiprefs" andKey:@"weatherApp" containBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] && PreferencesValue(@"ENABLE_WEATHER",YES) && !hasPlayedWeather) {
         AVPlayerItem *song = [AVPlayerItem playerItemWithURL:[audio URLForResource:@"wcm" withExtension:@"mp3"]];
        if (!hasPlayedWeather) {
            songLooper = [[AVPlayerLooper alloc] initWithPlayer:songPlayer templateItem:song timeRange:kCMTimeRangeInvalid];
            songPlayer.volume = 0.3;
            [songPlayer play];
            hasPlayedWeather = YES;
        }
     }

     if([SparkAppList doesIdentifier:@"com.jacc.wiiprefs" andKey:@"homebrewApp" containBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] && PreferencesValue(@"ENABLE_CYDIA",YES) && !hasPlayedCydia) {
        [self playSong:@"hbc" restartTime:CMTimeMake(8, 1)];
        hasPlayedCydia = YES;
     }

     if([SparkAppList doesIdentifier:@"com.jacc.wiiprefs" andKey:@"photoApp" containBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] && PreferencesValue(@"ENABLE_PHOTOS",YES) && !hasPlayedPhotos) {
        [self playSong:@"photos" restartTime:CMTimeMake(10, 1)];
        hasPlayedPhotos = YES;
     }

     if([SparkAppList doesIdentifier:@"com.jacc.wiiprefs" andKey:@"newsApp" containBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] && PreferencesValue(@"ENABLE_NEWS",YES) && !hasPlayedNews) {
         AVPlayerItem *song = [AVPlayerItem playerItemWithURL:[audio URLForResource:@"news" withExtension:@"mp3"]];
        if (!hasPlayedNews) {
            songLooper = [[AVPlayerLooper alloc] initWithPlayer:songPlayer templateItem:song timeRange:kCMTimeRangeInvalid];
            songPlayer.volume = 0.3;
            [songPlayer play];
            hasPlayedNews = YES;
        }
     }

     if([SparkAppList doesIdentifier:@"com.jacc.wiiprefs" andKey:@"contactApp" containBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] && PreferencesValue(@"ENABLE_CONTACTS",YES) && !hasPlayedContacts) {
        AVPlayerItem *song = [AVPlayerItem playerItemWithURL:[audio URLForResource:@"mii" withExtension:@"mp3"]];
        if (!hasPlayedContacts) {
            songLooper = [[AVPlayerLooper alloc] initWithPlayer:songPlayer templateItem:song timeRange:kCMTimeRangeInvalid];
            songPlayer.volume = 0.3;
            [songPlayer play];
            hasPlayedContacts = YES;
        }
     }

     if([SparkAppList doesIdentifier:@"com.jacc.wiiprefs" andKey:@"healthApp" containBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] && PreferencesValue(@"ENABLE_HEALTH",YES) && !hasPlayedHealth) {
        AVPlayerItem *song = [AVPlayerItem playerItemWithURL:[audio URLForResource:@"yoga" withExtension:@"mp3"]];
        if (!hasPlayedHealth) {
            songLooper = [[AVPlayerLooper alloc] initWithPlayer:songPlayer templateItem:song timeRange:kCMTimeRangeInvalid];
            songPlayer.volume = 0.3;
            [songPlayer play];
            hasPlayedHealth = YES;
        }
     }

     if([SparkAppList doesIdentifier:@"com.jacc.wiiprefs" andKey:@"friendsApp" containBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] && PreferencesValue(@"ENABLE_FMF",YES) && !hasPlayedFMF) {
        AVPlayerItem *song = [AVPlayerItem playerItemWithURL:[audio URLForResource:@"checkmii" withExtension:@"mp3"]];
        if (!hasPlayedFMF) {
            songLooper = [[AVPlayerLooper alloc] initWithPlayer:songPlayer templateItem:song timeRange:kCMTimeRangeInvalid];
            songPlayer.volume = 0.3;
            [songPlayer play];
            hasPlayedFMF = YES;
        }
     }

     /* this plays in every app, fix later
     if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.springboard"] && PreferencesValue(@"ENABLE_MENU",YES) && !hasPlayedHomeScreen) {
        [self playSong:@"mainmenu" restartTime:CMTimeMake(20, 1)];
        hasPlayedHomeScreen = YES;
     } */

}
%new
- (void)playSong:(NSString *)songName restartTime:(CMTime)time {
    DEBUGLOG(@"###Wiivamp: Playing audio: %@", songName);
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
                                                        DEBUGLOG(@"###Wiivamp: %@ did enter background!", [[NSBundle mainBundle] bundleIdentifier]);
                                                        [songPlayer pause];
                                                    }];

    [noteCenter addObserverForName:UIApplicationWillEnterForegroundNotification 
                                                    object:nil
                                                    queue:nil 
                                                    usingBlock:^(NSNotification *note) {
                                                        DEBUGLOG(@"###Wiivamp: %@ did enter foreground!", [[NSBundle mainBundle] bundleIdentifier]);
                                                        usleep(1000000);
                                                        [songPlayer play];
                                                    }];

    [noteCenter addObserverForName:UIApplicationWillTerminateNotification 
                                                    object:nil
                                                    queue:nil 
                                                    usingBlock:^(NSNotification *note) {
                                                        [songPlayer release];
                                                        DEBUGLOG(@"###Wiivamp: Released from %@!", [[NSBundle mainBundle] bundleIdentifier]);
                                                    }];
                                                    
    songPlayer.volume = 0.3;
    usleep(1000000);
    [songPlayer play];
}
%end
%ctor
{
    preferences = [[NSDictionary alloc] initWithContentsOfFile:SETTINGS_PLIST_PATH];

    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)PreferencesChangedCallback, CFSTR("com.jacc.wiiprefs-reload"), NULL, CFNotificationSuspensionBehaviorCoalesce);
}
