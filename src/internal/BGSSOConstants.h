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

#pragma mark - Keys for request

// v3 path
static NSString* const kUrlPathGetAccessToken = @"/oauth2/token";
static NSString* const kUrlPathGetTokenInfo = @"/oauth2/tokeninfo";

// v3 key name
static NSString* const kParamNameGrantType = @"grant_type";
static NSString* const kParamNameClientIdV3 = @"client_id";
static NSString* const kParamNameClinetSecret = @"client_secret";
static NSString* const kParamNameRefreshToken = @"refresh_token";
static NSString* const kParamNameAccessToken = @"access_token";
static NSString* const kParamNameJWTToken = @"jwt_token";
static NSString* const kParamNameAuthzCode = @"code";

// v3 key value
static NSString* const kParamValueGrantTypePassword = @"password";
static NSString* const kParamValueGrantTypeRefreshToken = @"refresh_token";
static NSString* const kParamValueGrantTypeClient = @"client_credentials";
static NSString* const kParamValueGrantTypeTokenClient = @"token_client_credentials";
static NSString* const kParamValueGrantTypeAuthzCode = @"authorization_code";

#pragma mark - Keys for reponse

// v3 key name
static NSString* const kOAuth2ResponseKeyAccessToken = @"access_token";
static NSString* const kOAuth2ResponseKeyTokenType = @"token_type";
static NSString* const kOAuth2ResponseKeyExpiresIn = @"expires_in";
static NSString* const kOAuth2ResponseKeyRefreshToken = @"refresh_token";
static NSString* const kOAuth2ResponseKeyECode = @"eCode";
static NSString* const kOAuth2ResponseKeyUID = @"uid";
static NSString* const kOAuth2ResponseKeyStatus = @"status";

static NSString* const kResponseValueModeOK = @"ok";
static NSString* const kResponseValueModeFail = @"fail";

// oauth2

static NSString* const kOauth2ResponseKeyError = @"error";
static NSString* const kOauth2ResponseKeyErrorDescription = @"error_description";

// Link third-party login
static NSString* const kURLSchemeCallbackHost = @"oauth";
static NSString* const kURLSchemeQueryParamStatusCode = @"statusCode";
static NSString* const kURLSchemeQueryParamNameCode = @"code";
static NSString* const kURLSchemeQueryParamNameError = @"error";
static NSString* const kURLSchemeQueryParamNameErrorDes = @"error_description";

static NSString* const kLinkStatusCodeOK = @"200";
static NSString* const kLinkStatusCodeUserCancel = @"100";
static NSString* const kLinkStatusCodeRequestFail = @"103";
