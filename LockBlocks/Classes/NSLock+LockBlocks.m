//
//  NSLock+LockBlocks.m
//  DRReadWriteLock
//
//  Created by Nate Petersen on 8/29/13.
//  Copyright (c) 2013 Digital Rickshaw. All rights reserved.
//

#import "NSLock+LockBlocks.h"

@implementation NSLock (LockBlocks)

- (void)executeInLock:(void(^)())block {
	[self lock];
	@try {
		block();
	}
	@finally {
		[self unlock];
	}
}

- (BOOL)tryToExecuteInLock:(void(^)())block {
	if ([self tryLock]) {
		@try {
			block();
		}
		@finally {
			[self unlock];
		}
		return YES;
	} else {
		return NO;
	}
}

@end
