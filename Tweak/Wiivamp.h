#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <Cephei/HBPreferences.h>
#import <SparkAppList.h>

#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

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
BOOL beginningSoundSwitch = YES;
BOOL beginningSoundOnlyOnceSwitch = YES;
BOOL pageScrollSoundSwitch = YES;

BOOL allowMusicSwitch = YES;
BOOL dontUsePlayerForSwipeSwitch = NO;

// Music Players
AVPlayer* songPlayer;
AVPlayerLooper* songLooper;
// Main Menu Theme Player
AVAudioPlayer* songPlayer2;
// Player For Other Sounds
AVAudioPlayer* songPlayer3;
// Custom Volume
BOOL customVolumeSwitch = NO;
NSString* volumeLevel = @"0.3";

// To Prevent Bugs
BOOL hasPlayedApp = NO;
BOOL hasPlayedWeather = NO;
BOOL hasPlayedCydia = NO;
BOOL hasPlayedNews = NO;
BOOL hasPlayedPhotos = NO;
BOOL hasPlayedContacts = NO;
BOOL hasPlayedHealth = NO;
BOOL hasPlayedFMF = NO;
BOOL hasPlayedHomeScreen = NO;
BOOL hasPlayedBeginning = NO;

// Interfaces
@interface UIViewController (Wiivamp)
- (void)viewWillAppear:(BOOL)arg1;
- (void)playSong:(NSString *)songName restartTime:(CMTime)time;
@end

@interface SBIconController : UIViewController
- (void)viewWillAppear:(BOOL)arg1;
- (void)viewWillDisappear:(BOOL)arg1;
@end

@interface SBCoverSheetPrimarySlidingViewController : UIViewController
- (void)viewDidAppear:(BOOL)arg1;
- (void)viewDidDisppear:(BOOL)arg1;
@end