#import "Wiivamp.h"

NSBundle *audio = [NSBundle bundleWithPath:@"/Library/Wiivamp/"]; // Location Of The Songs

%group Wiivamp
    // Play Songs In Selected Apps
%hook UIViewController

-(void)viewWillAppear:(BOOL)arg1 {

    %orig;
    
    if ([SparkAppList doesIdentifier:@"com.jacc.wiiprefs" andKey:@"storeApp" containBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] && ENABLE_APPSTORESwitch && !hasPlayedApp) {
        [self playSong:@"shop" restartTime:CMTimeMake(7, 1)];
        hasPlayedApp = YES;

    }

     if ([SparkAppList doesIdentifier:@"com.jacc.wiiprefs" andKey:@"weatherApp" containBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] && ENABLE_WEATHERSwitch && !hasPlayedWeather) {
         [self playSong:@"wcm" restartTime:CMTimeMake(7, 1)];
         hasPlayedWeather = YES;

     }

     if ([SparkAppList doesIdentifier:@"com.jacc.wiiprefs" andKey:@"homebrewApp" containBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] && ENABLE_CYDIASwitch && !hasPlayedCydia) {
        [self playSong:@"hbc" restartTime:CMTimeMake(8, 1)];
        hasPlayedCydia = YES;

     }

     if ([SparkAppList doesIdentifier:@"com.jacc.wiiprefs" andKey:@"photoApp" containBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] && ENABLE_PHOTOSSwitch && !hasPlayedPhotos) {
        [self playSong:@"photos" restartTime:CMTimeMake(10, 1)];
        hasPlayedPhotos = YES;

     }

     if ([SparkAppList doesIdentifier:@"com.jacc.wiiprefs" andKey:@"newsApp" containBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] && ENABLE_NEWSSwitch && !hasPlayedNews) {
         [self playSong:@"news" restartTime:CMTimeMake(11, 1)];
         hasPlayedNews = YES;

     }

     if ([SparkAppList doesIdentifier:@"com.jacc.wiiprefs" andKey:@"contactApp" containBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] && ENABLE_CONTACTSSwitch && !hasPlayedContacts) {
         [self playSong:@"mii" restartTime:CMTimeMake(12, 1)];
         hasPlayedContacts = YES;

     }

     if ([SparkAppList doesIdentifier:@"com.jacc.wiiprefs" andKey:@"healthApp" containBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] && ENABLE_HEALTHSwitch && !hasPlayedHealth) {
         [self playSong:@"yoga" restartTime:CMTimeMake(13, 1)];
         hasPlayedHealth = YES;

     }

     if ([SparkAppList doesIdentifier:@"com.jacc.wiiprefs" andKey:@"friendsApp" containBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] && ENABLE_FMFSwitch && !hasPlayedFMF) {
         [self playSong:@"checkmii" restartTime:CMTimeMake(14, 1)];
         hasPlayedFMF = YES;

     }

}
    // Method To Play And Pause The Songs
%new
- (void)playSong:(NSString *)songName restartTime:(CMTime)time {

    double volume = [volumeLevel doubleValue]; // Get The Volume From The Slider

    if (allowMusicSwitch) {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:NULL];

    }
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
                                                    
    if (customVolumeSwitch) { // Use Custom Volume If The Switch Is Selected
        songPlayer.volume = volume;

    } else {
        songPlayer.volume = 0.3;

    }
    usleep(1000000);
    [songPlayer play];

}

%end
    // Main Menu Theme, Works Only On iOS 13 Because The Two Methods Which Are Used Don't Exist On iOS >=12
%hook SBIconController

double currentAudioPosition;

