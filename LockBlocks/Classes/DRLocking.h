//
//  DRLocking.h
//  DRReadWriteLock
//
//  Created by Nate Petersen on 8/27/13.
//  Copyright (c) 2013 Digital Rickshaw. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DRLocking <NSLocking>

/**
 * Executes a block, wrapping it in a call to lock and unlock.
 */
- (void)executeInLock:(void(^)())block;

/**
 * Tries to execute a block, wrapping it in a call to tryLock and unlock.
 *
 * Returns YES if it was able to obtain the lock and execute the block. Otherwise, returns NO.
 */
- (BOOL)tryToExecuteInLock:(void(^)())block;

@end
