#include "XXXRootListController.h"
#import <spawn.h>
#import <SparkAppListTableViewController.h>
#import <CepheiPrefs/HBAppearanceSettings.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation XXXRootListController
+ (NSString *)hb_specifierPlist {
	return @"Root";
}

- (instancetype)init {
	self = [super init];

	if (self) {
		HBAppearanceSettings *appearance = [[HBAppearanceSettings alloc] init];
		appearance.tintColor = UIColorFromRGB(0x5DBCD2);
        appearance.tableViewCellTextColor = UIColorFromRGB(0x0000000);
		self.hb_appearanceSettings = appearance;
	}

	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *respringButton = [[UIBarButtonItem alloc]  initWithTitle:@"Apply" style:UIBarButtonItemStylePlain target:self action:@selector(RespringMe)];
		[respringButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: UIColorFromRGB(0x5DBCD2),  NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    [self.navigationItem setRightBarButtonItem:respringButton];

		//self.navigationController.navigationController.navigationBar.tintColor = UIColorFromRGB(0x00B6EC);
}

-(void)selectStoreApps{
    // Replace "com.spark.notchlessprefs" and "excludedApps" with your strings
    SparkAppListTableViewController* s = [[SparkAppListTableViewController alloc] initWithIdentifier:@"com.jacc.wiiprefs" andKey:@"storeApp"];

    [self.navigationController pushViewController:s animated:YES];
    self.navigationItem.hidesBackButton = FALSE;
}

-(void)selectHomeBrewApps{
    // Replace "com.spark.notchlessprefs" and "excludedApps" with your strings
    SparkAppListTableViewController* s = [[SparkAppListTableViewController alloc] initWithIdentifier:@"com.jacc.wiiprefs" andKey:@"homebrewApp"];

    [self.navigationController pushViewController:s animated:YES];
    self.navigationItem.hidesBackButton = FALSE;
}
-(void)selectWeatherApps{
    // Replace "com.spark.notchlessprefs" and "excludedApps" with your strings
    SparkAppListTableViewController* s = [[SparkAppListTableViewController alloc] initWithIdentifier:@"com.jacc.wiiprefs" andKey:@"weatherApp"];

    [self.navigationController pushViewController:s animated:YES];
    self.navigationItem.hidesBackButton = FALSE;
}
-(void)selectPhotoApps{
    // Replace "com.spark.notchlessprefs" and "excludedApps" with your strings
    SparkAppListTableViewController* s = [[SparkAppListTableViewController alloc] initWithIdentifier:@"com.jacc.wiiprefs" andKey:@"photoApp"];

    [self.navigationController pushViewController:s animated:YES];
    self.navigationItem.hidesBackButton = FALSE;
}
-(void)selectNewsApps{
    // Replace "com.spark.notchlessprefs" and "excludedApps" with your strings
    SparkAppListTableViewController* s = [[SparkAppListTableViewController alloc] initWithIdentifier:@"com.jacc.wiiprefs" andKey:@"newsApp"];

    [self.navigationController pushViewController:s animated:YES];
    self.navigationItem.hidesBackButton = FALSE;
}
-(void)selectContactApps{
    // Replace "com.spark.notchlessprefs" and "excludedApps" with your strings
    SparkAppListTableViewController* s = [[SparkAppListTableViewController alloc] initWithIdentifier:@"com.jacc.wiiprefs" andKey:@"contactApp"];

    [self.navigationController pushViewController:s animated:YES];
    self.navigationItem.hidesBackButton = FALSE;
}
-(void)selectHealthApps{
    // Replace "com.spark.notchlessprefs" and "excludedApps" with your strings
    SparkAppListTableViewController* s = [[SparkAppListTableViewController alloc] initWithIdentifier:@"com.jacc.wiiprefs" andKey:@"healthApp"];

    [self.navigationController pushViewController:s animated:YES];
    self.navigationItem.hidesBackButton = FALSE;
}
-(void)selectFriendsApps{
    // Replace "com.spark.notchlessprefs" and "excludedApps" with your strings
    SparkAppListTableViewController* s = [[SparkAppListTableViewController alloc] initWithIdentifier:@"com.jacc.wiiprefs" andKey:@"friendsApp"];

    [self.navigationController pushViewController:s animated:YES];
    self.navigationItem.hidesBackButton = FALSE;
}


- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}

- (void)ContactMidTwitter {
		NSURL *url = [NSURL URLWithString:@"https://twitter.com/MidnightChip"];
		[[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
}

- (void)ContactmeReddMidnight {
	NSURL *url = [NSURL URLWithString:@"https://www.reddit.com/user/midnightchips"];
	[[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
}
- (void)ContactmeReddClarke {
	NSURL *url = [NSURL URLWithString:@"https://www.reddit.com/user/clarke12342003"];
	[[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
}
- (void)ContactmeTwitterJac {
	NSURL *url = [NSURL URLWithString:@"https://twitter.com/jvcks0n"];
	[[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
}
- (void)ContactmeReddJac {
	NSURL *url = [NSURL URLWithString:@"https://www.reddit.com/user/iJaacks"];
	[[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
}


- (void)RespringMe {
	pid_t pid;
	int status;
	const char* args[] = {"killall", "-9", "backboardd", NULL};
	posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
	waitpid(pid, &status, WEXITED);
}
@end
