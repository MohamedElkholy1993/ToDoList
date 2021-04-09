//
//  ToDoTableViewController.m
//  ToDoList
//
//  Created by moutaz hegazy on 2/24/21.
//  Copyright © 2021 Mohmaed_Elkholy. All rights reserved.
//

#import "ToDoTableViewController.h"
#import "InProgressTableViewController.h"
#import "DoneTableViewController.h"
#import "TaskTableViewCell.h"
#import "TaskViewController.h"
#import "EditNewTaskViewController.h"
#import "EditExistedTaskViewController.h"


@interface ToDoTableViewController ()
-(void) writeDataToPlist;
-(void) readDataFromPlist;
@end

@implementation ToDoTableViewController{
    NSMutableArray<Task*> *allTasksInPlist;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tasks = [NSMutableArray new];
    allTasksInPlist = [NSMutableArray new];
    _searchResults = [[NSMutableArray alloc] initWithArray:_tasks];
}

- (void)viewWillAppear:(BOOL)animated{
    [self readDataFromPlist];
    [_searchResults setArray:_tasks];
    [_searchBar setText:@""];
    [self.tableView reloadData];
    
}

- (void)readDataFromPlist{
    //Get the documents directory path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"AllData.plist"];
    
    NSMutableDictionary *savedValue = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    
    NSArray * array = [savedValue objectForKey:@"New item"];
    //To retrieve the data from the plist
    _tasks = [NSMutableArray new];
    allTasksInPlist = [NSMutableArray new];
    for (NSDictionary *item in array)
    {
        [allTasksInPlist addObject:[Task initWithDic:item]];
        if ([[item objectForKey:@"status"] isEqualToString:@"ToDo"] && [[item objectForKey:@"priority"] isEqualToString:@"High"])
        {
            [_tasks addObject:[Task initWithDic:item]];
        }
        
    }
    for (NSDictionary *item in array)
    {
        
        if ([[item objectForKey:@"status"] isEqualToString:@"ToDo"] && [[item objectForKey:@"priority"] isEqualToString:@"Medium"])
        {
            [_tasks addObject:[Task initWithDic:item]];
        }
        
    }
    for (NSDictionary *item in array)
    {
        
        if ([[item objectForKey:@"status"] isEqualToString:@"ToDo"] && [[item objectForKey:@"priority"] isEqualToString:@"Low"])
        {
            [_tasks addObject:[Task initWithDic:item]];
        }
        
    }
    
}


-(void) writeDataToPlist{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"AllData.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];

    if (![fileManager fileExistsAtPath: path]) {

        path = [documentsDirectory stringByAppendingPathComponent: [NSString stringWithFormat:@"AllData.plist"] ];
    }

    NSMutableDictionary *data;

    if ([fileManager fileExistsAtPath: path]) {

        data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
        
    }
    else {
        // If the file doesn’t exist, create an empty dictionary
        data = [[NSMutableDictionary alloc] init];
    }
    NSMutableArray *newArr = [NSMutableArray new];

    
    for (Task *item in allTasksInPlist)
    {
        [newArr addObject:[item returnDic]];
    }
    [data setObject:newArr forKey:@"New item"];

    //To insert the data into the plist
    
    [data writeToFile:path atomically:YES];
}

-(void) updateTasksIdt{
    for (int i=0;i<allTasksInPlist.count;i++)
    {
        allTasksInPlist[i].idt = [NSNumber numberWithInt:i];
    }
}

