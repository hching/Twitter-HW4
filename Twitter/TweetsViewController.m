//
//  TweetsViewController.m
//  Twitter
//
//  Created by Henry Ching on 9/27/15.
//  Copyright © 2015 Henry Ching. All rights reserved.
//

#import "TweetsViewController.h"
#import "User.h"
#import "TwitterClient.h"
#import "Tweet.h"
#import "TweetTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "ViewTweetViewController.h"
#import "CreateTweetViewController.h"
#import "SWRevealViewController.h"
#import "ProfileViewController.h"

@interface TweetsViewController ()
//@property (weak, nonatomic) IBOutlet UIBarButtonItem *signOutButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *revealButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *createNewTweetButton;
@property (weak, nonatomic) IBOutlet UITableView *tweetsTableView;

@property (strong, nonatomic) NSArray *tweetArray;
@property NSInteger rowselected;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) NSString *tweetId;
@property (nonatomic, strong) NSString *currentScreenName;

@end

@implementation TweetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Home";

    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tweetsTableView insertSubview:self.refreshControl atIndex:0];
    
    [self customNavSetup];
    
    [[TwitterClient sharedInstance] getTweets:^(NSArray *tweets, NSError *error) {
        if(tweets != nil) {
            //present
            //NSLog(@"Welcome to %@", user.name);
            //[self presentViewController:[[TweetsViewController alloc] init] animated:YES completion:nil];
            self.tweetArray = tweets;
            //NSLog(@"Tweets Count: %ld", self.tweets.count);
            //for(Tweet *tweet in self.tweetArray) {
                //NSLog(@"tweet: %@, createdAt: %@", tweet.text, tweet.createdAt);
            //}
            [self.tweetsTableView reloadData];
        } else {
            //error
        }
    }];
}

- (void)customNavSetup
{
    SWRevealViewController *revealViewController = self.revealViewController;
    if (revealViewController)
    {
        [self.revealButtonItem setTarget: self.revealViewController];
        [self.revealButtonItem setAction: @selector( revealToggle: )];
        [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    }
    //self.revealViewController.rearViewRevealWidth = 300;
}

- (void)onRefresh {
    [[TwitterClient sharedInstance] getTweets:^(NSArray *tweets, NSError *error) {
        if(tweets != nil) {
            self.tweetArray = tweets;
            [self.tweetsTableView reloadData];
            [self.refreshControl endRefreshing];
        } else {
            //error
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


/*
- (IBAction)onSignOut:(UIBarButtonItem *)sender {
    [User logout];
}
*/

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // Save what you need here
    
    [super encodeRestorableStateWithCoder:coder];
}


- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // Restore what you need here
    
    [super decodeRestorableStateWithCoder:coder];
}


- (void)applicationFinishedRestoringState
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // Call whatever function you need to visually restore
    [self customNavSetup];
}


- (IBAction)onCreateTweet:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"createTweetSegue" sender:self];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tweetArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Tweet *tweet = self.tweetArray[indexPath.row];
    TweetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"com.yahoo.tweetcell"];
    cell.userName.text = tweet.user.name;
    cell.userTwitterName.text = [NSString stringWithFormat:@"@%@", tweet.user.screenName];
    [cell.profileImage setImageWithURL:[NSURL URLWithString:tweet.user.profileImageUrl]];
    cell.tweetText.text = tweet.text;
    cell.delegate = self;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.rowselected = indexPath.row;
    Tweet *tweet = self.tweetArray[self.rowselected];
    self.tweetId = tweet.tweetId;
    [self performSegueWithIdentifier:@"viewTweetSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"viewTweetSegue"])
    {
        ViewTweetViewController *vc = [segue destinationViewController];
        Tweet *tweet = self.tweetArray[self.rowselected];
        [vc setGuserName:tweet.user.name];
        [vc setGuserTwitterName:tweet.user.screenName];
        [vc setGtweetText:tweet.text];
        [vc setGuserImage:[NSURL URLWithString:tweet.user.profileImageUrl]];
        [vc setGtweetId:tweet.tweetId];
    } else if ([[segue identifier] isEqualToString:@"createTweetSegue"])
    {
        CreateTweetViewController *vc = [segue destinationViewController];
        Tweet *tweet = self.tweetArray[self.rowselected];
        [vc setGuserName:tweet.user.name];
        [vc setGuserTwitterName:tweet.user.screenName];
        [vc setGuserImage:[NSURL URLWithString:tweet.user.profileImageUrl]];
    } else if ([[segue identifier] isEqualToString:@"viewProfileSegue"])
    {
        ProfileViewController *vc = [segue destinationViewController];
        self.currentScreenName = [self.currentScreenName stringByReplacingOccurrencesOfString:@"[@" withString:@""];
        [vc setScreenName:self.currentScreenName];
    }
}

- (void)viewProfile:(NSString *)screenName {
    self.currentScreenName = screenName;
    [self performSegueWithIdentifier:@"viewProfileSegue" sender:self];
}

- (IBAction)onReply:(UITapGestureRecognizer *)sender {
    
}

- (IBAction)onFavorite:(UITapGestureRecognizer *)sender {

}

- (IBAction)onRetweet:(UIButton *)sender {
    [[TwitterClient sharedInstance] createTweet:self.tweetId completion:^(NSDictionary *tweet, NSError *error) {
        if(tweet != nil) {
            [self onRefresh];
        } else {
            //error
        }
    }];
}



@end
