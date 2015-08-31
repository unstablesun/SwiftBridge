//
//  PropellerListener.m
//  SwiftBridge
//
//  Created by Dave Hards on 2015-08-28.
//  Copyright (c) 2015 Dave Hards. All rights reserved.
//

#import "PropellerSDK/PropellerSDK.h"
#import "PropellerListener.h"

@interface PropellerListener ()
{
    NSString *_tournID;
    NSString *_matchID;
}
@end

@implementation PropellerListener




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
    
    // update the main menu multiplayer button challenge counter with the new challenge count
    
    // update the application icon badge number
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:count];
}




- (void)sdkCompletedWithExit
{
    NSLog(@"sdkCompletedWithExit");
    
}

- (void)sdkCompletedWithMatch:(NSDictionary*)match
{
    NSLog(@"sdkCompletedWithMatch");
    
    _tournID = [match objectForKey:PSDK_MATCH_RESULT_TOURNAMENT_KEY];
    _matchID = [match objectForKey:PSDK_MATCH_RESULT_MATCH_KEY];
    
    
    NSDictionary *params = [match objectForKey:PSDK_MATCH_RESULT_PARAMS_KEY];
    
    long seed = [[params objectForKey:@"seed"] longValue];
    
    int round = [[params objectForKey:@"round"] integerValue];
    
    BOOL adsAllowed = [[params objectForKey:@"adsAllowed"] boolValue];
    
    BOOL fairPlay = [[params objectForKey:@"fairPlay"] boolValue];
    
    NSDictionary *options = [params objectForKey:@"options"];
    
    NSDictionary *you = [params objectForKey:@"you"];
    NSString *yourNickname = [you objectForKey:@"name"];
    NSString *yourAvatarURL = [you objectForKey:@"avatar"];
    
    NSDictionary *them = [params objectForKey:@"them"];
    NSString *theirNickname = [them objectForKey:@"name"];
    NSString *theirAvatarURL = [them objectForKey:@"avatar"];
    
    // play the game for the given match data
    //[self startGame];

    
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
    [matchResult setObject:_tournID forKey:PSDK_MATCH_POST_TOURNAMENT_KEY];
    [matchResult setObject:_matchID forKey:PSDK_MATCH_POST_MATCH_KEY];
    
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