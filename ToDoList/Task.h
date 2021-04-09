//
//  Task.h
//  ToDoList
//
//  Created by moutaz hegazy on 2/24/21.
//  Copyright © 2021 Mohmaed_Elkholy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Task : NSObject
@property NSNumber *idt;
@property NSNumber *atRow;
@property NSString *name;
@property NSString *descript;
@property NSString *priority;
@property NSDate *creationDate;
@property NSDate *deadLine;
@property NSString *status;
-(NSMutableDictionary*) returnDic;
+(Task*) initWithDic:(NSDictionary*)dic;
@end

NS_ASSUME_NONNULL_END
