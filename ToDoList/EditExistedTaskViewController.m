//
//  EditExistedTaskViewController.m
//  ToDoList
//
//  Created by moutaz hegazy on 2/25/21.
//  Copyright © 2021 Mohmaed_Elkholy. All rights reserved.
//

#import "EditExistedTaskViewController.h"

@interface EditExistedTaskViewController ()

@end

@implementation EditExistedTaskViewController{
    NSMutableArray *priorityArray;
    NSMutableArray *StatusArray;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneButtonPressed)];
    self.navigationItem.rightBarButtonItem = doneButton;
    
    _store = [[EKEventStore alloc] init];
    [_store requestAccessToEntityType:EKEntityTypeReminder
                          completion:^(BOOL granted, NSError *error) {
                              // Handle not being granted permission
                          }];
    
    _taskNameField.text = _existedTaskToEdit.name;
    _descriptionField.text = _existedTaskToEdit.descript;
    _deadlinePicker.minimumDate = [NSDate date];
    _deadlinePicker.date = _existedTaskToEdit.deadLine;
    [_priorityPicker setDelegate:self];
    [_priorityPicker setDataSource:self];
    [_StatusPicker setDelegate:self];
    [_StatusPicker setDataSource:self];
    
    priorityArray = [NSMutableArray new];
    [priorityArray addObject:@"Low"];
    [priorityArray addObject:@"Medium"];
    [priorityArray addObject:@"High"];

    
    StatusArray = [NSMutableArray new];
    if ([_existedTaskToEdit.status isEqualToString:@"ToDo"])
    {
        [StatusArray addObject:@"ToDo"];
        [StatusArray addObject:@"InProgress"];
        [StatusArray addObject:@"Done"];
    }
    else if ([_existedTaskToEdit.status isEqualToString:@"InProgress"])
    {
        [StatusArray addObject:@"InProgress"];
        [StatusArray addObject:@"Done"];
    }
    else{
        [StatusArray addObject:@"Done"];
    }
    
    [_priorityPicker selectRow:[priorityArray indexOfObject:_existedTaskToEdit.priority] inComponent:0 animated:NO];
}

-(void) doneButtonPressed
{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Do you want to save?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *save = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.existedTaskToEdit.name = self.taskNameField.text;
        self.existedTaskToEdit.descript = self.descriptionField.text;
        self.existedTaskToEdit.deadLine = self.deadlinePicker.date;
        if ([self.existedTaskToEdit.name isEqualToString:@""])
        {
            self.existedTaskToEdit.name =@"Task";
                
        }else if([self.existedTaskToEdit.descript isEqualToString:@""])
        {
            self.existedTaskToEdit.descript =@"Description";
        }else{}
        [self.editProtcol2 sendData2:self.existedTaskToEdit];
        
        if ([self.reminderSwitch isOn])
        {
            NSMutableArray<EKAlarm *>* alarms = [NSMutableArray new];
            EKAlarm *alarm = [EKAlarm alarmWithAbsoluteDate:self.deadlinePicker.date];
            [alarms addObject:alarm];
            EKReminder *reminder = [EKReminder reminderWithEventStore:self.store];
            [reminder setTitle:self.taskNameField.text];
            [reminder setNotes:self.descriptionField.text];
            [reminder setAlarms:alarms];
            EKCalendar *defaultReminderList = [self.store defaultCalendarForNewReminders];

            [reminder setCalendar:defaultReminderList];

            NSError *error = nil;
            BOOL success = [self.store saveReminder:reminder
                                             commit:YES
                                              error:&error];
            if (!success) {
                NSLog(@"Error saving reminder: %@", [error localizedDescription]);
            }
        }
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    [ac addAction:cancel];
    [ac addAction:save];
    [self presentViewController:ac animated:YES completion:nil];
    
    
}

     - (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
         return 1;
    }
     
     - (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
        
         switch (pickerView.tag) {
             case 1:
                 //priority
                 return 3;
                 break;
             case 2:
                 //status
                 if ([_existedTaskToEdit.status isEqualToString:@"ToDo"])
                 {
                     return 3;
                 }
                 else if ([_existedTaskToEdit.status isEqualToString:@"InProgress"])
                 {
                     return 2;
                 }
                 else{
                     return 1;
                 }
                 break;
             default:
                 return 0;
                 break;
         }

    }

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    switch (pickerView.tag) {
        case 1:
            //priority
            return [priorityArray objectAtIndex:row];
            break;
        case 2:
            //status
            if ([_existedTaskToEdit.status isEqualToString:@"ToDo"])
            {
                return [StatusArray objectAtIndex:row];
            }
            else if ([_existedTaskToEdit.status isEqualToString:@"InProgress"])
            {
                return [StatusArray objectAtIndex:row];
            }
            else{
                return [StatusArray objectAtIndex:row];
            }
            break;
        default:
            return @"Default";
            break;
    }

}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    switch (pickerView.tag) {
        case 1:
            _existedTaskToEdit.priority = [priorityArray objectAtIndex:row];
            break;
        case 2:
            //status
            _existedTaskToEdit.status = [StatusArray objectAtIndex:row];
            break;
        default:
            break;
    }
}
     
     @end
