//
//  ProfileViewController.m
//  Twitter
//
//  Created by Henry Ching on 10/3/15.
//  Copyright © 2015 Henry Ching. All rights reserved.
//

#import "ProfileViewController.h"
#import "User.h"
#import "TwitterClient.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"
#import "ProfileTweetTableViewCell.h"
#import "SWRevealViewController.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tweetsTableView;
@property (weak, nonatomic) IBOutlet UIImageView *profileBackgroundImage;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *revealButtonItem;
@property (weak, nonatomic) IBOutlet UILabel *tweetCount;
@property (weak, nonatomic) IBOutlet UILabel *followingCount;
@property (weak, nonatomic) IBOutlet UILabel *followersCount;

@property (strong, nonatomic) NSArray *tweetArray;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self customNavSetup];

    NSString *currentScreenName = @"";
    NSLog(@"Passed:  %@", self.screenName);
    if(self.screenName != nil)
        currentScreenName = self.screenName;
    
    [[TwitterClient sharedInstance] getProfileTweets:currentScreenName completion:^(NSArray *tweets, NSError *error) {
        if(tweets != nil) {
            self.tweetArray = tweets;
            
            Tweet *tweet = self.tweetArray[0];
            [self.profileBackgroundImage setImageWithURL:[NSURL URLWithString:tweet.user.profileBackgroundImageUrl]];
            NSLog(@"Tc: %@", tweet.user.tweetCount);
            self.tweetCount.text = [[NSString alloc] initWithFormat:@"%@", tweet.user.tweetCount];
            self.followersCount.text = [[NSString alloc] initWithFormat:@"%@", tweet.user.followersCount];
            self.followingCount.text = [[NSString alloc] initWithFormat:@"%@", tweet.user.followingCount];
            
            [self.tweetsTableView reloadData];
        } else {
            //error
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tweetArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Tweet *tweet = self.tweetArray[indexPath.row];
    ProfileTweetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"profiletweetcell"];
    cell.userNameLabel.text = tweet.user.name;
    cell.userTwitterNameLabel.text = [NSString stringWithFormat:@"@%@", tweet.user.screenName];
    [cell.profileImage setImageWithURL:[NSURL URLWithString:tweet.user.profileImageUrl]];
    cell.tweetLabel.text = tweet.text;
    return cell;
}


@end
