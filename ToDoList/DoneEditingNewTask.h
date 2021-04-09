//
//  DoneEditingTask.h
//  ToDoList
//
//  Created by moutaz hegazy on 2/25/21.
//  Copyright © 2021 Mohmaed_Elkholy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DoneEditingNewTask <NSObject>
-(void) sendData:(Task*)newEditedTask;

@end

NS_ASSUME_NONNULL_END
