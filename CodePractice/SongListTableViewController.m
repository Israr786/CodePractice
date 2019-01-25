//
//  SongListTableViewController.m
//  CodePractice
//
//  Created by Apple on 3/28/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "SongListTableViewController.h"
#import "SongTableViewCell.h"
#import "SecondViewController.h"

@interface SongListTableViewController (){
    NSArray *contents;
    NSURL *documentsURL;
    SecondViewController *SecondVC;
}

@end

@implementation SongListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//   documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
//                                                                  inDomains:NSUserDomainMask] lastObject];
//   contents = [[NSFileManager defaultManager]contentsOfDirectoryAtURL:documentsURL
//                                                     includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsHiddenFiles error:nil];
   self.navigationItem.title = @"Song List";
   self.tableView.dataSource = self;
   self.tableView.delegate = self;
    
[self.tableView registerNib:[UINib nibWithNibName:@"SongTableViewCell" bundle:nil]  forCellReuseIdentifier:@"SongCell"];

}

-(void)viewWillAppear:(BOOL)animated {
    documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                           inDomains:NSUserDomainMask] lastObject];
    contents = [[NSFileManager defaultManager]contentsOfDirectoryAtURL:documentsURL
                                            includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsHiddenFiles error:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [contents count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    SongTableViewCell *cell =(SongTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"SongCell" forIndexPath:indexPath];
    NSString *songPathUrl = [NSString stringWithFormat:@"%@",contents[indexPath.row]];
    NSLog(@"length %li",songPathUrl.length);
    //for simulator
    NSString *songName = [songPathUrl substringFromIndex:177];
    //for firoz device
//    NSString *songName = [songPathUrl substringFromIndex:102];
    NSString *str = [songName substringToIndex:[songName length] -4];
    NSString *Cstr = [str stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
    NSLog(@"SongName %@",Cstr);
    cell.songNameLabel.text = Cstr ;
    return cell;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0;
}


//// Override to support conditional editing of the table view.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView beginUpdates];
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        
        NSFileManager *fileManager = [NSFileManager defaultManager];
       BOOL fileDeleted = [fileManager removeItemAtPath:contents[indexPath.row] error:nil];
        if (fileDeleted == true ){
            if ( _playerVC.player.isPlaying == true ){
                [_playerVC.player stop];
            }
            [tableView reloadData];
  //          [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
           
        }
        
   //     [self viewDidLoad];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
     [tableView endUpdates];
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    _playerVC.songUrlPathFromVC = contents[indexPath.row];
    _playerVC.songUrlPathArray = contents;
    _playerVC.songIndex = indexPath;
    [self.navigationController pushViewController:_playerVC animated:YES];
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