- (void)viewWillAppear:(BOOL)arg1 { // When The HomeScreen Appears Play The Main Menu Theme And Or The Beginning Of It
    
    %orig;

    if (!(SYSTEM_VERSION_LESS_THAN(@"13.0"))) { // Make Sure This Code Does Not Run On iOS 12 Or Lower To Prevent Bugs
        double volume = [volumeLevel doubleValue]; // Get The Volume From The Slider

        if (allowMusicSwitch) { // Allow Music To Play While Wiivamp Plays, Only If The Switch Is Enabled
                [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:NULL];

        }
        
        if (beginningSoundSwitch && !hasPlayedBeginning) {
            songPlayer3 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:@"/Library/Wiivamp/beginningWiiMenu.m4a"] error:nil];
            songPlayer3.numberOfLoops = 0;
            [songPlayer3 play];

            if (beginningSoundOnlyOnceSwitch) {
                hasPlayedBeginning = YES;

            }

        }

        if (mainMenuMusicSwitch) {
            songPlayer2 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:@"/Library/Wiivamp/mainmenu.m4a"] error:nil];
            
            songPlayer2.numberOfLoops = 999;
            if (!hasPlayedHomeScreen) {
                [songPlayer2 play];
                hasPlayedHomeScreen = YES;

            } else {
                [songPlayer2 playAtTime: currentAudioPosition];

            }

            if (customVolumeSwitch) { // Use Custom Volume If The Switch Is Selected
                songPlayer2.volume = volume;
                songPlayer3.volume = volume;

            } else {
                songPlayer2.volume = 0.3;
                songPlayer3.volume = 0.3;

            }

        }
        
	}

}
    // Stop The Music When Leaving HomeScreen
- (void)viewWillDisappear:(BOOL)arg1 {

    %orig;
    if (mainMenuMusicSwitch) {
        currentAudioPosition = songPlayer2.deviceCurrentTime;
        [songPlayer2 pause];
        [songPlayer3 stop];

    }

}

%end

%hook SBCoverSheetPrimarySlidingViewController // Only iOS 12 To Prevent Bugs And To Add Compatibility

- (void)viewWillDisappear:(BOOL)arg1 {

    %orig;
    if (SYSTEM_VERSION_LESS_THAN(@"13.0")) { // Make Sure This Code Only Runs On iOS 12 Or Lower To Prevent Bugs
        double volume = [volumeLevel doubleValue]; // Get The Volume From The Slider

        if (allowMusicSwitch) { // Allow Music To Play While Wiivamp Plays, Only If The Switch Is Enabled
            [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:NULL];

        }

        if (customVolumeSwitch) { // Use Custom Volume If The Switch Is Selected
            songPlayer3.volume = volume;

            } else {
                songPlayer3.volume = 0.3;

            }

        if (beginningSoundSwitch && !hasPlayedBeginning) {
            songPlayer3 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:@"/Library/Wiivamp/beginningWiiMenu.m4a"] error:nil];
            songPlayer3.numberOfLoops = 0;
            [songPlayer3 play];

            if (beginningSoundOnlyOnceSwitch) {
                hasPlayedBeginning = YES;

            }

        }

    }

}

%end

%hook SBFolderView

- (void)scrollViewWillBeginDragging:(id)arg1 {

	%orig;
    if (pageScrollSoundSwitch && !dontUsePlayerForSwipeSwitch) {
        songPlayer3 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:@"/Library/Wiivamp/pageScroll.m4a"] error:nil];
        songPlayer3.numberOfLoops = 0;
        [songPlayer3 play];

    } else if (pageScrollSoundSwitch && dontUsePlayerForSwipeSwitch) {
        SystemSoundID sound = 0;
        AudioServicesDisposeSystemSoundID(sound);
        AudioServicesCreateSystemSoundID((CFURLRef) CFBridgingRetain([NSURL fileURLWithPath:@"/Library/Wiivamp/pageScroll.m4a"]), &sound);
        AudioServicesPlaySystemSound((SystemSoundID)sound);

    }

}

%end

%end

%group WiivampIntegrityFail

%hook SBCoverSheetPrimarySlidingViewController

