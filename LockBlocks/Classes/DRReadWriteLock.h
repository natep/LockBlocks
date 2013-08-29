//
//  DRReadWriteLock.h
//  DRReadWriteLock
//
//  Created by Nate Petersen on 8/27/13.
//  Copyright (c) 2013 Digital Rickshaw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DRLocking.h"

/**
 * Implements a read/write (non-exclusive/exclusive) lock.
 *
 * IMPORTANT NOTE ABOUT RE-ENTRANCY
 *
 * This class is a wrapper around the standard pthreads read/write lock.
 * Pthreads only supports limited reentrancy (recursion) in read/write
 * locks.
 *
 * It is safe for a thread to obtain the read lock again if it
 * already has it. However, it is NOT safe for a thread to attempt to
 * obtain the write lock while already having a lock (either read or write).
 */
@interface DRReadWriteLock : NSObject <DRLocking>

/**
 * This is an alias for writeLock.
 */
- (void)lock;

/**
 * Attempts to acquire a write lock (exclusive lock),
 * blocking a thread’s execution until the lock can be acquired.
 *
 * Results are undefined if the calling thread holds the read-write lock
 * (whether a read or write lock) at the time the call is made.
 */
- (void)writeLock;

/**
 * Attempts to acquire a read lock (non-exclusive lock),
 * blocking a thread’s execution until the lock can be acquired.
 *
 * Results are undefined if the calling thread holds a write lock
 * at the time the call is made.
 */
- (void)readLock;

/**
 * This is an alias for tryWriteLock.
 */
- (BOOL)tryLock;

/**
 * Attempts to acquire a write lock, and immediately returns a Boolean
 * value that indicates whether the attempt was successful.
 */
- (BOOL)tryWriteLock;

/**
 * Attempts to acquire a read lock, and immediately returns a Boolean
 * value that indicates whether the attempt was successful.
 */
- (BOOL)tryReadLock;

/**
 * This is an alias for executeInWriteLock.
 */
- (void)executeInLock:(void(^)())block;

/**
 * Executes a block, wrapping it in a call to writeLock and unlock.
 */
- (void)executeInWriteLock:(void(^)())block;

/**
 * Executes a block, wrapping it in a call to readLock and unlock.
 */
- (void)executeInReadLock:(void(^)())block;

/**
 * This is an alias for tryToExecuteInWriteLock.
 */
- (BOOL)tryToExecuteInLock:(void(^)())block;

/**
 * Tries to execute a block, wrapping it in a call to tryWriteLock and unlock.
 *
 * Returns YES if it was able to obtain the lock and execute the block. Otherwise, returns NO.
 */
- (BOOL)tryToExecuteInWriteLock:(void(^)())block;

/**
 * Tries to execute a block, wrapping it in a call to tryReadLock and unlock.
 *
 * Returns YES if it was able to obtain the lock and execute the block. Otherwise, returns NO.
 */
- (BOOL)tryToExecuteInReadLock:(void(^)())block;

/**
 * Relinquishes a previously acquired lock.
 */
- (void)unlock;

@end
