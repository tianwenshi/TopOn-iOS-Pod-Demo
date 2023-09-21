//
//  MATNativeRenderer.h
//  AnyThinkSDKDemo
//
//  Created by root on 2023/9/20.
//  Copyright © 2023 抽筋的灯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AnyThinkNative/AnyThinkNative.h>
#import "MATNativeCustomEvent.h"

NS_ASSUME_NONNULL_BEGIN

@interface MATNativeRenderer : ATNativeRenderer
@property(nonatomic, readonly) MATNativeCustomEvent *customEvent;
@end

NS_ASSUME_NONNULL_END