- (void)viewDidAppear:(BOOL)arg1 {

    %orig; //  Thanks to Nepeta for the DRM
    if (!dpkgInvalid) return;
		UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Wiivamp"
		message:@"Seriously? Pirating a free Tweak is awful!\nPiracy repo's Tweaks could contain Malware if you didn't know that, so go ahead and get Wiivamp from the official Source https://repo.dynastic.co/.\nIf you're seeing this but you got it from the official source then make sure to add https://repo.dynastic.co to Cydia or Sileo."
		preferredStyle:UIAlertControllerStyleAlert];

		UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Aww man" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {

			UIApplication *application = [UIApplication sharedApplication];
			[application openURL:[NSURL URLWithString:@"https://repo.dynastic.co/"] options:@{} completionHandler:nil];

	}];

		[alertController addAction:cancelAction];

		[self presentViewController:alertController animated:YES completion:nil];

}

%end

%end

%ctor {

    if (![NSProcessInfo processInfo]) return;
    NSString *processName = [NSProcessInfo processInfo].processName;
    bool isSpringboard = [@"SpringBoard" isEqualToString:processName];

    // Someone smarter than Nepeta invented this.
    // https://www.reddit.com/r/jailbreak/comments/4yz5v5/questionremote_messages_not_enabling/d6rlh88/
    bool shouldLoad = NO;
    NSArray *args = [[NSClassFromString(@"NSProcessInfo") processInfo] arguments];
    NSUInteger count = args.count;
    if (count != 0) {
        NSString *executablePath = args[0];
        if (executablePath) {
            NSString *processName = [executablePath lastPathComponent];
            BOOL isApplication = [executablePath rangeOfString:@"/Application/"].location != NSNotFound || [executablePath rangeOfString:@"/Applications/"].location != NSNotFound;
            BOOL isFileProvider = [[processName lowercaseString] rangeOfString:@"fileprovider"].location != NSNotFound;
            BOOL skip = [processName isEqualToString:@"AdSheet"]
                        || [processName isEqualToString:@"CoreAuthUI"]
                        || [processName isEqualToString:@"InCallService"]
                        || [processName isEqualToString:@"MessagesNotificationViewService"]
                        || [executablePath rangeOfString:@".appex/"].location != NSNotFound;
            if ((!isFileProvider && isApplication && !skip) || isSpringboard) {
                shouldLoad = YES;
            }
        }
    }

    if (!shouldLoad) return;

    // Thanks To Nepeta For The DRM
    dpkgInvalid = ![[NSFileManager defaultManager] fileExistsAtPath:@"/var/lib/dpkg/info/com.jacc.wiivamp.list"];

    if (!dpkgInvalid) dpkgInvalid = ![[NSFileManager defaultManager] fileExistsAtPath:@"/var/lib/dpkg/info/com.jacc.wiivamp.md5sums"];

    if (dpkgInvalid) {
        %init(WiivampIntegrityFail);
        return;
    }

    pfs = [[HBPreferences alloc] initWithIdentifier:@"com.jacc.wiiprefs"];
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
    // Allow Music While Wiivamp Plays Audio
    [pfs registerBool:&allowMusicSwitch default:YES forKey:@"allowMusic"];
    // Other Sounds
    [pfs registerBool:&beginningSoundSwitch default:YES forKey:@"beginningSound"];
    [pfs registerBool:&beginningSoundOnlyOnceSwitch default:YES forKey:@"beginningSoundOnlyOnce"];
    [pfs registerBool:&pageScrollSoundSwitch default:YES forKey:@"pageScrollSound"];
    [pfs registerBool:&dontUsePlayerForSwipeSwitch default:NO forKey:@"dontUsePlayerForSwipe"];
    // Custom Volume
    [pfs registerBool:&customVolumeSwitch default:NO forKey:@"customVolume"];
    [pfs registerObject:&volumeLevel default:@"0.3" forKey:@"Volume"];

	if (!dpkgInvalid && enabled) {
        BOOL ok = false;
        
        ok = ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/var/lib/dpkg/info/%@%@%@%@%@%@%@%@.wiivamp.md5sums", @"c", @"o", @"m", @".", @"j", @"a", @"c", @"c"]]
        );

        if (ok && [@"jacc" isEqualToString:@"jacc"]) {
            %init(Wiivamp);
            return;
        } else {
            dpkgInvalid = YES;
        }
    }
}