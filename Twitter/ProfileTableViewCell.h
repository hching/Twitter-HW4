//
//  ProfileTableViewCell.h
//  Twitter
//
//  Created by Henry Ching on 10/1/15.
//  Copyright © 2015 Henry Ching. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userTitleLabel;

@end
