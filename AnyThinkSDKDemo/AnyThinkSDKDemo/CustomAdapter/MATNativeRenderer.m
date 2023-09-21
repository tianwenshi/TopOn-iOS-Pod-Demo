//
//  MATNativeRenderer.m
//  AnyThinkSDKDemo
//
//  Created by root on 2023/9/20.
//  Copyright © 2023 root. All rights reserved.
//

#import "MATNativeRenderer.h"
@import MaticooSDK;

@interface MATNativeRenderer()
@property (nonatomic, strong) UIView *mediaView;
@end

@implementation MATNativeRenderer

-(void) renderOffer:(ATNativeADCache *)offer {
    [super renderOffer:offer];
    _customEvent = offer.assets[kATAdAssetsCustomEventKey];
    _customEvent.adView = self.ADView;
    self.ADView.customEvent = _customEvent;
//    [self.ADView detatchRelatedView];
    
    MATNativeAd *nativeAd = offer.assets[kATAdAssetsCustomObjectKey];
    self.mediaView = nativeAd.nativeElements.mediaView;
    if (self.mediaView){
        [self.ADView addSubview:self.mediaView];
    }else{
        [self.ADView addSubview:nativeAd];
        self.mediaView = nativeAd;
    }
    self.mediaView.center = CGPointMake(CGRectGetMidX(self.ADView.bounds), CGRectGetMidY(self.ADView.bounds));
    [nativeAd registerViewForInteraction:self.ADView iConView:nil CTAView:nil];
//    nativeAd.delegate = _customEvent;
    
    // 由于穿山甲模板广告设置delegate需要在 BUNativeExpressAdManager 中，所以使用了自定义key tt_nativeexpress_manager 进行透传设置
//    BUNativeExpressAdManager *nativeExpressAd = (BUNativeExpressAdManager *)offer.assets[@"tt_nativeexpress_manager"];
//    nativeExpressAd.delegate = _customEvent;
//    BUNativeExpressAdView *nativeFeed = offer.assets[kAdAssetsCustomObjectKey];
//    nativeFeed.rootViewController = self.configuration.rootViewController;
//    [nativeFeed render];
//    [self.ADView addSubview:(UIView*)nativeFeed];
//    nativeFeed.center = CGPointMake(CGRectGetMidX(self.ADView.bounds), CGRectGetMidY(self.ADView.bounds));

}

-(__kindof UIView*)createMediaView {
    return self.mediaView;
}

@end
