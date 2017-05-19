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

#import "BGToken.h"

@interface BGSSOAuthentication : NSObject

@property(nonatomic, nullable) BGToken* accessToken;

@property(nonatomic, copy, nullable) NSString* refreshToken;

@property(nonatomic, nullable) NSString* uid;

@property(nonatomic, nullable) NSString* eCode;

@property(nonatomic, nullable) NSNumber* status;

/**
 SSO 服务器返回的未经处理的 JSON 结果
 */
@property(nonatomic, copy, nonnull) NSDictionary* rawDictionary;

+ (_Nullable instancetype)fromDictionary:(NSDictionary* _Nonnull)dict;

@end
