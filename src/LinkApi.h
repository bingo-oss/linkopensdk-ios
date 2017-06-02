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
#import "LinkApiObject.h"

@protocol LinkApiDelegate <NSObject>

@optional


/**
 Link 主动和应用发起请求。

 @param req 请求对象
 */
- (void) onReq:(BaseReq*)req;


/**
 应用向 Link 发起请求，Link 处理之后会在这里返回结果。

 @param resp 结果对象
 */
- (void) onResp:(BaseResp*)resp;

@end

@interface LinkApi : NSObject


/**
 向 Link 应用注册我们的 clientID。应全局调用一次。

 @param clientId 应用在 SSO 注册的 clientID
 @return 成功返回 YES，否则 NO
 */
+(BOOL) registerClient:(NSString *)clientId;


/**
 在你 appDelegate 的 application:handleOpenURL: 方法里将 url 交给 SDK 处理。

 @param url 待处理的 url 对象
 @param delegate 委托处理对象
 @return 处理成功返回 YES，否则 NO
 */
+ (BOOL) handleOpenURL:(NSURL*)url delegate:(id<LinkApiDelegate>)delegate;


/**
 查询 Link 应用是否已经安装

 @return 如果 Link 已经安装，返回 YES，否则 NO
 */
+ (BOOL) isLinkInstalled:(NSString*) linkAppId;


/**
 向 Link 应用发起请求。

 @param req 请求对象
 */
+ (void) sendReq:(BaseReq*)req;


/**
 向 Link 应用发送响应。

 @param resp 响应对象
 */
+ (void) sendResp:(BaseResp*)resp;

@end
