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
#import "BGSSOCredentials.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AuthorizationHandler)(BGSSOAuthentication* _Nullable auth, NSError* _Nullable error);

/**
 实现 SSOV3 协议的客户。
 注意使用时必须设置好 clientId 和 secret。
 V3 协议请参考 (TODO: V3 文档地址)
 */
@interface BGSSOClient: NSObject

/**
 SSO 服务器地址。必填。
 */
@property(nonatomic, copy) NSString* endpointUrl;


/**
 应用在 SSO 服务器注册的 clientId。必填。
 */
@property(nonatomic, copy) NSString* clientId;


/**
 在 SSO 服务器应用注册时用的。必填。
 */
@property(nonatomic, copy) NSString* clientSecret;


/**
 默认为 NO，如果设为 YES，则在请求 SSO 相关接口时取消对证书和域名的安全校验。
 */
@property(nonatomic) BOOL ignoreCert;


/**
 获取 SDK 提供的共享实例
 
 @return SDK 提供的共享实例
 */
+(instancetype) sharedInstance;


/**
 每次 authorize 之后将结果保存到这里，方便下次获取。
 */
@property (nonatomic) BGSSOAuthentication* lastAuthentication;

/**
 授权获取 AccessToken
 
 @param credential Client 支持不同的认证类型，详情参见 BGSSOCredentials.h
 @param handler  在 handler 回调里处理结果，如果成功则 response 不为 nil，如果失败，则 error 不为 nil
 */
-(void) authorize:(id<BGSSOCredential>)credential completionHandler:(AuthorizationHandler)handler;

@end

NS_ASSUME_NONNULL_END
