//
//  BBTHelper.m
//  DahanLibrary_Example
//
//  Created by 孟昕欣 on 2019/11/30.
//  Copyright © 2019 AndyM129. All rights reserved.
//

#import "BBTHelper.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSData (BBTPrivateExtensionMethods)

-(NSString *)bbt_md5String {
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(self.bytes, (CC_LONG)self.length, result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end

@implementation NSString (BBTPrivateExtensionMethods)

-(NSString *)bbt_md5String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] bbt_md5String];
}

@end

@implementation NSDictionary (BBTJSONSerialization)

- (NSString *)bbt_JSONString {
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    if (error) NSLog(@"%@", error);
    return [NSString.alloc initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
