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
    MATNativeAd *nativeAd = offer.assets[kATAdAssetsCustomObjectKey];
    self.mediaView = nativeAd.nativeElements.mediaView;
    if (self.mediaView){
        [self.ADView addSubview:self.mediaView];
    }else{
        [self.ADView addSubview:nativeAd];
        self.mediaView = nativeAd;
    }
//    if (nativeAd.isTemplateAd){
        self.mediaView.center = CGPointMake(CGRectGetMidX(self.ADView.bounds), CGRectGetMidY(self.ADView.bounds));
//    }
    [nativeAd registerViewForInteraction:self.ADView iConView:nil CTAView:nil];

}

-(__kindof UIView*)createMediaView {
    return self.mediaView;
}

//-(BOOL)isVideoContents {
//    return YES;
//}

@end
