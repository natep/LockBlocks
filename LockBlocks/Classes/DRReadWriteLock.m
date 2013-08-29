//
//  DRReadWriteLock.m
//  DRReadWriteLock
//
//  Created by Nate Petersen on 8/27/13.
//  Copyright (c) 2013 Digital Rickshaw. All rights reserved.
//

#import "DRReadWriteLock.h"
#import <pthread.h>

@interface DRReadWriteLock () {
	pthread_rwlock_t rwlock;
}

@end


@implementation DRReadWriteLock

- (id)init {
	if ((self = [super init])) {
		
		int result = pthread_rwlock_init(&rwlock, NULL);
		
		if (result) {
			[NSException raise:@"Lock exception" format:@"Error creating lock - returned: %d", result];
		}
	}
	
	return self;
}

- (void)dealloc {
	int result = pthread_rwlock_destroy(&rwlock);
	
	if (result) {
		[NSException raise:@"Lock exception" format:@"Error destroying lock - returned: %d", result];
	}
}

- (void)lock {
	[self writeLock];
}

- (BOOL)tryLock {
	return [self tryWriteLock];
}

- (void)writeLock {
	int result = pthread_rwlock_wrlock(&rwlock);
	
	if (result) {
		[NSException raise:@"Lock exception" format:@"Error getting write lock - returned: %d", result];
	}
}

- (void)executeInLock:(void(^)())block {
	[self executeInWriteLock:block];
}

- (BOOL)tryToExecuteInLock:(void(^)())block {
	return [self tryToExecuteInWriteLock:block];
}

- (BOOL)tryWriteLock {
	int result = pthread_rwlock_trywrlock(&rwlock);
	
	if (!result) {
		return YES;
	} else if (result == EBUSY) {
		return NO;
	} else {
		[NSException raise:@"Lock exception" format:@"Error trying write lock - returned: %d", result];
		return NO;
	}
}

- (void)executeInWriteLock:(void(^)())block {
	[self writeLock];
	block();
	[self unlock];
}

- (BOOL)tryToExecuteInWriteLock:(void(^)())block {
	if ([self tryWriteLock]) {
		block();
		[self unlock];
		return YES;
	} else {
		return NO;
	}
}

- (void)readLock {
	int result = pthread_rwlock_rdlock(&rwlock);
	
	if (result) {
		[NSException raise:@"Lock exception" format:@"Error getting read lock - returned: %d", result];
	}
}

- (BOOL)tryReadLock {
	int result = pthread_rwlock_tryrdlock(&rwlock);
	
	if (!result) {
		return YES;
	} else if (result == EBUSY) {
		return NO;
	} else {
		[NSException raise:@"Lock exception" format:@"Error trying write lock - returned: %d", result];
		return NO;
	}
}

- (void)executeInReadLock:(void(^)())block {
	[self readLock];
	block();
	[self unlock];
}

- (BOOL)tryToExecuteInReadLock:(void(^)())block {
	if ([self tryReadLock]) {
		block();
		[self unlock];
		return YES;
	} else {
		return NO;
	}
}

- (void)unlock {
	int result = pthread_rwlock_unlock(&rwlock);
	
	if (result) {
		[NSException raise:@"Lock exception" format:@"Error releasing lock - returned: %d", result];
	}
}

@end
