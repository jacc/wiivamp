// Shoutout MidnightChips for the amazing help on this <3
// My social media:
// Twitter: twitter.com/jvvks
// Github: github.com/jacc

@import Foundation;
@import UIKit;
@import AVFoundation;
#import <SparkAppList.h>

#define SETTINGS_PLIST_PATH @"/var/mobile/Library/Preferences/com.jacc.wiiprefs.plist"

BOOL hasPlayedApp = NO;
BOOL hasPlayedWeather = NO;
BOOL hasPlayedCydia = NO;
BOOL hasPlayedNews = NO;
BOOL hasPlayedPhotos = NO;
BOOL hasPlayedContacts = NO;
BOOL hasPlayedHealth = NO;
BOOL hasPlayedHomeScreen = NO;
BOOL hasPlayedFMF = NO;

static NSDictionary *preferences;

static BOOL PreferencesValue(NSString* key, BOOL fallback)
{
    return [preferences objectForKey:key] ? [[preferences objectForKey:key] boolValue] : fallback;
}

static void PreferencesChangedCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    [preferences release];
    CFStringRef appID = CFSTR("com.jacc.wiiprefs");
    CFArrayRef keyList = CFPreferencesCopyKeyList(appID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
    if (!keyList) {
        NSLog(@"There's been an error getting the key list!");
        return;
    }
    preferences = (NSDictionary *)CFPreferencesCopyMultiple(keyList, appID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
    if (!preferences) {
        NSLog(@"There's been an error getting the preferences dictionary!");
    }
    CFRelease(keyList);
}


%hook UIViewController
-(void)viewDidAppear:(BOOL)arg1 {
    %orig;
    //put something that could cause an error here
    NSString *app = @"/Library/Application Support/Wiivamp/store.mp3";
    NSURL *appURL = [NSURL fileURLWithPath:app]; //[[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.AppStore"]
    //NSString* bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    if([SparkAppList doesIdentifier:@"com.jacc.wiiprefs" andKey:@"storeApp" containBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] && PreferencesValue(@"ENABLE_APPSTORE",YES)) {
        if (!hasPlayedApp) {
            AVPlayer *songPlayer = [[AVPlayer alloc] initWithURL:appURL];
            songPlayer.volume = 0.3;
            [songPlayer play];
            hasPlayedApp = YES;
            songPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
            [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(playerItemDidReachEnd:)
                                               name:AVPlayerItemDidPlayToEndTimeNotification
                                             object:[songPlayer currentItem]];
        }
    }


    NSString *weather = @"/Library/Application Support/Wiivamp/wcm.mp3";
    NSURL *weatherURL = [NSURL fileURLWithPath:weather];
     if([SparkAppList doesIdentifier:@"com.jacc.wiiprefs" andKey:@"weatherApp" containBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] && PreferencesValue(@"ENABLE_WEATHER",YES)) {
         if (!hasPlayedWeather) {
             AVPlayer *songPlayer = [[AVPlayer alloc] initWithURL:weatherURL];
             songPlayer.volume = 0.3;
             [songPlayer play];
             hasPlayedWeather = YES;
             songPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
             [[NSNotificationCenter defaultCenter] addObserver:self
                                            selector:@selector(playerItemDidReachEnd:)
                                                name:AVPlayerItemDidPlayToEndTimeNotification
                                              object:[songPlayer currentItem]];
         }
     }
     NSString *cydia = @"/Library/Application Support/Wiivamp/hbc.mp3";
     NSURL *cydiaURL = [NSURL fileURLWithPath:cydia];
     if([SparkAppList doesIdentifier:@"com.jacc.wiiprefs" andKey:@"homebrewApp" containBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] && PreferencesValue(@"ENABLE_CYDIA",YES)) {
         if (!hasPlayedCydia) {
             AVPlayer *songPlayer = [[AVPlayer alloc] initWithURL:cydiaURL];
             songPlayer.volume = 0.3;
             [songPlayer play];
             hasPlayedCydia = YES;
             songPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
             [[NSNotificationCenter defaultCenter] addObserver:self
                                            selector:@selector(playerItemDidReachEnd:)
                                                name:AVPlayerItemDidPlayToEndTimeNotification
                                              object:[songPlayer currentItem]];
         }
     }
     NSString *photo = @"/Library/Application Support/Wiivamp/photo.mp3";
     NSURL *photoURL = [NSURL fileURLWithPath:photo];
     if([SparkAppList doesIdentifier:@"com.jacc.wiiprefs" andKey:@"photoApp" containBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] && PreferencesValue(@"ENABLE_PHOTOS",YES)) {
         if (!hasPlayedPhotos) {
             AVPlayer *songPlayer = [[AVPlayer alloc] initWithURL:photoURL];
             songPlayer.volume = 0.3;
             [songPlayer play];
             hasPlayedPhotos = YES;
             songPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
             [[NSNotificationCenter defaultCenter] addObserver:self
                                            selector:@selector(playerItemDidReachEnd:)
                                                name:AVPlayerItemDidPlayToEndTimeNotification
                                              object:[songPlayer currentItem]];

         }
     }
     NSString *news = @"/Library/Application Support/Wiivamp/news.mp3";
     NSURL *newsURL = [NSURL fileURLWithPath:news];
     if([SparkAppList doesIdentifier:@"com.jacc.wiiprefs" andKey:@"newsApp" containBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] && PreferencesValue(@"ENABLE_NEWS",YES)) {
         if (!hasPlayedNews) {
             AVPlayer *songPlayer = [[AVPlayer alloc] initWithURL:newsURL];
             songPlayer.volume = 0.3;
             [songPlayer play];
             hasPlayedNews = YES;
             songPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
             [[NSNotificationCenter defaultCenter] addObserver:self
                                            selector:@selector(playerItemDidReachEnd:)
                                                name:AVPlayerItemDidPlayToEndTimeNotification
                                              object:[songPlayer currentItem]];
         }
     }
     /* this plays in every app, fix later
     NSString *sb = @"/Library/Application Support/Wiivamp/menu.mp3";
     NSURL *sbURL = [NSURL fileURLWithPath:sb];
     if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.springboard"] && PreferencesValue(@"ENABLE_MENU",YES)) {
         if (!hasPlayedHomeScreen) {
             AVPlayer *songPlayer = [[AVPlayer alloc] initWithURL:sbURL];
             songPlayer.volume = 0.3;
             [songPlayer play];
             hasPlayedHomeScreen = YES;
             songPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
             [[NSNotificationCenter defaultCenter] addObserver:self
                                            selector:@selector(playerItemDidReachEnd:)
                                                name:AVPlayerItemDidPlayToEndTimeNotification
                                              object:[songPlayer currentItem]];
         }
     } */
     NSString *contacts = @"/Library/Application Support/Wiivamp/mii.mp3";
     NSURL *contactsURL = [NSURL fileURLWithPath:contacts];
     if([SparkAppList doesIdentifier:@"com.jacc.wiiprefs" andKey:@"contactApp" containBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] && PreferencesValue(@"ENABLE_CONTACTS",YES)) {
         if (!hasPlayedContacts) {
             AVPlayer *songPlayer = [[AVPlayer alloc] initWithURL:contactsURL];
             songPlayer.volume = 0.3;
             [songPlayer play];
             hasPlayedContacts = YES;
             songPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
             [[NSNotificationCenter defaultCenter] addObserver:self
                                            selector:@selector(playerItemDidReachEnd:)
                                                name:AVPlayerItemDidPlayToEndTimeNotification
                                              object:[songPlayer currentItem]];
         }
     }
     NSString *health = @"/Library/Application Support/Wiivamp/yoga.mp3";
     NSURL *healthURL = [NSURL fileURLWithPath:health];
     if([SparkAppList doesIdentifier:@"com.jacc.wiiprefs" andKey:@"healthApp" containBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] && PreferencesValue(@"ENABLE_HEALTH",YES)) {
         if (!hasPlayedHealth) {
             AVPlayer *songPlayer = [[AVPlayer alloc] initWithURL:healthURL];
             songPlayer.volume = 0.3;
             [songPlayer play];
             hasPlayedHealth = YES;
             songPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
             [[NSNotificationCenter defaultCenter] addObserver:self
                                            selector:@selector(playerItemDidReachEnd:)
                                                name:AVPlayerItemDidPlayToEndTimeNotification
                                              object:[songPlayer currentItem]];
         }
     }
     NSString *fmf = @"/Library/Application Support/Wiivamp/checkmii.mp3";
     NSURL *fmfURL = [NSURL fileURLWithPath:fmf];
     if([SparkAppList doesIdentifier:@"com.jacc.wiiprefs" andKey:@"friendsApp" containBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] && PreferencesValue(@"ENABLE_FMF",YES)) {
         if (!hasPlayedFMF) {
             AVPlayer *songPlayer = [[AVPlayer alloc] initWithURL:fmfURL];
             songPlayer.volume = 0.3;
             [songPlayer play];
             hasPlayedFMF = YES;
             songPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
             [[NSNotificationCenter defaultCenter] addObserver:self
                                            selector:@selector(playerItemDidReachEnd:)
                                                name:AVPlayerItemDidPlayToEndTimeNotification
                                              object:[songPlayer currentItem]];
         }
     }


}
%new
- (void)playerItemDidReachEnd:(NSNotification *)notification {
    AVPlayerItem *p = [notification object];
    [p seekToTime:kCMTimeZero completionHandler:nil];
}
%end



%ctor
{
    preferences = [[NSDictionary alloc] initWithContentsOfFile:SETTINGS_PLIST_PATH];

    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)PreferencesChangedCallback, CFSTR("com.muirey03.wiiprefs-reload"), NULL, CFNotificationSuspensionBehaviorCoalesce);
}
