//
//  DoneEditingExistedTask.h
//  ToDoList
//
//  Created by moutaz hegazy on 2/25/21.
//  Copyright © 2021 Mohmaed_Elkholy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DoneEditingExistedTask <NSObject>
-(void) sendData2:(Task*)editedTask;
@end

NS_ASSUME_NONNULL_END
