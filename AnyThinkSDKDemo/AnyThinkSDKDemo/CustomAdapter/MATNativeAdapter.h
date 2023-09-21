//
//  MATNativeAdapter.h
//  AnyThinkSDKDemo
//
//  Created by root on 2023/9/20.
//  Copyright © 2023 抽筋的灯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AnyThinkNative/AnyThinkNative.h>

NS_ASSUME_NONNULL_BEGIN

@interface MATNativeAdapter : NSObject <ATNativeAdapter>

@end

typedef NS_ENUM(NSUInteger, BrandLogoPosition) {
    ADCHOICES_TOP_RIGHT  = 1,
    ADCHOICES_BOTTOM_RIGHT,
    ADCHOICES_BOTTOM_LEFT
};

typedef NS_ENUM(NSUInteger, AdElement) {
    AD_TITLE        = 1,   //title
    AD_ICON         = 2,   //icon
    AD_SPONSORED    = 3,   //sponsored
    AD_DESCRIBE     = 4,   //describe
    AD_CTATEXT      = 5    //ctatext
};


@protocol MATNativeView;
@protocol MATNativeViewDelegate <NSObject>
- (void)nativeAdLoadSuccess:(id<MATNativeView>)nativeAd;
- (void)nativeAdFailed:(id<MATNativeView>)nativeAd withError:(NSError*)error;
- (void)nativeAdDisplayed:(id<MATNativeView>)nativeAd;
- (void)nativeAdDisplayFailed:(id<MATNativeView>)nativeAd;
- (void)nativeAdClicked:(id<MATNativeView>)nativeAd;
- (void)nativeAdClosed:(id<MATNativeView>)nativeAd;
@end

@protocol MATNativeAdElements
@property (nonatomic, strong) NSString* _Nullable title;
@property (nonatomic, strong) NSString* _Nullable iconUrl;
@property (nonatomic, strong) NSString* _Nullable sponsored;
@property (nonatomic, strong) NSString* _Nullable describe;
@property (nonatomic, strong) NSString* _Nullable ctatext;
@property (nonatomic, strong) NSString* _Nullable  brandLogo; //图片的base64字符串
@property (nonatomic, strong) UIView* _Nonnull mediaView;
@end

@protocol MATNativeView
@property (nonatomic, weak) id<MATNativeViewDelegate> delegate;
@property (nonatomic, strong) id<MATNativeView> nativeElements;
@property (nonatomic, assign, readonly) BOOL isTemplateAd;
@property (nonatomic, strong) NSString* placementID;

- (instancetype)initWithPlacementID:(NSString *)placementID;
- (void)loadAd;
- (void)loadAd:(NSString*)biddingRequestId;
- (void)nativeAdClosedReportWithReason:(NSString * _Nullable)reason; // for user Self-Rendering style ad
- (void)setAdTemplateStyle;
- (void)setAdSize:(CGSize)adSize;
- (void)setBrandLogoPositionOnAd:(BrandLogoPosition)logoPosition;
- (void)setRequiredAdElements:(AdElement)element,...;
- (void)setVideoIsMute:(BOOL)isMute;//mute video by default
- (void)registerViewForInteraction:( UIView * _Nonnull )AdView
                          iConView:(UIView * _Nullable)iConView
                       CTAView:(UIView * _Nullable)ctaView;
 

@end
NS_ASSUME_NONNULL_END
