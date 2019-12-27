#import "Wiivamp.h"

NSBundle *audio = [NSBundle bundleWithPath:@"/Library/Wiivamp/"];

%group Wiivamp13

%hook UIViewController

- (void)viewDidAppear:(BOOL)arg1 {

    %orig;
    if ([SparkAppList doesIdentifier:@"me.shymemoriees.wiivamp13preferences" andKey:@"storeApp" containBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] && ENABLE_APPSTORESwitch && !hasPlayedApp) {
        [self playSong:@"shop" restartTime:CMTimeMake(7, 1)];
        hasPlayedApp = YES;

    }

     if ([SparkAppList doesIdentifier:@"me.shymemoriees.wiivamp13preferences" andKey:@"weatherApp" containBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] && ENABLE_WEATHERSwitch && !hasPlayedWeather) {
         AVPlayerItem *song = [AVPlayerItem playerItemWithURL:[audio URLForResource:@"wcm" withExtension:@"m4a"]];

        if (!hasPlayedWeather) {
            songLooper = [[AVPlayerLooper alloc] initWithPlayer:songPlayer templateItem:song timeRange:kCMTimeRangeInvalid];
            songPlayer.volume = 0.3;
            [songPlayer play];
            hasPlayedWeather = YES;

        }

     }

     if ([SparkAppList doesIdentifier:@"me.shymemoriees.wiivamp13preferences" andKey:@"homebrewApp" containBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] && ENABLE_CYDIASwitch && !hasPlayedCydia) {
        [self playSong:@"hbc" restartTime:CMTimeMake(8, 1)];
        hasPlayedCydia = YES;

     }

     if ([SparkAppList doesIdentifier:@"me.shymemoriees.wiivamp13preferences" andKey:@"photoApp" containBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] && ENABLE_PHOTOSSwitch && !hasPlayedPhotos) {
        [self playSong:@"photos" restartTime:CMTimeMake(10, 1)];
        hasPlayedPhotos = YES;

     }

     if ([SparkAppList doesIdentifier:@"me.shymemoriees.wiivamp13preferences" andKey:@"newsApp" containBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] && ENABLE_NEWSSwitch && !hasPlayedNews) {
         AVPlayerItem *song = [AVPlayerItem playerItemWithURL:[audio URLForResource:@"news" withExtension:@"m4a"]];

        if (!hasPlayedNews) {
            songLooper = [[AVPlayerLooper alloc] initWithPlayer:songPlayer templateItem:song timeRange:kCMTimeRangeInvalid];
            songPlayer.volume = 0.3;
            [songPlayer play];
            hasPlayedNews = YES;

        }

     }

     if ([SparkAppList doesIdentifier:@"me.shymemoriees.wiivamp13preferences" andKey:@"contactApp" containBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] && ENABLE_CONTACTSSwitch && !hasPlayedContacts) {
        AVPlayerItem *song = [AVPlayerItem playerItemWithURL:[audio URLForResource:@"mii" withExtension:@"m4a"]];

        if (!hasPlayedContacts) {
            songLooper = [[AVPlayerLooper alloc] initWithPlayer:songPlayer templateItem:song timeRange:kCMTimeRangeInvalid];
            songPlayer.volume = 0.3;
            [songPlayer play];
            hasPlayedContacts = YES;

        }

     }

     if ([SparkAppList doesIdentifier:@"me.shymemoriees.wiivamp13preferences" andKey:@"healthApp" containBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] && ENABLE_HEALTHSwitch && !hasPlayedHealth) {
        AVPlayerItem *song = [AVPlayerItem playerItemWithURL:[audio URLForResource:@"yoga" withExtension:@"m4a"]];

        if (!hasPlayedHealth) {
            songLooper = [[AVPlayerLooper alloc] initWithPlayer:songPlayer templateItem:song timeRange:kCMTimeRangeInvalid];
            songPlayer.volume = 0.3;
            [songPlayer play];
            hasPlayedHealth = YES;

        }

     }

     if ([SparkAppList doesIdentifier:@"me.shymemoriees.wiivamp13preferences" andKey:@"friendsApp" containBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] && ENABLE_FMFSwitch && !hasPlayedFMF) {
        AVPlayerItem *song = [AVPlayerItem playerItemWithURL:[audio URLForResource:@"checkmii" withExtension:@"m4a"]];

        if (!hasPlayedFMF) {
            songLooper = [[AVPlayerLooper alloc] initWithPlayer:songPlayer templateItem:song timeRange:kCMTimeRangeInvalid];
            songPlayer.volume = 0.3;
            [songPlayer play];
            hasPlayedFMF = YES;

        }

     }

     if ([SparkAppList doesIdentifier:@"me.shymemoriees.wiivamp13preferences" andKey:@"mainMenu" containBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] && ENABLE_FMFSwitch && !hasPlayedFMF) {
        AVPlayerItem *song = [AVPlayerItem playerItemWithURL:[audio URLForResource:@"checkmii" withExtension:@"m4a"]];

        if (!hasPlayedFMF) {
            songLooper = [[AVPlayerLooper alloc] initWithPlayer:songPlayer templateItem:song timeRange:kCMTimeRangeInvalid];
            songPlayer.volume = 0.3;
            [songPlayer play];
            hasPlayedFMF = YES;

        }

     }

}

