//
//  EditTaskViewController.m
//  ToDoList
//
//  Created by moutaz hegazy on 2/24/21.
//  Copyright © 2021 Mohmaed_Elkholy. All rights reserved.
//

#import "EditNewTaskViewController.h"

@interface EditNewTaskViewController ()

@end

@implementation EditNewTaskViewController{
    NSMutableArray *priorityArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneButtonPressed)];
    self.navigationItem.rightBarButtonItem = doneButton;
    _taskNameField.text = _taskNewToEdit.name;
    _descriptionField.text = _taskNewToEdit.descript;
    _deadlinePicker.minimumDate = [NSDate date];
    _deadlinePicker.date = _taskNewToEdit.deadLine;
    
    priorityArray = [NSMutableArray new];
    [priorityArray addObject:@"Low"];
    [priorityArray addObject:@"Medium"];
    [priorityArray addObject:@"High"];
}


-(void) doneButtonPressed
{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Do you want to save?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *save = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.taskNewToEdit.name = self.taskNameField.text;
        self.taskNewToEdit.descript = self.descriptionField.text;
        self.taskNewToEdit.deadLine = self.deadlinePicker.date;
        if ([self.taskNewToEdit.name isEqualToString:@""])
        {
            self.taskNewToEdit.name =@"Task";
            
        }else if([self.taskNewToEdit.descript isEqualToString:@""])
        {
            self.taskNewToEdit.descript =@"Description";
        }else{}
        [self.editProtcol sendData:self.taskNewToEdit];
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
    return 3;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [priorityArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    _taskNewToEdit.priority = [priorityArray objectAtIndex:row];
}
@end
