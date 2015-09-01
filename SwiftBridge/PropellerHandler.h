//
//  PropellerListener.h
//  SwiftBridge
//
//  Created by Dave Hards on 2015-08-28.
//  Copyright (c) 2015 Dave Hards. All rights reserved.
//

#ifndef SwiftBridge_PropellerHandler_h
#define SwiftBridge_PropellerHandler_h

@interface PropellerHandler : NSObject <PropellerSDKDelegate>


- (void)submitMatchResult:(long)score;

@end

#endif
