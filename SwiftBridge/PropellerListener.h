//
//  PropellerListener.h
//  SwiftBridge
//
//  Created by Dave Hards on 2015-08-28.
//  Copyright (c) 2015 Dave Hards. All rights reserved.
//

#ifndef SwiftBridge_PropellerListener_h
#define SwiftBridge_PropellerListener_h

@interface PropellerListener : NSObject <PropellerSDKDelegate>


- (void)submitMatchResult:(long)score;

@end

#endif
