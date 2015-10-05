//
//  ProfileTweetTableViewCell.h
//  Twitter
//
//  Created by Henry Ching on 10/3/15.
//  Copyright © 2015 Henry Ching. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileTweetTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userTwitterNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetedAgoLabel;

@end
