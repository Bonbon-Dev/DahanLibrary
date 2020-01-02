//
//  DahantcPhone+Bugly.h
//  DahanLibrary
//
//  Created by 孟昕欣 on 2020/1/2.
//

#import <dahantclibrary/dahantclibrary.h>

/// 错误域名
FOUNDATION_EXPORT NSString * const DahantcPhoneErrorDomain;

/// Bugly 监控
@interface DahantcPhone (Bugly)

/// 是否启用 Bugly 的监控&上报，默认 YES
@property(nonatomic, assign, readwrite, class) BOOL buglyEnable;

@end


