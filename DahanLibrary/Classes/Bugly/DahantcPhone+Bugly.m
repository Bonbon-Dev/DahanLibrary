//
//  DahantcPhone+Bugly.m
//  DahanLibrary
//
//  Created by 孟昕欣 on 2020/1/2.
//

#import "DahantcPhone+Bugly.h"
#import <Bugly/Bugly.h>
#import <AMKCategories/NSObject+AMKMethodSwizzling.h>

NSString * const DahantcPhoneErrorDomain = @"com.dahantc.error";

@implementation DahantcPhone (Bugly)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [DahantcPhone amk_swizzleClassMethod:@selector(GetUserPhone:CtccUIModel:phoneListener:)
                                  withMethod:@selector(Bugly_GetUserPhone:CtccUIModel:phoneListener:)];
        [DahantcPhone amk_swizzleClassMethod:@selector(GetUserPhoneNew:EAccountOpenPageConfig:phoneListener:)
                                  withMethod:@selector(Bugly_GetUserPhoneNew:EAccountOpenPageConfig:phoneListener:)];
    });
}

#pragma mark - Init Methods

#pragma mark - Properties

static BOOL kBuglyEnable = YES;

+ (BOOL)buglyEnable {
    return kBuglyEnable;
}

+ (void)setBuglyEnable:(BOOL)buglyEnable {
    kBuglyEnable = buglyEnable;
}

#pragma mark - Layout Subviews

#pragma mark - Public Methods

+ (void)Bugly_GetUserPhone:(CmccUIModel *)CmccUIModel CtccUIModel:(CtccUIModel *)CtccUIModel phoneListener:(void (^)(id))phoneListener {
    [self Bugly_GetUserPhone:CmccUIModel CtccUIModel:CtccUIModel phoneListener:^(id responseObject) {
        [DahantcPhone Bugly_reportGetUserPhoneFailedIfNeededWithResponseObject:responseObject userInfo:nil];
        !phoneListener ?: phoneListener(responseObject);
    }];
}

+ (void)Bugly_GetUserPhoneNew:(UACustomModel *)UACustomModel EAccountOpenPageConfig:(EAccountOpenPageConfig *)EAccountOpenPageConfig phoneListener:(void (^)(id))phoneListener {
    [self Bugly_GetUserPhoneNew:UACustomModel EAccountOpenPageConfig:EAccountOpenPageConfig phoneListener:phoneListener];
}

#pragma mark - Private Methods

/// 若手机号码获取失败，则上报异常
/// @param responseObject 请求结果
/// @param userInfo 自定义数据
/// @return YES 异常并上报，NO 无异常
+ (BOOL)Bugly_reportGetUserPhoneFailedIfNeededWithResponseObject:(id _Nullable)responseObject userInfo:(NSDictionary *_Nullable)userInfo {
    // 手机号的正则
    static NSRegularExpression *mobileRegex = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSError *error = nil;
        mobileRegex = [NSRegularExpression regularExpressionWithPattern:@"^\\w\\S+\\w$" options:NSRegularExpressionAllowCommentsAndWhitespace error:&error];
        if (error) {
            NSString *name = [NSString stringWithFormat:@"%@.%@", DahantcPhoneErrorDomain, @"mobileRegex"];
            NSString *reason = [NSString stringWithFormat:@"正则创建时出现异常: %@", error];
            if (self.buglyEnable) [Bugly reportExceptionWithCategory:3 name:name reason:reason callStack:nil extraInfo:nil terminateApp:NO];
            NSLog(@"❌ - %@ | %@, extraInfo = %@", name, reason, @"");
        }
    });
    
    // 参数校验，有效则直接返回
    NSDictionary *response = [responseObject isKindOfClass:NSDictionary.class] ? responseObject : nil;
    NSString *mobile = [response objectForKey:@"mobile"];
    BOOL isValid = YES;
    isValid = isValid && response.count; // 必须是有内容的字典
    isValid = isValid && [@"success" isEqualToString:response[@"result"]]; // 结果必须成功
    isValid = isValid && mobile.length; // 有手机号
    isValid = isValid && [mobileRegex numberOfMatchesInString:mobile options:0 range:NSMakeRange(0, mobile.length)]; // 手机号格式正确
    if (isValid) return NO;
    
    // 无效，则上报
    NSString *result = [response objectForKey:@"result"];
    NSString *name = [NSString stringWithFormat:@"%@.%@", DahantcPhoneErrorDomain, result];
    NSString *reason = [NSString stringWithFormat:@"手机号获取异常：%@", mobile];
    NSMutableDictionary *extraInfo = @{}.mutableCopy;
    extraInfo[@"userInfo"] = [self stringFromObject:userInfo]?:@"";
    extraInfo[@"responseObject"] = [self stringFromObject:responseObject]?:@"";
    if (self.buglyEnable) [Bugly reportExceptionWithCategory:3 name:name reason:reason callStack:nil extraInfo:extraInfo terminateApp:NO];
    NSLog(@"❌ - %@ | %@, extraInfo = %@", name, reason, extraInfo);
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
