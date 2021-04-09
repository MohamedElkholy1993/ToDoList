//
//  TaskViewController.m
//  ToDoList
//
//  Created by moutaz hegazy on 2/24/21.
//  Copyright © 2021 Mohmaed_Elkholy. All rights reserved.
//

#import "TaskViewController.h"
#import "EditExistedTaskViewController.h"

@interface TaskViewController ()

@end

@implementation TaskViewController{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd 'at' HH:mm"];
    
    _taskNameLabel.text = _taskToView.name;
    _descriptionLabel.text = _taskToView.descript;
    _creationDateLabel.text = [@"Created at " stringByAppendingString:[formatter stringFromDate:_taskToView.creationDate] ];
    _deadlineLabel.text = [@"Ends at " stringByAppendingString:[formatter stringFromDate:_taskToView.deadLine] ];
    _priorityLabel.text = [@"Priority:" stringByAppendingString: _taskToView.priority];
    _statusLabel.text = [@"Status:" stringByAppendingString: _taskToView.status];
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editButtonPressed)];
    self.navigationItem.rightBarButtonItem = editButton;
}

-(void) editButtonPressed
{
    EditExistedTaskViewController *editExistedTaskVC = [self.storyboard instantiateViewControllerWithIdentifier:@"EditExistedTask"];
    
    [editExistedTaskVC setExistedTaskToEdit:_taskToView];
    [editExistedTaskVC setEditProtcol2:_editProtocol3];
    [self.navigationController pushViewController:editExistedTaskVC animated:YES];
}

@end
