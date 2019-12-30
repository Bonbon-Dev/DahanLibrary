//
//  DahantcPhone.h
//  dahantcDemo
//
//  Created by admin on 2018/10/8.
//  Copyright © 2018年 admin. All rights reserved.
//



#import <UIKit/UIKit.h>


#import "CmccUIModel.h"
#import "CtccUIModel.h"

@class UACustomModel;
@class EAccountOpenPageConfig;
@interface DahantcPhone : NSObject

/**
 网络类型及运营商
 
 网络类型  key:networkType    value:0.无网络/ 1.数据流量 / 2.wifi / 3.数据+wifi
 运营商   key:carrier         value:0.未知 / 1.中国移动 / 2.中国联通 / 3.中国电信
 */
@property (nonatomic,class,readonly) NSDictionary *networkType;

/**
 初始化SDK参数
 
 @param appId 申请能力平台成功后，分配给网站的appId
 @param appKey 申请能力平台成功后，分配给网站的appKey
 */
+ (void)initializeUser:(NSString *)appId appKey:(NSString *)appKey;

+ (void) GetUserPhone :(CmccUIModel *)CmccUIModel
           CtccUIModel:(CtccUIModel *)CtccUIModel
       phoneListener  : (void(^)(id listener))phoneListener;

+ (void) GetUserPhoneNew :(UACustomModel *)UACustomModel
   EAccountOpenPageConfig:(EAccountOpenPageConfig *)EAccountOpenPageConfig
          phoneListener  : (void(^)(id listener))phoneListener;

+ (void) GetAccessCode :(UIViewController *)vc
        phoneListener  : (void(^)(id listener))phoneListener;

+(void)sendHttp:(NSString *)reqUrl reqData:(NSString*)reqData  handleResp:(void (^)(id respDate))handleResp;

+(NSDictionary *) dictionaryWithJsonString:(NSString *) jsonString;

+(NSString *) jsonStringWithDictionary:(NSDictionary *) dic;

+(void)setTestModel;

@end
