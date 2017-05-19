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

#import "BGSSOClient.h"

#import <AFNetworking/AFNetworking.h>

#import "BGError.h"
#import "BGUtil.h"
#import "BGSSOConstants.h"

@interface BGSSOClient () {
@protected
    AFHTTPSessionManager* sharedAFHTTPSessionManager;
}

@end

@implementation BGSSOClient

+(instancetype) sharedInstance {
    static BGSSOClient* sharedInst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInst = [[BGSSOClient alloc] init];
    });
    return sharedInst;
}

-(instancetype) init {
    if (self = [super init]) {
        // Set default value
        _ignoreCert = NO;
        sharedAFHTTPSessionManager = [AFHTTPSessionManager manager];
    }
    return self;
}

-(void) setIgnoreCert:(BOOL)ignoreCert {
    _ignoreCert = ignoreCert;
    if (_ignoreCert) {
        sharedAFHTTPSessionManager.securityPolicy.allowInvalidCertificates = YES;
        sharedAFHTTPSessionManager.securityPolicy.validatesDomainName = NO;
    } else {
        sharedAFHTTPSessionManager.securityPolicy.allowInvalidCertificates = NO;
        sharedAFHTTPSessionManager.securityPolicy.validatesDomainName = YES;
    }
}

-(NSString*) getEncodedAuthorization {
    NSData *data = [[NSString stringWithFormat:@"%@:%@", self.clientId, self.clientSecret]
                      dataUsingEncoding:NSUTF8StringEncoding];
    NSString* encoded = [data base64EncodedStringWithOptions:0];
    return [NSString stringWithFormat:@"Basic %@", encoded];
}

-(NSString*) getTokenEndpointUrl {
    NSURL* url = [NSURL URLWithString:self.endpointUrl];
    assert(url != nil);
    return [[url URLByAppendingPathComponent:kUrlPathGetAccessToken] absoluteString];
}

-(void) authorize:(id<BGSSOCredential>)credential completionHandler:(AuthorizationHandler) handler {
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    
    if ([credential isKindOfClass:BGSSOClientCredential.class]) {
        [params setValue:kParamValueGrantTypeClient forKey:kParamNameGrantType];
    } else if ([credential isKindOfClass:BGSSOTokenClientCredential.class]) {
        BGSSOTokenClientCredential* _credential = (BGSSOTokenClientCredential*) credential;
        [params setValue:kParamValueGrantTypeTokenClient forKey:kParamNameGrantType];
        [params setValue:_credential.accessToken forKey:kParamNameAccessToken];
    } else if ([credential isKindOfClass:BGSSOAuthorizationCodeCredential.class]) {
        BGSSOAuthorizationCodeCredential* _credential = (BGSSOAuthorizationCodeCredential*) credential;
        [params setValue:kParamValueGrantTypeAuthzCode forKey:kParamNameGrantType];
        [params setValue:_credential.code forKey:kParamNameAuthzCode];
    } else if ([credential isKindOfClass:BGSSORefreshTokenCredential.class]) {
        BGSSORefreshTokenCredential* _credential = (BGSSORefreshTokenCredential*) credential;
        [params setValue:kParamValueGrantTypeRefreshToken forKey:kParamNameGrantType];
        [params setValue:_credential.refreshToken forKey:kParamNameRefreshToken];
    } else {
        if (handler != nil) {
            NSError* error = BGErrorWithMessage([[NSString alloc] initWithFormat:@"Invalid CredentialType for SSOV3: %@", NSStringFromClass(credential.class)]);
            handler(nil, error);
        }
        return;
    }
    
    [sharedAFHTTPSessionManager.requestSerializer setValue:[self getEncodedAuthorization] forHTTPHeaderField:@"Authorization"];
    
    NSString* endpoint = [self getTokenEndpointUrl];
    
    [sharedAFHTTPSessionManager POST:endpoint parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* dict = (NSDictionary*)(responseObject);
        BGSSOAuthentication* response = [BGSSOAuthentication fromDictionary:dict];
        self.lastAuthentication = response;
        if (handler) handler(response, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (handler) handler(nil, error);
    }];
}

@end
