//
//  ToDoTableViewController.h
//  ToDoList
//
//  Created by moutaz hegazy on 2/24/21.
//  Copyright © 2021 Mohmaed_Elkholy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "DoneEditingNewTask.h"
#import "DoneEditingExistedTask.h"
NS_ASSUME_NONNULL_BEGIN

@interface ToDoTableViewController : UITableViewController <DoneEditingNewTask,DoneEditingExistedTask,UISearchBarDelegate,UISearchResultsUpdating>
@property NSMutableArray<Task *> *tasks;
@property NSMutableArray<Task *> *searchResults;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
- (IBAction)addTask:(id)sender;
-(void) updateTasksAtRow;
@end

NS_ASSUME_NONNULL_END
