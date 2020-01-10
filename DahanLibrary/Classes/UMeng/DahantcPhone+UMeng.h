//
//  DahantcPhone+UMeng.h
//  DahanLibrary
//
//  Created by 孟昕欣 on 2020/1/10.
//

#import <dahantclibrary/dahantclibrary.h>

FOUNDATION_EXPORT NSString * const DahantcPhoneUMengEventId;

/// UMeng 统计
@interface DahantcPhone (UMeng)

/// 是否启用 UMeng 统计，默认 YES
@property(nonatomic, assign, readwrite, class) BOOL UMengEnable;

@end
