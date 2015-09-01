//
//  PropellerListener.m
//  SwiftBridge
//
//  Created by Dave Hards on 2015-08-28.
//  Copyright (c) 2015 Dave Hards. All rights reserved.
//

#import "PropellerSDK/PropellerSDK.h"
#import "PropellerHandler.h"


@interface PropellerHandler ()
{
    NSString *tournID;
    NSString *matchID;
    
    long seed;
    int round;
    BOOL adsAllowed;
    BOOL fairPlay;
    
    NSDictionary *options;
    
    NSDictionary *you;
    NSString *yourNickname;
    NSString *yourAvatarURL;
    
    NSDictionary *them;
    NSString *theirNickname;
    NSString *theirAvatarURL;
}
@end


@implementation PropellerHandler

- (id)init
{
    if (self = [super init])
    {
        // register an observer with the notification center for challenge
        // count updates when the game main menu is initialized
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveChallengeCount:)
                                                     name:@"PropellerSDKChallengeCountChanged"
                                                   object:nil];
        
    }
    return self;
}

- (void)dealloc
{
    
    // unregister the observer from the notification center for challenge
    // count updates when the game main menu is cleaned up
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)receiveChallengeCount:(NSNotification *) notification
{
    NSDictionary *userInfo = notification.userInfo;
    int count = [[userInfo objectForKey:@"count"] integerValue];
    
    NSNumber *_count = [NSNumber numberWithInt:count];
    
    // update the main menu multiplayer button challenge counter with the new challenge count
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PropellerSDKReceivedChallengeCount" object:_count];
    
    // update the application icon badge number
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:count];
}

- (void)sdkCompletedWithExit
{
    NSLog(@"sdkCompletedWithExit");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PropellerSDKCompletedWithExit" object:nil];

}

- (void)sdkCompletedWithMatch:(NSDictionary*)match
{
    NSLog(@"sdkCompletedWithMatch");
    
    tournID = [match objectForKey:PSDK_MATCH_RESULT_TOURNAMENT_KEY];
    matchID = [match objectForKey:PSDK_MATCH_RESULT_MATCH_KEY];
    
    NSDictionary *params = [match objectForKey:PSDK_MATCH_RESULT_PARAMS_KEY];
    
    seed = [[params objectForKey:@"seed"] longValue];
    round = [[params objectForKey:@"round"] integerValue];
    adsAllowed = [[params objectForKey:@"adsAllowed"] boolValue];
    fairPlay = [[params objectForKey:@"fairPlay"] boolValue];
    
    options = [params objectForKey:@"options"];
    
    you = [params objectForKey:@"you"];
    yourNickname = [you objectForKey:@"name"];
    yourAvatarURL = [you objectForKey:@"avatar"];
    
    them = [params objectForKey:@"them"];
    theirNickname = [them objectForKey:@"name"];
    theirAvatarURL = [them objectForKey:@"avatar"];
    
    // play the game for the given match data
    //[self startGame];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PropellerSDKCompletedWithMatch" object:nil];
}

- (void)sdkFailed:(NSDictionary*)result
{
    NSLog(@"sdkFailed");
    
}

- (void)submitMatchResult:(long)score
{
    // construct the match results dictionary using the cached match
    // data obtained from the sdkCompletedWithMatch() callback
    NSMutableDictionary *matchResult = [[NSMutableDictionary alloc] init];
    [matchResult setObject:tournID forKey:PSDK_MATCH_POST_TOURNAMENT_KEY];
    [matchResult setObject:matchID forKey:PSDK_MATCH_POST_MATCH_KEY];
    
    // the raw score will be used to compare results
    // between match players. This should be a positive
    // integer value
    NSNumber *numberScore = [NSNumber numberWithLong:score];
    [matchResult setObject:numberScore forKey:PSDK_MATCH_POST_SCORE_KEY];
    
    // specify a visual score to represent the raw score
    // in a different format in the UI. If no visual score
    // is provided then the raw score will be used
    [matchResult setObject:[numberScore stringValue] forKey:PSDK_MATCH_POST_VISUALSCORE_KEY];
    
    PropellerSDK *propellerSDK = [PropellerSDK instance];
    
    // post the match results to the Propeller SDK
    [propellerSDK submitMatchResult:matchResult];
    
    //[matchResult release];
}


@end