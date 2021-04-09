//
//  IMBacktraceHelper.h
//  IMQAMpmAgent
//
//  Created by Theodore Cha on 2018. 9. 24..
//  Copyright © 2018년 Theodore Cha. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <mach/mach.h>
#include <dlfcn.h>
#include <pthread.h>
#include <sys/types.h>
#include <limits.h>
#include <string.h>
#include <mach-o/dyld.h>
#include <mach-o/nlist.h>

@interface IMBacktraceHelper: NSObject

+ (NSDictionary *)backtraceOfMachthread: (thread_t)thread;

@end