-(void) updateTasksAtRow:(NSIndexPath*)indexpath{
    
    NSNumber *var =_tasks[indexpath.row].idt;
    allTasksInPlist[var.intValue].atRow = [NSNumber numberWithLong:indexpath.row];
    [self writeDataToPlist];
    [self readDataFromPlist];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _searchResults.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCell" forIndexPath:indexPath];
    // Configure the cell...
    [self updateTasksAtRow:indexPath];
    cell.taskNameLabel.text = _searchResults[indexPath.row].name;
    cell.descriptionLabel.text=_searchResults[indexPath.row].descript;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd 'at' HH:mm"];
    
    cell.creationDateLabel.text= [@"Created at " stringByAppendingString:[formatter stringFromDate:_searchResults[indexPath.row].creationDate]];
    cell.deadlineLabel.text =[@"Ends at " stringByAppendingString:[formatter stringFromDate:_searchResults[indexPath.row].deadLine]];
    
    if ([_searchResults[indexPath.row].priority isEqualToString:@"High"])
    {
        cell.priorityLabel.backgroundColor=[UIColor redColor];
    }else if([_searchResults[indexPath.row].priority isEqualToString:@"Medium"])
    {
        cell.priorityLabel.backgroundColor=[UIColor orangeColor];
    }else{
        cell.priorityLabel.backgroundColor=[UIColor greenColor];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    TaskViewController *viewTaskVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewTask"];
    [viewTaskVC setTaskToView:_searchResults[indexPath.row]];
    [viewTaskVC setEditProtocol3:self];
    [self.navigationController pushViewController:viewTaskVC animated:YES];
  
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 230;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSNumber *var = _tasks[indexPath.row].idt;
        
        [allTasksInPlist removeObjectAtIndex:var.intValue];
        [_tasks removeObjectAtIndex:indexPath.row];
        [self updateTasksIdt];
        [self writeDataToPlist];
        [_searchResults setArray:_tasks];
        [self.tableView reloadData];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}

- (IBAction)addTask:(id)sender {
    
    Task *task = [Task new];
    task.idt = [NSNumber numberWithInt:allTasksInPlist.count];
    task.atRow = [NSNumber numberWithInt:_tasks.count];
    task.name = @"Task";
    task.descript =@"Description";
    task.creationDate = [NSDate date];
    task.deadLine =[[NSDate alloc] init];
    task.deadLine = [NSDate dateWithTimeIntervalSinceNow:864000];
    task.priority = @"Low";
    task.status = @"ToDo";
        
    [_tasks addObject:task];
    [allTasksInPlist addObject:task];
    [_searchResults setArray:_tasks];
    
    //[self.tableView reloadData];
    EditNewTaskViewController *editNewTaskVC = [self.storyboard instantiateViewControllerWithIdentifier:@"EditNewTask"];
    [editNewTaskVC setTaskNewToEdit:task];
    [self.navigationController pushViewController:editNewTaskVC animated:YES];

    [editNewTaskVC setEditProtcol:self];

}

- (void)sendData:(Task *)newEditedTask{
    
    _tasks[[newEditedTask.atRow intValue]] = newEditedTask;
    [self writeDataToPlist];
    [self readDataFromPlist];
    [_searchResults setArray:_tasks];
    [self.tableView reloadData];
}

- (void)sendData2:(Task *)editedTask{
    
    if ([editedTask.name isEqualToString:@""])
    {
        editedTask.name =@"Task";
            
    }else if([editedTask.descript isEqualToString:@""])
    {
        editedTask.descript =@"Description";
    }else{}
    
    _tasks[[editedTask.atRow intValue]] = editedTask;
    allTasksInPlist[[editedTask.idt intValue]]=editedTask;
    [self writeDataToPlist];
    [self readDataFromPlist];
    [_searchResults setArray:_tasks];
    [self.tableView reloadData];

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    
    NSString *searchWord = searchBar.text;
    
    if (searchWord.length > 0)
    {
        
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS[cd] %@", searchWord];
        [_searchResults filterUsingPredicate:predicate];
        
    }else{
        [_searchResults setArray:_tasks];
    }
    
    [self.tableView reloadData];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    NSString *searchWord = searchBar.text;
    
    if (searchWord.length > 0)
    {
        
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS[cd] %@", searchWord];
        [_searchResults filterUsingPredicate:predicate];
        
    }else{
        [_searchResults setArray:_tasks];
    }
    
    [self.tableView reloadData];
}

@end
