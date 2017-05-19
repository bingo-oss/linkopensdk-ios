/*
 * Copyright 2017 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

#import "BGSSOAuthentication.h"

#import "BGSSOConstants.h"
#import "BGToken.h"

@implementation BGSSOAuthentication

+ (instancetype)fromDictionary:(NSDictionary*)dict {
    // TODO: handle invalid server resposne
    BGSSOAuthentication* response = [[BGSSOAuthentication alloc] init];
    
    response.rawDictionary = [dict copy];
    
    response.accessToken = [[BGToken alloc]
                            initWithToken:[dict objectForKey:kOAuth2ResponseKeyAccessToken]
                            expiresAfter:[[dict objectForKey:kOAuth2ResponseKeyExpiresIn] doubleValue]];
    
    response.refreshToken = [dict objectForKey:kOAuth2ResponseKeyRefreshToken];
    response.uid = [dict objectForKey:kOAuth2ResponseKeyUID];
    response.eCode = [dict objectForKey:kOAuth2ResponseKeyECode];
    response.status = [dict objectForKey:kOAuth2ResponseKeyStatus];
    
    return response;
}

@end
