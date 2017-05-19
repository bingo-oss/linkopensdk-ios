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

#import "DemoUtil.h"

@interface DemoUtil()

@property UIActivityIndicatorView* loadingView;
@property BOOL isShowingLoading;

@end


@implementation DemoUtil

+(instancetype) sharedInstance {
    static DemoUtil* sharedInst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInst = [[DemoUtil alloc] init];
    });
    return sharedInst;
}

- (void)alert:(NSString*)title body:(NSString*)body {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:body delegate:nil cancelButtonTitle:@"OK"otherButtonTitles:nil];
    [alert show];
}

- (NSString*)dictToJson:(NSDictionary*)dict {
    if (!dict) return nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
