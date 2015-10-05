//
//  TwitterClient.h
//  Twitter
//
//  Created by Henry Ching on 9/24/15.
//  Copyright © 2015 Henry Ching. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "User.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager

+ (TwitterClient *)sharedInstance;

- (void) loginWithCompletion:(void (^)(User *user, NSError *error))completion;
- (void) openURL:(NSURL *)url;

- (void) getTweets:(void (^)(NSArray *tweets, NSError *error))completion;
- (void) getProfileTweets:(NSString *)screenName completion:(void(^)(NSArray *tweets, NSError *error))completion;
- (void) createTweet:(NSString *)status completion:(void (^)(NSDictionary *tweet, NSError *error))completion;
- (void) reTweet:(NSString *)tweetId completion:(void(^)(NSDictionary *tweet, NSError *error))completion;
- (void) favoriteTweet:(NSString *)tweetId completion:(void (^)(NSDictionary *tweet, NSError *error))completion;
    - (void) unfavoriteTweet:(NSString *)tweetId completion:(void (^)(NSDictionary *tweet, NSError *error))completion;
    
@end
