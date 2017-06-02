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


#import "AppDelegate.h"

#import "LinkOpenSDK/LinkApi.h"
#import "LinkOpenSDK/BGSSOClient.h"

#import "TestData.h"
#import "DemoUtil.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [LinkApi registerClient:SSOV3_CLIENT_ID];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [LinkApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [LinkApi handleOpenURL:url delegate:self];
}

- (void) onReq:(BaseReq *)req {
    // TODO
}

- (void) onResp:(BaseResp *)resp {
    if ([resp isKindOfClass:[AuthResp class]]) {
        AuthResp* resp_ = (AuthResp*)resp;
        if (resp.resultCode == RespCodeOK) {
            
            // Prepare credential
            BGSSOAuthorizationCodeCredential* credential = [BGSSOAuthorizationCodeCredential new];
            credential.code = resp_.authCode;
            
            // Setup SSOClient
            BGSSOClient* client = [BGSSOClient sharedInstance];
            client.ignoreCert = YES;
            client.clientId = SSOV3_CLIENT_ID;
            client.clientSecret = SSOV3_CLIENT_SECRET;
            client.endpointUrl = SSOV3_URL;
            
            [client authorize:credential completionHandler:^(BGSSOAuthentication * _Nullable auth, NSError * _Nullable error) {
                if (auth) {
                    [[DemoUtil sharedInstance] alert:@"Login succeed." body:[NSString stringWithFormat:@"AccessToken: %@", auth.accessToken.tokenString]];
                }
                
            }];
        } else if (resp.resultCode == RespCodeUserCancel) {
            [[DemoUtil sharedInstance] alert:@"Error" body:@"User cancel"];
        } else {
            [[DemoUtil sharedInstance] alert:resp.error body:resp.errorDescription];
        }
        
    }
}


@end
