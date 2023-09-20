//
//  MATRewardedVideoAdapter.m
//  AnyThinkSDKDemo
//
//  Created by root on 2023/9/19.
//  Copyright © 2023 抽筋的灯. All rights reserved.
//

#import "MATRewardedVideoAdapter.h"
#import "MaticooMediationTrackManager.h"

@import MaticooSDK;

@interface MATRewardedVideoCustomEvent : ATRewardedVideoCustomEvent <MATRewardedVideoAdDelegate>
@end

@implementation MATRewardedVideoCustomEvent
//rewarded video delegate
- (void)rewardedVideoAdDidLoad:(MATRewardedVideoAd *)rewardedVideoAd{
    NSLog(@"%s", __FUNCTION__);
    [self trackRewardedVideoAdLoaded:rewardedVideoAd adExtra:nil];
    [MaticooMediationTrackManager trackMediationAdRequestFilled:rewardedVideoAd.placementID adType:REWARDEDVIDEO];
}

- (void)rewardedVideoAd:(MATRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error{
    NSLog(@"%s", __FUNCTION__);
    [self trackRewardedVideoAdLoadFailed:error];
    [MaticooMediationTrackManager trackMediationAdRequestFailed:rewardedVideoAd.placementID adType:REWARDEDVIDEO];
}

- (void)rewardedVideoAd:(MATRewardedVideoAd *)rewardedVideoAd displayFailWithError:(NSError *)error{
    NSLog(@"%s", __FUNCTION__);
    [self trackRewardedVideoAdLoadFailed:error];
    [MaticooMediationTrackManager trackMediationAdImpFailed:rewardedVideoAd.placementID adType:REWARDEDVIDEO];
}

- (void)rewardedVideoAdStarted:(MATRewardedVideoAd *)rewardedVideoAd{
    NSLog(@"%s", __FUNCTION__);
    [self trackRewardedVideoAdVideoStart];
}

- (void)rewardedVideoAdCompleted:(MATRewardedVideoAd *)rewardedVideoAd{
    NSLog(@"%s", __FUNCTION__);
    [self trackRewardedVideoAdVideoEnd];
}

- (void)rewardedVideoAdWillLogImpression:(MATRewardedVideoAd *)rewardedVideoAd{
    NSLog(@"%s", __FUNCTION__);
    [self trackRewardedVideoAdShow];
    [MaticooMediationTrackManager trackMediationAdImp:rewardedVideoAd.placementID adType:REWARDEDVIDEO];
}

- (void)rewardedVideoAdDidClick:(MATRewardedVideoAd *)rewardedVideoAd{
    NSLog(@"%s", __FUNCTION__);
    [self trackRewardedVideoAdClick];
    [MaticooMediationTrackManager trackMediationAdClick:rewardedVideoAd.placementID adType:REWARDEDVIDEO];
}

- (void)rewardedVideoAdDidClose:(MATRewardedVideoAd *)rewardedVideoAd{
    NSLog(@"%s", __FUNCTION__);
    [self trackRewardedVideoAdCloseRewarded:self.rewardGranted extra:nil];
}

- (void)rewardedVideoAdReward:(MATRewardedVideoAd *)rewardedVideoAd{
    NSLog(@"%s", __FUNCTION__);
    [self trackRewardedVideoAdRewarded];
}

- (void)rewardedVideoAdWillClose:(nonnull MATRewardedVideoAd *)rewardedVideoAd {
    
}
@end

@interface MATRewardedVideoAdapter ()
@property (nonatomic, strong) MATRewardedVideoAd *rewardedVideoAd;
@property(nonatomic, readonly) MATRewardedVideoCustomEvent *customEvent;
@end


@implementation MATRewardedVideoAdapter

-(instancetype) initWithNetworkCustomInfo:(NSDictionary*)serverInfo localInfo:(NSDictionary*)localInfo {
    self = [super init];
    if (self != nil) {
        //TODO: add some code for initialize Network SDK
        [[MaticooAds shareSDK] setMediationName:@"topon"];
        NSString *appkey = serverInfo[@"appkey"];
        if (appkey){
            [[MaticooAds shareSDK] initSDK:appkey onSuccess:^() {
                [MaticooMediationTrackManager trackMediationInitSuccess];
            } onError:^(NSError* error) {
                [MaticooMediationTrackManager trackMediationInitFailed:error];
            }];
        }
    }
    return self;
}

/// Adapter sends a load request, means the ad source sends an ad load request
/// - Parameters:
///   - serverInfo: Data from the server
///   - localInfo: Data from the local
///   - completion: completion
-(void) loadADWithInfo:(NSDictionary*)serverInfo localInfo:(NSDictionary*)localInfo completion:(void (^)(NSArray<NSDictionary *> *, NSError *))completion {
    _customEvent =  [[MATRewardedVideoCustomEvent alloc] initWithInfo:serverInfo localInfo:localInfo];
    _customEvent.requestCompletionBlock = completion;
    
    NSString *placementIdentifier = serverInfo[@"placement_id"];
    if (placementIdentifier == nil){
        completion(nil, [NSError errorWithDomain:ATADLoadingErrorDomain code:ATADLoadingErrorCodeThirdPartySDKNotImportedProperly userInfo:@{NSLocalizedDescriptionKey:@"AT has failed to load rewarded video.", NSLocalizedFailureReasonErrorKey:@"placementid cannot be nill"}]);
        return;
    }
    [MaticooMediationTrackManager trackMediationAdRequest:placementIdentifier adType:REWARDEDVIDEO isAutoRefresh:NO];
    
    self.rewardedVideoAd = [[MATRewardedVideoAd alloc] initWithPlacementID: placementIdentifier];
    self.rewardedVideoAd.delegate = _customEvent;
    
    if ( [self.rewardedVideoAd isReady] )
    {
        completion(nil, nil);
    }
    else
    {
        [self.rewardedVideoAd loadAd];
    }
}

/// Check whether the ad source is ready
/// - Parameters:
///   - customObject: ad source object
///   - info: info
+(BOOL) adReadyWithCustomObject:(id)customObject info:(NSDictionary*)info {
    return [(MATRewardedVideoAd *)customObject isReady];
}

+(void) showRewardedVideo:(ATRewardedVideo*)rewardedVideo inViewController:(UIViewController*)viewController delegate:(id<ATRewardedVideoDelegate>)delegate {
    MATRewardedVideoCustomEvent *customEvent = (MATRewardedVideoCustomEvent*)rewardedVideo.customEvent;
    customEvent.delegate = delegate;
    [((MATRewardedVideoAd *)rewardedVideo.customObject) showAdFromViewController:viewController];
}


@end
