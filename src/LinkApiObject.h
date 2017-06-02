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

#import <Foundation/Foundation.h>

enum RespCode {
    RespCodeOK = 200,
    RespCodeUserCancel = 100,
    RespCodeRequestFail = 103,
};

@interface BaseReq : NSObject


/**
 每个 req 都应指明 Link 应用的 appBundleId
 */
@property (nonatomic, copy) NSString* linkAppId;

@end

@interface BaseResp : NSObject

@property (nonatomic) int resultCode;

@property (nonatomic, copy) NSString* error;

@property (nonatomic, copy) NSString* errorDescription;

@end

@interface AuthReq : BaseReq

@end

@interface AuthResp : BaseResp

@property (nonatomic, copy) NSString* authCode;

@end
