//
//  MATSplashAdapter.m
//  AnyThinkSDKDemo
//
//  Created by xuge on 2025/4/7.
//  Copyright © 2025 抽筋的灯. All rights reserved.
//

#import "MATSplashAdapter.h"
#import "MaticooMediationTrackManager.h"
@import MaticooSDK;

@interface MATSplashCustomEvent : ATSplashCustomEvent <MATInterstitialAdDelegate>
@end

@implementation MATSplashCustomEvent
- (void)interstitialAdDidLoad:(MATInterstitialAd *)interstitialAd{
    NSLog(@"[MATAdapter], %s", __FUNCTION__);
    [self trackSplashAdLoaded:interstitialAd adExtra:nil];
    [MaticooMediationTrackManager trackMediationAdRequestFilled:interstitialAd.placementID adType:SPLASH];
}

- (void)interstitialAd:(MATInterstitialAd *)interstitialAd didFailWithError:(NSError *)error{
    NSLog(@"[MATAdapter], %s", __FUNCTION__);
    [self trackSplashAdLoadFailed:error];
    NSString * msg = @"";
    if(error){
        msg = error.description;
    }
    [MaticooMediationTrackManager trackMediationAdRequestFailed:interstitialAd.placementID adType:SPLASH msg:msg];
}

- (void)interstitialAdWillLogImpression:(MATInterstitialAd *)interstitialAd{
    NSLog(@"[MATAdapter], %s", __FUNCTION__);
    [self trackSplashAdShow];
    [MaticooMediationTrackManager trackMediationAdImp:interstitialAd.placementID adType:SPLASH];
}

- (void)interstitialAdDidClick:(MATInterstitialAd *)interstitialAd{
    NSLog(@"[MATAdapter], %s", __FUNCTION__);
    [self trackSplashAdClick];
    [MaticooMediationTrackManager trackMediationAdClick:interstitialAd.placementID adType:SPLASH];
}

//did click close button
- (void)interstitialAdDidClose:(MATInterstitialAd *)interstitialAd{
    NSLog(@"[MATAdapter], %s", __FUNCTION__);
    [self trackSplashAdClosed:nil];
}

- (void)interstitialAd:(MATInterstitialAd *)interstitialAd displayFailWithError:(NSError *)error{
    NSLog(@"[MATAdapter], %s", __FUNCTION__);
    [self trackSplashAdShowFailed: error];
    NSString * msg = @"";
    if(error){
        msg = error.description;
    }
    [MaticooMediationTrackManager trackMediationAdImpFailed:interstitialAd.placementID adType:SPLASH msg:msg];
}

- (void)interstitialAdWillClose:(nonnull MATInterstitialAd *)interstitialAd {
    NSLog(@"[MATAdapter], %s", __FUNCTION__);
}

@end

@interface MATSplashAdapter()
@property(nonatomic, readonly) MATSplashCustomEvent *customEvent;
@property (nonatomic, strong) MATInterstitialAd *interstitial;
@end

@implementation MATSplashAdapter

-(instancetype) initWithNetworkCustomInfo:(NSDictionary*)serverInfo localInfo:(NSDictionary*)localInfo {
    self = [super init];
    if (self != nil) {
    //TODO: add some code for initialize Network SDK
    }
    return self;
}

/// Adapter sends a load request, means the ad source sends an ad load request
/// - Parameters:
///   - serverInfo: Data from the server
///   - localInfo: Data from the local
///   - completion: completion
-(void) loadADWithInfo:(NSDictionary*)serverInfo localInfo:(NSDictionary*)localInfo completion:(void (^)(NSArray<NSDictionary *> *, NSError *))completion {
    _customEvent = [[MATSplashCustomEvent alloc] initWithInfo:serverInfo localInfo:localInfo];
    _customEvent.requestCompletionBlock = completion;
    
    NSString *placementIdentifier = serverInfo[@"placement_id"];
    if (placementIdentifier == nil){
        completion(nil, [NSError errorWithDomain:ATADLoadingErrorDomain code:ATAdErrorCodeThirdPartySDKNotImportedProperly userInfo:@{NSLocalizedDescriptionKey:@"AT has failed to load interstitial.", NSLocalizedFailureReasonErrorKey:@"placementid cannot be nill"}]);
        return;
    }
    
    [[MaticooAds shareSDK] setMediationName:@"topon"];
    NSString *appkey = serverInfo[@"appkey"];
    if (appkey){
        [[MaticooAds shareSDK] initSDK:appkey onSuccess:^() {
            [MaticooMediationTrackManager trackMediationInitSuccess];
            self.interstitial = [[MATInterstitialAd alloc] initWithPlacementID:placementIdentifier];
            self.interstitial.delegate = self->_customEvent;
            
            if(localInfo != nil && localInfo.count > 0){
                [self.interstitial setLocalExtra:[MaticooMediationTrackManager ensureParams:localInfo]];
            }
            [self.interstitial loadAd];
            [MaticooMediationTrackManager trackMediationAdRequest:placementIdentifier adType:SPLASH isAutoRefresh:NO];
        } onError:^(NSError* error) {
            [MaticooMediationTrackManager trackMediationInitFailed:error];
            completion(nil,error);
        }];
    }
}

+(BOOL) adReadyWithCustomObject:(id)customObject info:(NSDictionary*)info {
   return [((MATInterstitialAd *)customObject) isReady];
}

+ (void)showSplash:(ATSplash *)splash localInfo:(NSDictionary *)localInfo delegate:(id)delegate {
    MATInterstitialAd *ttInterstitial = splash.customObject;
    splash.customEvent.delegate = delegate;
    [ttInterstitial showAdFromRootViewController];
}

@end
