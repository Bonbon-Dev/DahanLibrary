//
//  BBTHelper.h
//  DahanLibrary_Example
//
//  Created by 孟昕欣 on 2019/11/30.
//  Copyright © 2019 AndyM129. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (BBTPrivateExtensionMethods)
- (NSString *)bbt_md5String;
@end


@interface NSString (BBTPrivateExtensionMethods)
- (NSString *)bbt_md5String;
@end


@interface NSDictionary (BBTJSONSerialization)
@property(nonatomic, strong, nullable, readonly) NSString *bbt_JSONString;
@end
