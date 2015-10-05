//
//  MenuViewController.m
//  Twitter
//
//  Created by Henry Ching on 10/1/15.
//  Copyright © 2015 Henry Ching. All rights reserved.
//

#import "MenuViewController.h"
#import "UIImageView+AFNetworking.h"
#import "User.h"
#import "ProfileTableViewCell.h"
#import "TimelineTableViewCell.h"
#import "SignOutTableViewCell.h"

@interface MenuViewController ()
@property (weak, nonatomic) IBOutlet UITableView *menuTableView;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self.menuTableView reloadData];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    User *user = [User currentUser];
    if(indexPath.row == 0) {
        ProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"profileCell"];
        [cell.profileImageView setImageWithURL:[NSURL URLWithString:user.profileImageUrl]];
        cell.userNameLabel.text = user.name;
        cell.userTitleLabel.text = user.screenName;
        return cell;
    } else if(indexPath.row == 1) {
        TimelineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"timelineCell"];
        return cell;
    } else if(indexPath.row == 2) {
        SignOutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"signoutCell"];
        return cell;
    } else {
        return nil;
    }
}

- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender
{

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 2)
        [User logout];
}

@end
