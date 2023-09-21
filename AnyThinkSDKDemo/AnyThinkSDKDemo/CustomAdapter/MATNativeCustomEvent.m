//
//  MATNativeCustomEvent.m
//  AnyThinkSDKDemo
//
//  Created by root on 2023/9/20.
//  Copyright © 2023 抽筋的灯. All rights reserved.
//

#import "MATNativeCustomEvent.h"
#import "MaticooMediationTrackManager.h"
#import "MATNativeAdapter.h"
@import MaticooSDK;


@implementation MATNativeCustomEvent
- (void)nativeAdClicked:(nonnull MATNativeAd *)nativeAd {
    [self trackNativeAdClick];
    [MaticooMediationTrackManager trackMediationAdClick:nativeAd.placementID adType:NATIVE];
}

- (void)nativeAdClosed:(nonnull MATNativeAd *)nativeAd {
    [self trackNativeAdClosed];
}

- (void)nativeAdDisplayFailed:(nonnull MATNativeAd *)nativeAd {
    [MaticooMediationTrackManager trackMediationAdImpFailed:nativeAd.placementID adType:NATIVE];
}

- (void)nativeAdDisplayed:(nonnull MATNativeAd *)nativeAd {
    [self trackNativeAdImpression];
    [self trackNativeAdShow:NO];
    [MaticooMediationTrackManager trackMediationAdImp:nativeAd.placementID adType:NATIVE];
}

- (void)nativeAdFailed:(nonnull MATNativeAd *)nativeAd withError:(nonnull NSError *)error {
    self.requestCompletionBlock(nil, error);
//    [self trackNativeAdLoadFailed:error];
    [MaticooMediationTrackManager trackMediationAdRequestFailed:nativeAd.placementID adType:NATIVE];
}

- (void)nativeAdLoadSuccess:(nonnull MATNativeAd *)nativeAd {
    NSMutableArray<NSDictionary*>* assets = [NSMutableArray<NSDictionary*> array];
//    NSMutableDictionary *assets = [NSMutableDictionary dictionaryWithObjectsAndKeys:nativeAd, kATAdAssetsCustomObjectKey, nil];
    NSMutableDictionary *asset = [NSMutableDictionary dictionary];
    asset[kATAdAssetsCustomObjectKey] = nativeAd;
    asset[kATNativeADAssetsMainTitleKey] = nativeAd.nativeElements.title;
    asset[kATNativeADAssetsMainTextKey] = nativeAd.nativeElements.describe;
    asset[kATNativeADAssetsCTATextKey] = nativeAd.nativeElements.ctatext;
    asset[kATAdAssetsCustomEventKey] = self;
    if (nativeAd.nativeElements.brandLogo){
        NSData* brandLogoData = [[NSData alloc]initWithBase64EncodedString:nativeAd.nativeElements.brandLogo options:0];
        asset[kATNativeADAssetsLogoImageKey] = [UIImage imageWithData:brandLogoData];
    }
    if (nativeAd.nativeElements.iconUrl){
        dispatch_group_t image_download_group = dispatch_group_create();
        dispatch_group_enter(image_download_group);
               [[ATImageLoader shareLoader] loadImageWithURL:[NSURL URLWithString:nativeAd.nativeElements.iconUrl] completion:^(UIImage *image, NSError *error) {
                   if ([image isKindOfClass:[UIImage class]]) { asset[kATNativeADAssetsIconImageKey] = image; }
                   dispatch_group_leave(image_download_group);
       }];
    }
    [assets addObject:asset];

//    [self trackNativeAdLoaded:assets];
    self.requestCompletionBlock(assets, nil);
}

@end
