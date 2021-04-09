//
//  EditTaskViewController.h
//  ToDoList
//
//  Created by moutaz hegazy on 2/24/21.
//  Copyright © 2021 Mohmaed_Elkholy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoneEditingNewTask.h"
#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@interface EditNewTaskViewController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic) Task *taskNewToEdit;
@property (weak, nonatomic) IBOutlet UITextField *taskNameField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionField;
@property (weak, nonatomic) IBOutlet UIDatePicker *deadlinePicker;
@property (weak, nonatomic) IBOutlet UIPickerView *priorityPicker;
@property id <DoneEditingNewTask> editProtcol;
@end

NS_ASSUME_NONNULL_END
