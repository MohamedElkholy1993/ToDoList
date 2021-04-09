//
//  EditExistedTaskViewController.h
//  ToDoList
//
//  Created by moutaz hegazy on 2/25/21.
//  Copyright © 2021 Mohmaed_Elkholy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoneEditingExistedTask.h"
#import "Task.h"
#import <EventKit/EventKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EditExistedTaskViewController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *taskNameField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionField;
@property (weak, nonatomic) IBOutlet UIDatePicker *deadlinePicker;
@property (weak, nonatomic) IBOutlet UIPickerView *priorityPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *StatusPicker;

@property (weak, nonatomic) IBOutlet UISwitch *reminderSwitch;
@property EKEventStore *store;
@property Task *existedTaskToEdit;

@property id <DoneEditingExistedTask> editProtcol2;
@end

NS_ASSUME_NONNULL_END
