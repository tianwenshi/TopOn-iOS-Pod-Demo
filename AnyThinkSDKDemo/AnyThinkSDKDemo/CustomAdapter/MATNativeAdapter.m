//
//  MATNativeAdapter.m
//  AnyThinkSDKDemo
//
//  Created by root on 2023/9/20.
//  Copyright © 2023 root. All rights reserved.
//

#import "MATNativeAdapter.h"
#import "MaticooMediationTrackManager.h"
#import "MATNativeCustomEvent.h"
#import "MATNativeRenderer.h"
@import MaticooSDK;

@interface MATNativeAdapter()
@property (nonatomic, readonly) MATNativeCustomEvent *customEvent;
@property(nonatomic, strong) id<MATNativeView> nativeAd;
@end

@implementation MATNativeAdapter
-(instancetype) initWithNetworkCustomInfo:(NSDictionary*)serverInfo localInfo:(NSDictionary*)localInfo {
    self = [super init];
    if (self != nil) {
//        [[MaticooAds shareSDK] setMediationName:@"topon"];
//        NSString *appkey = serverInfo[@"appkey"];
//        if (appkey){
//            [[MaticooAds shareSDK] initSDK:appkey onSuccess:^() {
//                [MaticooMediationTrackManager trackMediationInitSuccess];
//            } onError:^(NSError* error) {
//                [MaticooMediationTrackManager trackMediationInitFailed:error];
//            }];
//        }
    }
    return self;
}

-(void) loadADWithInfo:(NSDictionary*)serverInfo localInfo:(NSDictionary*)localInfo completion:(void (^)(NSArray<NSDictionary *> *, NSError *))completion {
    _customEvent = [MATNativeCustomEvent new];
    _customEvent.requestCompletionBlock = completion;

    NSString *placementIdentifier = serverInfo[@"placement_id"];
    if (placementIdentifier == nil){
        completion(nil, [NSError errorWithDomain:ATADLoadingErrorDomain code:ATADLoadingErrorCodeThirdPartySDKNotImportedProperly userInfo:@{NSLocalizedDescriptionKey:@"AT has failed to banner.", NSLocalizedFailureReasonErrorKey:@"placementid cannot be nill"}]);
        return;
    }
    
    [[MaticooAds shareSDK] setMediationName:@"topon"];
    NSString *appkey = serverInfo[@"appkey"];
    if (appkey){
        [[MaticooAds shareSDK] initSDK:appkey onSuccess:^() {
            [MaticooMediationTrackManager trackMediationInitSuccess];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.nativeAd = [[NSClassFromString(@"MATNativeAd") alloc] initWithPlacementID:placementIdentifier];
                self.nativeAd.delegate = self->_customEvent;
                CGSize size = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds) - 30.0f, 200.0f);
//                NSDictionary *extraInfo = localInfo;
//                CGSize size = [extraInfo[kExtraInfoNativeAdSizeKey] respondsToSelector:@selector(CGSizeValue)] ? [extraInfo[kATExtraInfoNativeAdSizeKeykATExtraInfoNativeAdSizeKey] CGSizeValue] : CGSizeMake(320.0f, 250.0f);
//                NSString *sizeKey = [serverInfo[@"media_size"] integerValue] > 0 ? @{@2:kATExtraNativeImageSize228_150, @1:kATExtraNativeImageSize690_388}[serverInfo[@"media_size"]] : extraInfo[kATExtraNativeImageSizeKey];
//                NSInteger imgSize = [@{kATExtraNativeImageSize228_150:@9, kATExtraNativeImageSize690_388:@10}[sizeKey] integerValue];
                [self.nativeAd setAdSize:size];
                [self.nativeAd loadAd];
            });
        } onError:^(NSError* error) {
            [MaticooMediationTrackManager trackMediationInitFailed:error];
            completion(nil,error);
        }];
    }
    

    
//    NSDictionary *extraInfo = localInfo;
//    _customEvent.requestExtra = extraInfo;
//    NSString *sizeKey = [serverInfo[@"media_size"] integerValue] > 0 ? @{@2:kATExtraNativeImageSize228_150, @1:kATExtraNativeImageSize690_388}[serverInfo[@"media_size"]] : extraInfo[kATExtraNativeImageSizeKey];
//    NSInteger imgSize = [@{kATExtraNativeImageSize228_150:@9, kATExtraNativeImageSize690_388:@10}[sizeKey] integerValue];
//
//    BUAdSlot *slot = [[NSClassFromString(@"BUAdSlot") alloc] init];
//    slot.ID = serverInfo[@"slot_id"];
//    slot.AdType = [@{@0:@(BUAdSlotAdTypeFeed), @1:@(BUAdSlotAdTypeDrawVideo), @2:@(BUAdSlotAdTypeBanner), @3:@(BUAdSlotAdTypeInterstitial)}[@([serverInfo[@"is_video"] integerValue])] integerValue];
//    slot.isOriginAd = YES;
//    slot.position = 1;
//    slot.imgSize = [NSClassFromString(@"BUSize") sizeBy:imgSize];
//    slot.isSupportDeepLink = YES;
//
//    CGSize size = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds) - 30.0f, 200.0f);
//    if ([extraInfo[kExtraInfoNativeAdSizeKey] respondsToSelector:@selector(CGSizeValue)]) { size = [extraInfo[kExtraInfoNativeAdSizeKey] CGSizeValue]; }
//
//    _adMgr = [[BUNativeExpressAdManager alloc] initWithSlot:slot adSize:size];
//    _adMgr.delegate = _customEvent;
//    _adMgr.adslot = slot;
//    [_adMgr loadAd:[serverInfo[@"request_num"] integerValue]];
}

+ (Class)rendererClass {
    return [MATNativeRenderer class];
}

@end
