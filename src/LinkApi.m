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

#import "LinkApi.h"
#import "BGSSOConstants.h"
#import "BGUtil.h"

static NSString* gClientId;

@interface LinkApi ()

@end

@implementation LinkApi

+(BOOL) registerClient:(NSString *)clientId {
    // Nothing to do yet.
    gClientId = [clientId copy];
    return YES;
}

+ (BOOL) handleOpenURL:(NSURL*)url delegate:(id<LinkApiDelegate>)delegate {
    if (delegate && url && [url.host isEqualToString:kURLSchemeCallbackHost]) {
        
        NSDictionary* params = [BGUtil parseParams:url];
        
        
        NSString* statusCode = [params objectForKey:kURLSchemeQueryParamStatusCode];

        AuthResp* resp = [AuthResp new];
        if ([statusCode isEqualToString:kLinkStatusCodeOK]) {
            resp.authCode = [params objectForKey:kURLSchemeQueryParamNameCode];
            resp.resultCode = RespCodeOK;
        } else {
            resp.resultCode = [statusCode isEqualToString:kLinkStatusCodeUserCancel] ? RespCodeUserCancel : RespCodeRequestFail;
            resp.error = [params objectForKey:kURLSchemeQueryParamNameError];
            resp.errorDescription = [params objectForKey:kURLSchemeQueryParamNameErrorDes];
        }
        
        [delegate onResp:resp];
        return YES;
    }
    return NO;

}

+ (BOOL) isLinkInstalled:(NSString*) linkAppId {
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://oauth", linkAppId]]];
}

+ (void) sendReq:(BaseReq*)req {
    if ([req isKindOfClass:[AuthReq class]]) {
        // Handle Auth
        NSString* appId = [[NSBundle mainBundle] bundleIdentifier];
        NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@://oauth?app_id=%@&client_id=%@", req.linkAppId, appId, gClientId]];
        if (![[UIApplication sharedApplication] canOpenURL:url]) {
            return;
        }
        
        [[UIApplication sharedApplication] openURL:url];
    }
}

+ (void) sendResp:(BaseResp*)resp {
    // TODO
}

@end
