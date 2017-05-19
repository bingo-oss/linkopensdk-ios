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

#import "BGUtil.h"

@implementation BGUtil

+(NSString*) concatUrl:(NSString*) firstPart withPath:(NSString*)secondPart {
    return [firstPart stringByAppendingPathComponent:secondPart];
}

+(NSDictionary*) parseParams:(NSURL*)url {
    if (url == nil) return nil;
    NSURLComponents* components = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    for (NSURLQueryItem* item in components.queryItems) {
        if (item.name && item.name.length > 0) {
            [dict setObject:item.value forKey:item.name];
        }
    }
    return dict;
}

@end
