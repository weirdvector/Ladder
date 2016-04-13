//
//  AppDelegate.m
//  major_project
//
//  Created by iOS Xcode User on 2016-04-01.
//  Copyright © 2016 Greg Wood. All rights reserved.
//

#import "AppDelegate.h"
#import "UserUtility.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize  window,homeVC, profileVC, registerVC, orgProfileVC, orgRegisterVC, topicsVC, commentsVC, webVC, addTopicVC, addCommentVC, dashVC, loginVC, aboutVC, user, organization, _audioPlayer;

#pragma mark - Navigation - Alan
-(void)transToDash
{
    self.dashVC = [[DashBoardViewController alloc] initWithNibName:@"DashBoardViewController" bundle:nil];
    [self setupAnimation:FORWARD];
    [self swapViews:self.loginVC.view goingTo:self.dashVC.view];
}

-(void)transToAbout{
    self.aboutVC = [[AboutUsViewController alloc] initWithNibName:@"AboutUsViewController" bundle:nil];
    [self setupAnimation:FORWARD];
    [self swapViews:self.dashVC.view goingTo:self.aboutVC.view];
}

-(void)transToLogin
{
    self.aboutVC = [[AboutUsViewController alloc] initWithNibName:@"View" bundle:nil];
    [self setupAnimation:FORWARD];
    [self swapViews:self.dashVC.view goingTo:self.loginVC.view];
}

-(void)transToDashFromAbout{
    self.dashVC = [[DashBoardViewController alloc] initWithNibName:@"DashBoardViewController" bundle:nil];
    [self setupAnimation:BACKWARD];
    [self swapViews:self.aboutVC.view goingTo:self.dashVC.view];
}

#pragma mark - Navigation

- (void) setupAnimation: (NSInteger) direction {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:ANIMATION_DURATION];
    if (direction == FORWARD) {
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:window cache:YES];
    } else {
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:window cache:YES];
    }
}

- (void) swapViews: (UIView *)from goingTo: (UIView *)to {
    [_audioPlayer play];
    [from removeFromSuperview];
    [self.window addSubview: to];
    [UIView commitAnimations];
}

- (void) flipToRegister {
    self.registerVC = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    [self setupAnimation:FORWARD];
    [self swapViews: self.loginVC.view goingTo:self.registerVC.view];
    [self playSound];
}

-(void)flipToRegisterHome{
    [self setupAnimation:BACKWARD];
    [self swapViews:self.registerVC.view goingTo:self.loginVC.view];
    self.registerVC = nil;
    [self playSound];
}


-(void)flipToProfile {
    self.profileVC = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
    [self setupAnimation:FORWARD];
    [self swapViews: self.dashVC.view goingTo:self.profileVC.view];
    [self playSound];
}

-(void)flipToProfileHome {
    [self setupAnimation:BACKWARD];
    [self swapViews:self.profileVC.view goingTo:self.dashVC.view];
    self.profileVC = nil;
    [self playSound];
}

-(void)flipToOrgRegister {
    self.orgRegisterVC = [[OrganizationRegisterViewController alloc] initWithNibName:@"OrganizationRegisterViewController" bundle:nil];
    [self setupAnimation:FORWARD];
    [self swapViews: self.loginVC.view goingTo:self.orgRegisterVC.view];
    [self playSound];
}

-(void)flipToOrgRegisterHome {
    [self setupAnimation:BACKWARD];
    [self swapViews:self.orgRegisterVC.view goingTo:self.loginVC.view];
    self.orgRegisterVC = nil;
    [self playSound];
}

-(void)flipToOrgProfile {
    self.orgProfileVC = [[OrganizationProfileViewController alloc] initWithNibName:@"OrganizationProfileViewController" bundle:nil];
    [self setupAnimation:FORWARD];
    [self swapViews: self.dashVC.view goingTo:self.orgProfileVC.view];
    [self playSound];
}

-(void)flipToOrgProfileHome {
    [self setupAnimation:BACKWARD];
    [self swapViews:self.orgProfileVC.view goingTo:self.dashVC.view];
    self.orgProfileVC = nil;
    [self playSound];
}

- (void) flipToComments: (NSInteger *)topicID titleText: (NSString *) title {
    self.commentsVC = [[CommentsViewController alloc] initWithNibName:@"CommentsViewController" bundle:nil];
    self.commentsVC.topicID = topicID;
    self.commentsVC.titleText = title;
    [self setupAnimation:FORWARD];
    [self swapViews: self.topicsVC.view goingTo:self.commentsVC.view];
    [self playSound];
}

- (void) flipToCommentsBack {
    [self setupAnimation:BACKWARD];
    [self swapViews:self.commentsVC.view goingTo:self.topicsVC.view];
    self.commentsVC = nil;
    [self playSound];
}

- (void) flipToTopics {
    self.topicsVC = [[TopicsViewController alloc] initWithNibName:@"TopicsViewController" bundle:nil];
    [self setupAnimation:FORWARD];
    [self swapViews:self.dashVC.view goingTo:self.topicsVC.view];
    [self playSound];
}

- (void) flipToTopicsHome {
    [self setupAnimation:BACKWARD];
    [self swapViews:self.topicsVC.view goingTo:self.dashVC.view];
    self.topicsVC = nil;
    [self playSound];
}

#pragma mark - Other methods

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    
    // Construct URL to sound file
    NSString *path = [NSString stringWithFormat:@"%@/pageturn.wav", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    
    // Create audio player object and initialize with URL to sound
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    
    //get the user
    UserUtility *uu = [[UserUtility alloc] init];
    self.user = [uu retrieveUser:@"caseyjones" pw:@"password"];
    
    self.loginVC = [[ViewController alloc] initWithNibName:@"View" bundle:nil];
    self.window.rootViewController = self.loginVC;
    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark - User

- (void) loginUser: (NSString *) username pw: (NSString *) password {
    UserUtility *uu = [[UserUtility alloc] init];
    self.user = [uu retrieveUser:username pw:password];
}

#pragma mark - Audio

- (void) playSound {
    AudioServicesPlaySystemSound(systemSoundID);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
