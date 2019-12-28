#include "WIIRootListController.h"

@implementation WIIRootListController

- (instancetype)init {
    self = [super init];

    if (self) {
        WIIAppearanceSettings *appearanceSettings = [[WIIAppearanceSettings alloc] init];
        self.hb_appearanceSettings = appearanceSettings;
        self.respringButton = [[UIBarButtonItem alloc] initWithTitle:@"ReSpring"
                                    style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(respring)];
        self.respringButton.tintColor = [UIColor whiteColor];
        self.navigationItem.rightBarButtonItem = self.respringButton;

        self.navigationItem.titleView = [UIView new];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,10,10)];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.titleLabel.text = @"Wiivamp";
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.navigationItem.titleView addSubview:self.titleLabel];

        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,10,10)];
        self.iconView.contentMode = UIViewContentModeScaleAspectFit;
        self.iconView.image = [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/WiivampPrefs.bundle/icon@2x.png"];
        self.iconView.translatesAutoresizingMaskIntoConstraints = NO;
        self.iconView.alpha = 0.0;
        [self.navigationItem.titleView addSubview:self.iconView];

        [NSLayoutConstraint activateConstraints:@[
            [self.titleLabel.topAnchor constraintEqualToAnchor:self.navigationItem.titleView.topAnchor],
            [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.navigationItem.titleView.leadingAnchor],
            [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.navigationItem.titleView.trailingAnchor],
            [self.titleLabel.bottomAnchor constraintEqualToAnchor:self.navigationItem.titleView.bottomAnchor],
            [self.iconView.topAnchor constraintEqualToAnchor:self.navigationItem.titleView.topAnchor],
            [self.iconView.leadingAnchor constraintEqualToAnchor:self.navigationItem.titleView.leadingAnchor],
            [self.iconView.trailingAnchor constraintEqualToAnchor:self.navigationItem.titleView.trailingAnchor],
            [self.iconView.bottomAnchor constraintEqualToAnchor:self.navigationItem.titleView.bottomAnchor],
        ]];
    }

    return self;
}

-(NSArray *)specifiers {
	if (_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}

- (void)viewDidLoad {

	[super viewDidLoad];

    if (@available(iOS 11, *)) {
		self.navigationController.navigationBar.prefersLargeTitles = false;
		self.navigationController.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;
	}

    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,200,200)];
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,200,200)];
    self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.headerImageView.image = [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/WiivampPrefs.bundle/Banner.png"];
    self.headerImageView.translatesAutoresizingMaskIntoConstraints = NO;

    [self.headerView addSubview:self.headerImageView];
    [NSLayoutConstraint activateConstraints:@[
        [self.headerImageView.topAnchor constraintEqualToAnchor:self.headerView.topAnchor],
        [self.headerImageView.leadingAnchor constraintEqualToAnchor:self.headerView.leadingAnchor],
        [self.headerImageView.trailingAnchor constraintEqualToAnchor:self.headerView.trailingAnchor],
        [self.headerImageView.bottomAnchor constraintEqualToAnchor:self.headerView.bottomAnchor],
    ]];

    _table.tableHeaderView = self.headerView;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.tableHeaderView = self.headerView;
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    CGRect frame = self.table.bounds;
    frame.origin.y = -frame.size.height;

    self.navigationController.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.52 green:0.73 blue:0.93 alpha:1.0];
    [self.navigationController.navigationController.navigationBar setShadowImage: [UIImage new]];
    self.navigationController.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationController.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];

    if (@available(iOS 11, *)) {
		self.navigationController.navigationBar.prefersLargeTitles = false;
		self.navigationController.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;
	}

    [self.navigationController.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self.navigationController.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;

    if (offsetY > 200) {
        [UIView animateWithDuration:0.2 animations:^{
            self.iconView.alpha = 1.0;
            self.titleLabel.alpha = 0.0;
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            self.iconView.alpha = 0.0;
            self.titleLabel.alpha = 1.0;
        }];
    }

    if (offsetY > 0) offsetY = 0;
    self.headerImageView.frame = CGRectMake(0, offsetY, self.headerView.frame.size.width, 200 - offsetY);
}

- (void)selectStoreApps{

    SparkAppListTableViewController* SelectionController = [[SparkAppListTableViewController alloc] initWithIdentifier:@"com.jacc.wiiprefs" andKey:@"storeApp"];

    [self.navigationController pushViewController:SelectionController animated:YES];
    self.navigationItem.hidesBackButton = FALSE;

}

- (void)selectHomeBrewApps {

    SparkAppListTableViewController* SelectionController = [[SparkAppListTableViewController alloc] initWithIdentifier:@"com.jacc.wiiprefs" andKey:@"homebrewApp"];

    [self.navigationController pushViewController:SelectionController animated:YES];
    self.navigationItem.hidesBackButton = FALSE;

}

- (void)selectWeatherApps {

    SparkAppListTableViewController* SelectionController = [[SparkAppListTableViewController alloc] initWithIdentifier:@"com.jacc.wiiprefs" andKey:@"weatherApp"];

    [self.navigationController pushViewController:SelectionController animated:YES];
    self.navigationItem.hidesBackButton = FALSE;

}

- (void)selectPhotoApps {

    SparkAppListTableViewController* SelectionController = [[SparkAppListTableViewController alloc] initWithIdentifier:@"com.jacc.wiiprefs" andKey:@"photoApp"];

    [self.navigationController pushViewController:SelectionController animated:YES];
    self.navigationItem.hidesBackButton = FALSE;

}

- (void)selectNewsApps {

    SparkAppListTableViewController* SelectionController = [[SparkAppListTableViewController alloc] initWithIdentifier:@"com.jacc.wiiprefs" andKey:@"newsApp"];

    [self.navigationController pushViewController:SelectionController animated:YES];
    self.navigationItem.hidesBackButton = FALSE;

}

- (void)selectContactApps {

    SparkAppListTableViewController* SelectionController = [[SparkAppListTableViewController alloc] initWithIdentifier:@"com.jacc.wiiprefs" andKey:@"contactApp"];

    [self.navigationController pushViewController:SelectionController animated:YES];
    self.navigationItem.hidesBackButton = FALSE;

}

- (void)selectHealthApps {

    SparkAppListTableViewController* SelectionController = [[SparkAppListTableViewController alloc] initWithIdentifier:@"com.jacc.wiiprefs" andKey:@"healthApp"];

    [self.navigationController pushViewController:SelectionController animated:YES];
    self.navigationItem.hidesBackButton = FALSE;

}

- (void)selectFriendsApps {

    SparkAppListTableViewController* SelectionController = [[SparkAppListTableViewController alloc] initWithIdentifier:@"com.jacc.wiiprefs" andKey:@"friendsApp"];

    [self.navigationController pushViewController:SelectionController animated:YES];
    self.navigationItem.hidesBackButton = FALSE;

}

- (void)respring {
	UIAlertController *respring = [UIAlertController alertControllerWithTitle:@"Wiivamp"
													 message:@"Do you really want to ReSpring?"
													 preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
			[self respringUtil];
	}];

	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
	[respring addAction:confirmAction];
	[respring addAction:cancelAction];
	[self presentViewController:respring animated:YES completion:nil];

}

- (void)respringUtil {
	NSTask *t = [[NSTask alloc] init];
    [t setLaunchPath:@"/usr/bin/killall"];
    [t setArguments:[NSArray arrayWithObjects:@"backboardd", nil]];
    [t launch];
}

@end