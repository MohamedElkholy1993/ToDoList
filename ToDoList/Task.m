//
//  Task.m
//  ToDoList
//
//  Created by moutaz hegazy on 2/24/21.
//  Copyright © 2021 Mohmaed_Elkholy. All rights reserved.
//

#import "Task.h"

@interface Task ()

@end

@implementation Task
+(Task*) initWithDic:(NSDictionary*)dic{
    Task *task = [Task new];
    task.idt =[dic valueForKey:@"identifier"];
    task.atRow = [dic valueForKey:@"atRow"];
    task.name =[dic valueForKey:@"name"];
    task.descript =[dic valueForKey:@"descript"];
    task.creationDate =[dic valueForKey:@"creationDate"];
    task.deadLine =[dic valueForKey:@"deadline"];
    task.priority =[dic valueForKey:@"priority"];
    task.status =[dic valueForKey:@"status"];

    return task;
}
-(NSMutableDictionary*) returnDic{
    NSMutableDictionary *dic = [NSMutableDictionary new];
    
    [dic setObject:self.name forKey:@"name"];
    [dic setObject:self.descript forKey:@"descript"];
    [dic setObject:self.creationDate forKey:@"creationDate"];
    [dic setObject:self.deadLine forKey:@"deadline"];
    [dic setObject:self.priority forKey:@"priority"];
    [dic setObject:self.status forKey:@"status"];
    [dic setObject:self.idt forKey:@"identifier"];
    [dic setObject:self.atRow forKey:@"atRow"];
    
    
    return dic;
}


@end
