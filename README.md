LockBlocks
==========

Overview
--------

LockBlocks adds block methods to Objective-C Lock objects. It also adds a Read/Write Lock class.

Usage
-----

Instead of making a call like this:

	[myLock lock];

	... critical code ...
	
	[myLock unlock];

With LockBlocks you use the block-based methods that call lock and unlock for you:

	[myLock executeInLock:^{
		... critical code ...
	}];

This more clearly delineates what is a critical section of your code, and helps avoid forgetting to release the lock.

Installation
------------

I highly recommend that you use CocoaPods to integrate LockBlocks into your app. If you aren't familiar with it,
CocoaPods is an awesomely simple dependency manager for Objective-C projects. You can get more info about it [here](http://cocoapods.org).

If you're using CocoaPods, all you have to do is put this line in your Podfile:

	pod 'LockBlocks',	'0.0.1'

And you're done.

***

If you aren't using CocoaPods (Why not? What's your problem??) then you'll have to just grab the LockBlocks
source and drop it into your project.

Caveats
-------

LockBlocks version 0.0.1 is still a beta release. Some of the methods have not been thoroughly tested.
Use at your own risk, and please file a bug if you encounter any problems.

Contact
-------

If you end up using LockBlocks in a project, I'd love to hear about it.

email: [nate@digitalrickshaw.com](mailto:nate@digitalrickshaw.com)  
twitter: [@nate_petersen](https://twitter.com/nate_petersen)
