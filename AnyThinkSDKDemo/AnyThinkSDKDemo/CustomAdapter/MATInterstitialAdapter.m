//
//  MATInterstitialAdapter.m
//  AnyThinkSDKDemo
//
//  Created by root on 2023/9/20.
//  Copyright © 2023 抽筋的灯. All rights reserved.
//

#import "MATInterstitialAdapter.h"
#import "MaticooMediationTrackManager.h"
@import MaticooSDK;

@interface MATInterstitialCustomEvent : ATInterstitialCustomEvent <MATInterstitialAdDelegate>
@end

@implementation MATInterstitialCustomEvent
- (void)interstitialAdDidLoad:(MATInterstitialAd *)interstitialAd{
    NSLog(@"%s", __FUNCTION__);
    [self trackInterstitialAdLoaded:interstitialAd adExtra:nil];
    [MaticooMediationTrackManager trackMediationAdRequestFilled:interstitialAd.placementID adType:INTERSTITIAL];
}

- (void)interstitialAd:(MATInterstitialAd *)interstitialAd didFailWithError:(NSError *)error{
    NSLog(@"%s", __FUNCTION__);
    [self trackInterstitialAdLoadFailed:error];
    [MaticooMediationTrackManager trackMediationAdRequestFailed:interstitialAd.placementID adType:INTERSTITIAL];
}

- (void)interstitialAdWillLogImpression:(MATInterstitialAd *)interstitialAd{
    NSLog(@"%s", __FUNCTION__);
    [self trackInterstitialAdShow];
    [MaticooMediationTrackManager trackMediationAdImp:interstitialAd.placementID adType:INTERSTITIAL];
}

- (void)interstitialAdDidClick:(MATInterstitialAd *)interstitialAd{
    NSLog(@"%s", __FUNCTION__);
    [self trackInterstitialAdClick];
    [MaticooMediationTrackManager trackMediationAdClick:interstitialAd.placementID adType:INTERSTITIAL];
}

//did click close button
- (void)interstitialAdDidClose:(MATInterstitialAd *)interstitialAd{
    NSLog(@"%s", __FUNCTION__);
    [self trackInterstitialAdClose:nil];
}

- (void)interstitialAd:(MATInterstitialAd *)interstitialAd displayFailWithError:(NSError *)error{
    NSLog(@"%s", __FUNCTION__);
    [self trackInterstitialAdShowFailed: error];
    [MaticooMediationTrackManager trackMediationAdImpFailed:interstitialAd.placementID adType:INTERSTITIAL];
}

- (void)interstitialAdWillClose:(nonnull MATInterstitialAd *)interstitialAd {
    NSLog(@"%s", __FUNCTION__);
}

@end

@interface MATInterstitialAdapter()
@property(nonatomic, readonly) MATInterstitialCustomEvent *customEvent;
@property (nonatomic, strong) MATInterstitialAd *interstitial;
@end

@implementation MATInterstitialAdapter

/// Adapter initialization method
/// - Parameters:
///   - serverInfo: Data from the server
///   - localInfo: Data from the local
-(instancetype) initWithNetworkCustomInfo:(NSDictionary*)serverInfo localInfo:(NSDictionary*)localInfo {
    self = [super init];
    if (self != nil) {
    //TODO: add some code for initialize Network SDK
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
    _customEvent = [[MATInterstitialCustomEvent alloc] initWithInfo:serverInfo localInfo:localInfo];
    _customEvent.requestCompletionBlock = completion;
    
    NSString *placementIdentifier = serverInfo[@"placement_id"];
    if (placementIdentifier == nil){
        completion(nil, [NSError errorWithDomain:ATADLoadingErrorDomain code:ATADLoadingErrorCodeThirdPartySDKNotImportedProperly userInfo:@{NSLocalizedDescriptionKey:@"AT has failed to load rewarded video.", NSLocalizedFailureReasonErrorKey:@"placementid cannot be nill"}]);
        return;
    }

    _interstitial = [[MATInterstitialAd alloc] initWithPlacementID:placementIdentifier];
    _interstitial.delegate = _customEvent;
    [_interstitial loadAd];
    [MaticooMediationTrackManager trackMediationAdRequest:placementIdentifier adType:INTERSTITIAL isAutoRefresh:NO];
}

+(BOOL) adReadyWithCustomObject:(id)customObject info:(NSDictionary*)info {
   return [((MATInterstitialAd *)customObject) isReady];
}


+(void) showInterstitial:(ATInterstitial*)interstitial inViewController:(UIViewController*)viewController delegate:(id<ATInterstitialDelegate>)delegate {
    MATInterstitialAd *ttInterstitial = interstitial.customObject;
    interstitial.customEvent.delegate = delegate;
    [ttInterstitial showAdFromViewController:viewController];
}

@end
