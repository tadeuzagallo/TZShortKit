//
//  NSString+TZShortKit.m
//  TZShortKit
//
//  Created by Tadeu Zagallo on 9/24/13.
//  Copyright (c) 2013 Tadeu Zagallo. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
#import "NSString+TZShortKit.h"

@implementation NSString (TZShortKit)

#pragma mark - Getters

- (NSString *)md5String {
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end
