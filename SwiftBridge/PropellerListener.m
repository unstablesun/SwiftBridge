//
//  PropellerListener.m
//  SwiftBridge
//
//  Created by Dave Hards on 2015-08-28.
//  Copyright (c) 2015 Dave Hards. All rights reserved.
//

#import "PropellerSDK/PropellerSDK.h"

@interface PropellerListener : NSObject <PropellerSDKDelegate>

@end


@implementation PropellerListener

- (void)sdkCompletedWithExit
{
    
}

- (void)sdkCompletedWithMatch:(NSDictionary*)match
{
    
}

- (void)sdkFailed:(NSDictionary*)result
{
    
}

@end