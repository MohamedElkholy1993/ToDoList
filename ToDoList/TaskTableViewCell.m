//
//  TaskTableViewCell.m
//  ToDoList
//
//  Created by moutaz hegazy on 2/24/21.
//  Copyright © 2021 Mohmaed_Elkholy. All rights reserved.
//

#import "TaskTableViewCell.h"

@implementation TaskTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _priorityLabel.layer.cornerRadius = 5.0;
    _priorityLabel.layer.masksToBounds = YES;
    [_priorityLabel.layer setBorderColor:[UIColor blueColor].CGColor];
    [_priorityLabel.layer setBorderWidth:1.0f];
    [self.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.layer setBorderWidth:1.5f];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