%new
- (void)playSong:(NSString *)songName restartTime:(CMTime)time {

    AVPlayerItem *song = [AVPlayerItem playerItemWithURL:[audio URLForResource:songName withExtension:@"m4a"]];
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
    [songPlayer pause];

    }];

    [noteCenter addObserverForName:UIApplicationWillEnterForegroundNotification 
    object:nil
    queue:nil 
    usingBlock:^(NSNotification *note) {
    usleep(1000000);
    [songPlayer play];
    }];

    [noteCenter addObserverForName:UIApplicationWillTerminateNotification 
    object:nil
    queue:nil 
    usingBlock:^(NSNotification *note) {
    [songPlayer release];

    }];
                                                    
    songPlayer.volume = 0.3;
    usleep(1000000);
    [songPlayer play];

}

%end

%hook SBIconController

double currentAudioPosition;

- (void)viewWillAppear:(BOOL)arg1 {

    %orig;
    if (mainMenuMusicSwitch) {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:NULL];
        songPlayer2 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:@"/Library/Wiivamp/mainmenu.mp3"] error:nil];
        
        double volume = [volumeLevel doubleValue];
        if (customVolumeSwitch) {
            songPlayer2.volume = volume;

        } else {
            songPlayer2.volume = 0.3;

        }
        
        songPlayer2.numberOfLoops = 999;
        if (!hasPlayedHomeScreen) {
            [songPlayer2 play];
            hasPlayedHomeScreen = YES;

        } else {
            [songPlayer2 playAtTime: currentAudioPosition];

        }

    }

}

- (void)viewWillDisappear:(BOOL)arg1 {

    %orig;
    if (mainMenuMusicSwitch) {
        currentAudioPosition = songPlayer2.deviceCurrentTime;
        [songPlayer2 pause];

    }

}

%end

%end

%group Wiivamp13IntegrityFail

%hook SBCoverSheetPrimarySlidingViewController

- (void)viewDidDisappear:(BOOL)arg1 {

    %orig; //  Thanks to Nepeta for the DRM
    if (!dpkgInvalid) return;
		UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Wiivamp13"
		message:@"Seriously? Pirating a free Tweak is awful!\nPiracy repo's Tweaks could contain Malware if you didn't know that, so go ahead and get Wiivamp13 from the official Source https://repo.shymemoriees.me/.\nIf you're seeing this but you got it from the official source then make sure to add https://repo.shymemoriees.me to Cydia or Sileo."
		preferredStyle:UIAlertControllerStyleAlert];

		UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Aww man" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {

			UIApplication *application = [UIApplication sharedApplication];
			[application openURL:[NSURL URLWithString:@"https://repo.shymemoriees.me/"] options:@{} completionHandler:nil];

	}];

		[alertController addAction:cancelAction];

		[self presentViewController:alertController animated:YES completion:nil];

}

%end

%end

%ctor {
    // Thanks To Nepeta For The DRM
    dpkgInvalid = ![[NSFileManager defaultManager] fileExistsAtPath:@"/var/lib/dpkg/info/me.shymemoriees.wiivamp13.list"];

    if (!dpkgInvalid) dpkgInvalid = ![[NSFileManager defaultManager] fileExistsAtPath:@"/var/lib/dpkg/info/me.shymemoriees.wiivamp13.md5sums"];

    if (dpkgInvalid) {
        %init(Wiivamp13IntegrityFail);
        return;
    }

    pfs = [[HBPreferences alloc] initWithIdentifier:@"me.shymemoriees.wiivamp13preferences"];
    // Enabled Switch
    [pfs registerBool:&enabled default:YES forKey:@"Enabled"];
    // Option Switches
    [pfs registerBool:&ENABLE_APPSTORESwitch default:YES forKey:@"ENABLE_APPSTORE"];
    [pfs registerBool:&ENABLE_CYDIASwitch default:YES forKey:@"ENABLE_CYDIA"];
    [pfs registerBool:&ENABLE_WEATHERSwitch default:YES forKey:@"ENABLE_WEATHER"];
    [pfs registerBool:&ENABLE_PHOTOSSwitch default:YES forKey:@"ENABLE_PHOTOS"];
    [pfs registerBool:&ENABLE_NEWSSwitch default:YES forKey:@"ENABLE_NEWS"];
    [pfs registerBool:&ENABLE_CONTACTSSwitch default:YES forKey:@"ENABLE_CONTACTS"];
    [pfs registerBool:&ENABLE_HEALTHSwitch default:YES forKey:@"ENABLE_HEALTH"];
    [pfs registerBool:&ENABLE_FMFSwitch default:YES forKey:@"ENABLE_FMF"];
    [pfs registerBool:&mainMenuMusicSwitch default:YES forKey:@"mainMenuMusic"];
    // Custom Volume
    [pfs registerBool:&customVolumeSwitch default:NO forKey:@"customVolume"];
    [pfs registerObject:&volumeLevel default:@"0.3" forKey:@"Volume"];

	if (!dpkgInvalid && enabled) {
        BOOL ok = false;
        
        ok = ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/var/lib/dpkg/info/%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@.wiivamp13.md5sums", @"m", @"e", @".", @"s", @"h", @"y", @"m", @"e", @"m", @"o", @"r", @"i", @"e", @"e", @"s"]]
        );

        if (ok && [@"shymemoriees" isEqualToString:@"shymemoriees"]) {
            %init(Wiivamp13);
            return;
        } else {
            dpkgInvalid = YES;
        }
    }
}