// My social media:
// Twitter: twitter.com/jvvks
// Github: github.com/jacc

@import Foundation;
@import UIKit;
@import AVFoundation;
#import <SparkAppList.h>

#define SETTINGS_PLIST_PATH @"/var/mobile/Library/Preferences/com.jacc.wiiprefs.plist"

AVQueuePlayer *songPlayer = [[AVQueuePlayer alloc] init];
AVPlayerLooper *songLooper;
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

    if([SparkAppList doesIdentifier:@"com.jacc.wiiprefs" andKey:@"storeApp" containBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] && PreferencesValue(@"ENABLE_APPSTORE",YES)) {
        AVPlayerItem *song = [AVPlayerItem playerItemWithURL:[audio URLForResource:@"store" withExtension:@"mp3"]];
        if (!hasPlayedApp) {
            songLooper = [[AVPlayerLooper alloc] initWithPlayer:songPlayer templateItem:song timeRange:kCMTimeRangeInvalid];
            songPlayer.volume = 0.3;
            [songPlayer play];
            hasPlayedApp = YES;
        }
    }

     if([SparkAppList doesIdentifier:@"com.jacc.wiiprefs" andKey:@"weatherApp" containBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] && PreferencesValue(@"ENABLE_WEATHER",YES)) {
         AVPlayerItem *song = [AVPlayerItem playerItemWithURL:[audio URLForResource:@"wcm" withExtension:@"mp3"]];
        if (!hasPlayedWeather) {
            songLooper = [[AVPlayerLooper alloc] initWithPlayer:songPlayer templateItem:song timeRange:kCMTimeRangeInvalid];
            songPlayer.volume = 0.3;
            [songPlayer play];
            hasPlayedWeather = YES;
        }
     }

     if([SparkAppList doesIdentifier:@"com.jacc.wiiprefs" andKey:@"homebrewApp" containBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] && PreferencesValue(@"ENABLE_CYDIA",YES)) {
         AVPlayerItem *song = [AVPlayerItem playerItemWithURL:[audio URLForResource:@"hbc" withExtension:@"mp3"]];
        if (!hasPlayedCydia) {
            songLooper = [[AVPlayerLooper alloc] initWithPlayer:songPlayer templateItem:song timeRange:kCMTimeRangeInvalid];
            songPlayer.volume = 0.3;
            [songPlayer play];
            hasPlayedCydia = YES;
        }
     }

     if([SparkAppList doesIdentifier:@"com.jacc.wiiprefs" andKey:@"photoApp" containBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] && PreferencesValue(@"ENABLE_PHOTOS",YES)) {
        AVPlayerItem *song = [AVPlayerItem playerItemWithURL:[audio URLForResource:@"photo" withExtension:@"mp3"]];
        if (!hasPlayedPhotos) {
            songLooper = [[AVPlayerLooper alloc] initWithPlayer:songPlayer templateItem:song timeRange:kCMTimeRangeInvalid];
            songPlayer.volume = 0.3;
            [songPlayer play];
            hasPlayedPhotos = YES;
        }
     }

     if([SparkAppList doesIdentifier:@"com.jacc.wiiprefs" andKey:@"newsApp" containBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] && PreferencesValue(@"ENABLE_NEWS",YES)) {
         AVPlayerItem *song = [AVPlayerItem playerItemWithURL:[audio URLForResource:@"news" withExtension:@"mp3"]];
        if (!hasPlayedNews) {
            songLooper = [[AVPlayerLooper alloc] initWithPlayer:songPlayer templateItem:song timeRange:kCMTimeRangeInvalid];
            songPlayer.volume = 0.3;
            [songPlayer play];
            hasPlayedNews = YES;
        }
     }

     if([SparkAppList doesIdentifier:@"com.jacc.wiiprefs" andKey:@"contactApp" containBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] && PreferencesValue(@"ENABLE_CONTACTS",YES)) {
        AVPlayerItem *song = [AVPlayerItem playerItemWithURL:[audio URLForResource:@"mii" withExtension:@"mp3"]];
        if (!hasPlayedContacts) {
            songLooper = [[AVPlayerLooper alloc] initWithPlayer:songPlayer templateItem:song timeRange:kCMTimeRangeInvalid];
            songPlayer.volume = 0.3;
            [songPlayer play];
            hasPlayedContacts = YES;
        }
     }

     if([SparkAppList doesIdentifier:@"com.jacc.wiiprefs" andKey:@"healthApp" containBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] && PreferencesValue(@"ENABLE_HEALTH",YES)) {
        AVPlayerItem *song = [AVPlayerItem playerItemWithURL:[audio URLForResource:@"yoga" withExtension:@"mp3"]];
        if (!hasPlayedHealth) {
            songLooper = [[AVPlayerLooper alloc] initWithPlayer:songPlayer templateItem:song timeRange:kCMTimeRangeInvalid];
            songPlayer.volume = 0.3;
            [songPlayer play];
            hasPlayedHealth = YES;
        }
     }

     if([SparkAppList doesIdentifier:@"com.jacc.wiiprefs" andKey:@"friendsApp" containBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] && PreferencesValue(@"ENABLE_FMF",YES)) {
        AVPlayerItem *song = [AVPlayerItem playerItemWithURL:[audio URLForResource:@"checkmii" withExtension:@"mp3"]];
        if (!hasPlayedFMF) {
            songLooper = [[AVPlayerLooper alloc] initWithPlayer:songPlayer templateItem:song timeRange:kCMTimeRangeInvalid];
            songPlayer.volume = 0.3;
            [songPlayer play];
            hasPlayedFMF = YES;
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

}
%end



%ctor
{
    preferences = [[NSDictionary alloc] initWithContentsOfFile:SETTINGS_PLIST_PATH];

    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)PreferencesChangedCallback, CFSTR("com.muirey03.wiiprefs-reload"), NULL, CFNotificationSuspensionBehaviorCoalesce);
}
