//
//  MATBannerAdapter.h
//  AnyThinkSDKDemo
//
//  Created by root on 2023/9/20.
//  Copyright © 2023 root. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AnyThinkBanner/AnyThinkBanner.h>        // 引入头文件

NS_ASSUME_NONNULL_BEGIN

@interface MATBannerAdapter : NSObject <ATBannerDelegate>

@end

@protocol MATBannerView;
@protocol MATBannerViewDelegate
@optional
- (void)bannerAdDidLoad:(id<MATBannerView>)bannerAd;
- (void)bannerAd:(id<MATBannerView>)bannerAd didFailWithError:(NSError *)error;
- (void)bannerAdDidImpression:(id<MATBannerView>) bannerAd;
- (void)bannerAdDidClick:(id<MATBannerView>) bannerAd;
- (void)bannerAdDismissed:(id<MATBannerView>) bannerAd;
@end

@protocol MATBannerView
@property (nonatomic, weak) id<MATBannerViewDelegate> delegate;
@property (nonatomic, strong) NSString* placementID;
@property (nonatomic) CGRect frame;
- (instancetype)initWithPlacementID:(NSString*)placementID;
- (void)loadAd;
- (void)loadAd:(NSString*)biddingRequestId;
@end



NS_ASSUME_NONNULL_END
