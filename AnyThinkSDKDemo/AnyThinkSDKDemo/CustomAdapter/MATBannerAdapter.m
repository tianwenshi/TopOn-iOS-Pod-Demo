//
//  MATBannerAdapter.m
//  AnyThinkSDKDemo
//
//  Created by root on 2023/9/20.
//  Copyright © 2023 root. All rights reserved.
//

#import "MATBannerAdapter.h"
#import "MaticooMediationTrackManager.h"

@import MaticooSDK;

@interface MATBannerCustomEvent : ATBannerCustomEvent <MATBannerViewDelegate>
@end

@implementation MATBannerCustomEvent
- (void)bannerAdDidLoad:(MATBannerAd *)nativeBannerAd{
    [self trackBannerAdLoaded:nativeBannerAd adExtra:nil];
    [MaticooMediationTrackManager trackMediationAdRequestFilled:nativeBannerAd.placementID adType:BANNER];
}

- (void)bannerAd:(nonnull MATBannerAd *)nativeBannerAd didFailWithError:(nonnull NSError *)error {
    [self handleLoadingFailure:error];
    [MaticooMediationTrackManager trackMediationAdRequestFailed:nativeBannerAd.placementID adType:BANNER];
}

- (void)bannerAdDidClick:(nonnull MATBannerAd *)banner {
    [self trackBannerAdClick];
    [MaticooMediationTrackManager trackMediationAdClick:banner.placementID adType:BANNER];
}

- (void)bannerAdDidImpression:(nonnull MATBannerAd *)banner {
    [self trackBannerAdImpression];
    [MaticooMediationTrackManager trackMediationAdImp:banner.placementID adType:BANNER];
}

- (void)bannerAdDismissed:(nonnull MATBannerAd *)bannerAd{
    [self trackBannerAdClosed];
}

- (NSString *)networkUnitId {
    return self.serverInfo[@"placement_id"];
}
@end

@interface MATBannerAdapter()
@property (nonatomic, readonly) MATBannerCustomEvent *customEvent;
@property(nonatomic, readonly) id<MATBannerView> bannerAd;;
@end

@implementation MATBannerAdapter
-(instancetype) initWithNetworkCustomInfo:(NSDictionary*)serverInfo localInfo:(NSDictionary*)localInfo {
    self = [super init];
    if (self != nil) {
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

-(void) loadADWithInfo:(NSDictionary*)serverInfo localInfo:(NSDictionary*)localInfo completion:(void (^)(NSArray<NSDictionary *> *, NSError *))completion {

    NSDictionary *extraInfo = localInfo;
    CGSize adSize = [extraInfo[kATAdLoadingExtraBannerAdSizeKey] respondsToSelector:@selector(CGSizeValue)] ? [extraInfo[kATAdLoadingExtraBannerAdSizeKey] CGSizeValue] : CGSizeMake(320.0f, 50.0f);

    _customEvent = [[MATBannerCustomEvent alloc] initWithInfo:serverInfo localInfo:localInfo];
    _customEvent.requestCompletionBlock = completion;
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *placementIdentifier = serverInfo[@"placement_id"];
        if (placementIdentifier == nil){
            completion(nil, [NSError errorWithDomain:ATADLoadingErrorDomain code:ATADLoadingErrorCodeThirdPartySDKNotImportedProperly userInfo:@{NSLocalizedDescriptionKey:@"AT has failed to banner.", NSLocalizedFailureReasonErrorKey:@"placementid cannot be nill"}]);
            return;
        }
        self->_bannerAd = [[NSClassFromString(@"MATBannerAd") alloc] initWithPlacementID:placementIdentifier];
//        self->_bannerAd = [[MATBannerAd alloc] initWithPlacementID:serverInfo[@"placement_id"]];
        self->_bannerAd.delegate = self->_customEvent;
        [self->_bannerAd loadAd];
        self->_bannerAd.frame = CGRectMake(0, 0, adSize.width, adSize.width);

        [MaticooMediationTrackManager trackMediationInitSuccess];
        [MaticooMediationTrackManager trackMediationAdRequest:placementIdentifier adType:BANNER isAutoRefresh:NO];
    });
}

+(void) showBanner:(ATBanner*)banner inView:(UIView*)view presentingViewController:(UIViewController*)viewController {
    //展示banner
    MATBannerAd* bannerView = banner.bannerView;
    bannerView.frame = CGRectMake(0, 0, bannerView.frame.size.width, bannerView.frame.size.height);
}
@end
