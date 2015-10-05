//
//  TweetTableViewCell.m
//  Twitter
//
//  Created by Henry Ching on 9/27/15.
//  Copyright © 2015 Henry Ching. All rights reserved.
//

#import "TweetTableViewCell.h"


@implementation TweetTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapProfileImage)];
    [self.profileImage addGestureRecognizer:tap];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)onTapProfileImage {
    NSLog(@"Tapping!");
    
    //if ([self.delegate respondsToSelector:@selector(viewProfile:)]) {
        [self.delegate viewProfile:self.userTwitterName.text];
    //}
    /*
    if ([self.delegate respondsToSelector:@selector(viewUserProfile:)]) {
        [self.delegate viewUserProfile:_currentTweet.user];
    }
 
    //[self performSegueWithIdentifier:@"viewProfileSegue" sender:self];
     */
}

@end
