//
//  DahantcPhone+UMeng.m
//  DahanLibrary
//
//  Created by 孟昕欣 on 2020/1/10.
//

#import "DahantcPhone+UMeng.h"
#import <AMKCategories/NSObject+AMKMethodSwizzling.h>
#import <UMAnalytics/MobClick.h>

NSString * const DahantcPhoneUMengEventId = @"OnekeyLogin";

@implementation DahantcPhone (UMeng)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [DahantcPhone amk_swizzleClassMethod:@selector(GetUserPhone:CtccUIModel:phoneListener:)
                                  withMethod:@selector(UMeng_GetUserPhone:CtccUIModel:phoneListener:)];
        [DahantcPhone amk_swizzleClassMethod:@selector(GetUserPhoneNew:EAccountOpenPageConfig:phoneListener:)
                                  withMethod:@selector(UMeng_GetUserPhoneNew:EAccountOpenPageConfig:phoneListener:)];
    });
}

#pragma mark - Init Methods

#pragma mark - Properties

static BOOL kUMengEnable = YES;

+ (BOOL)UMengEnable {
    return kUMengEnable;
}

+ (void)setUMengEnable:(BOOL)UMengEnable {
    kUMengEnable = UMengEnable;
}

#pragma mark - Layout Subviews

#pragma mark - Public Methods

+ (void)UMeng_GetUserPhone:(CmccUIModel *)CmccUIModel CtccUIModel:(CtccUIModel *)CtccUIModel phoneListener:(void (^)(id))phoneListener {
    [self UMeng_GetUserPhone:CmccUIModel CtccUIModel:CtccUIModel phoneListener:^(id responseObject) {
        [DahantcPhone UMeng_reportGetUserPhoneWithResponseObject:responseObject userInfo:nil];
        !phoneListener ?: phoneListener(responseObject);
    }];
}

+ (void)UMeng_GetUserPhoneNew:(UACustomModel *)UACustomModel EAccountOpenPageConfig:(EAccountOpenPageConfig *)EAccountOpenPageConfig phoneListener:(void (^)(id))phoneListener {
    [self UMeng_GetUserPhoneNew:UACustomModel EAccountOpenPageConfig:EAccountOpenPageConfig phoneListener:phoneListener];
}

#pragma mark - Private Methods

/// 统计
/// @param responseObject 请求结果
/// @param userInfo 自定义数据
/// @return YES上报，NO不上报
+ (BOOL)UMeng_reportGetUserPhoneWithResponseObject:(NSDictionary *_Nullable)responseObject userInfo:(NSDictionary *_Nullable)userInfo {
    // 关闭统计
    if (!self.UMengEnable) return NO;
    
    // 构建参数
    __block NSMutableDictionary *attributes = @{}.mutableCopy;
    
    @try {
        // 若不是字典，则转成字符串
        if (![responseObject isKindOfClass:NSDictionary.class]) {
            attributes[@"responseObject"] = [self stringFromObject:responseObject];
        }
        // 否则
        else {
            [responseObject enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                attributes[key] = [self stringFromObject:obj]?:@"";
            }];
        }
    } @catch (NSException *exception) {
        // 上报异常
        attributes[@"exceptionName"] = exception.name;
        attributes[@"exceptionReason"] = exception.reason;
    } @finally {
        // 执行统计
        [MobClick event:DahantcPhoneUMengEventId attributes:responseObject];
    }
    return YES;
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark - Override

#pragma mark - Helper Methods

+ (NSString *)stringFromObject:(id)object {
    // 空
    if (!object) {
        return nil;
    }
    
    // 字符串，则直接返回
    if ([object isKindOfClass:NSString.class]) {
        return object;
    }
    
    // 字典，则转成JSON返回
    if ([NSJSONSerialization isValidJSONObject:object]) {
        NSError *error = nil;
        NSData *JSONData = [NSJSONSerialization dataWithJSONObject:object options:0 error:&error];
        NSString *JSON = [NSString.alloc initWithData:JSONData encoding:NSUTF8StringEncoding];
        if (error) NSLog(@"%@", error);
        if (!error) return JSON;
    }
    
    // 否则，返回其 -description 结果
    return [object description];
}

@end
