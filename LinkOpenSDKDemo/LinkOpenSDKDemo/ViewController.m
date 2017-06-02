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

#import "ViewController.h"
#import "LinkOpenSDK/LinkApi.h"
#import "TestData.h"
#import "DemoUtil.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)doLogin:(id)sender {
    if (![LinkApi isLinkInstalled:LINK_APP_ID]) {
        [[DemoUtil sharedInstance] alert:@"Error" body:@"Must install link first"];
        return;
    }
    AuthReq* req = [AuthReq new];
    req.linkAppId = LINK_APP_ID;
    [LinkApi sendReq:req];
}

@end
