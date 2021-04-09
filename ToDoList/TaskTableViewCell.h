//
//  TaskTableViewCell.h
//  ToDoList
//
//  Created by moutaz hegazy on 2/24/21.
//  Copyright © 2021 Mohmaed_Elkholy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TaskTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *taskNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *creationDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *deadlineLabel;
@property (weak, nonatomic) IBOutlet UIImageView *priorityLabel;

@end

NS_ASSUME_NONNULL_END
