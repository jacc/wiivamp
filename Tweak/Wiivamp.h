#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <SparkAppList.h>
#import <Cephei/HBPreferences.h>
#import <AudioToolbox/AudioServices.h>

// Utils
HBPreferences *pfs;

// Thanks to Nepeta for the DRM
BOOL dpkgInvalid = NO;

// Enabled Switch
BOOL enabled = YES;
// Option Switches
BOOL ENABLE_APPSTORESwitch = YES;
BOOL ENABLE_CYDIASwitch = YES;
BOOL ENABLE_WEATHERSwitch = YES;
BOOL ENABLE_PHOTOSSwitch = YES;
BOOL ENABLE_NEWSSwitch = YES;
BOOL ENABLE_CONTACTSSwitch = YES;
BOOL ENABLE_HEALTHSwitch = YES;
BOOL ENABLE_FMFSwitch = YES;
BOOL mainMenuMusicSwitch = YES;

// Audio Players
AVPlayer* songPlayer;
AVPlayerLooper* songLooper;
AVAudioPlayer *songPlayer2;
// Custom volume
BOOL customVolumeSwitch = NO;
NSString* volumeLevel = @"0.3";

BOOL hasPlayedApp = NO;
BOOL hasPlayedWeather = NO;
BOOL hasPlayedCydia = NO;
BOOL hasPlayedNews = NO;
BOOL hasPlayedPhotos = NO;
BOOL hasPlayedContacts = NO;
BOOL hasPlayedHealth = NO;
BOOL hasPlayedFMF = NO;
BOOL hasPlayedHomeScreen = NO;

// Interfaces
@interface UIViewController (Wiivamp)
- (void)viewWillAppear:(BOOL)arg1;
- (void)playSong:(NSString *)songName restartTime:(CMTime)time;
@end

@interface SBIconController : UIViewController
- (void)viewWillAppear:(BOOL)arg1;
- (void)viewWillDisappear:(BOOL)arg1;
@end