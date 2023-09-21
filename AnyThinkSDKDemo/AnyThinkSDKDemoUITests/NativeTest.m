//
//  NativeTest.m
//  AnyThinkSDKDemoUITests
//
//  Created by Mirinda on 2023/9/19.
//  Copyright © 2023 抽筋的灯. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface NativeTest : XCTestCase
@property (nonatomic, strong) XCUIApplication *app;
@end

@implementation NativeTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [super setUp];
    self.continueAfterFailure = NO;
    self.app = [[XCUIApplication alloc] init];
    [self.app launch];
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    [self.app terminate];
    self.app = nil;
}

- (void)testNativelshow {
    XCUIElement *Label = self.app.staticTexts[@"Native"];
    XCTAssertTrue(Label.exists, @"No Native Type.");
    [Label tap];
    sleep(2);
    
    XCUIElement *Label1 = self.app.staticTexts[@"Native Express"];
    XCTAssertTrue(Label1.exists, @"No Native Type.");
    [Label1 tap];
    
    sleep(2);
    XCUIElement *btn = self.app.buttons[@"Load Native AD"];
    XCTAssertTrue(btn.exists, @"No Load Native AD btn.");
    [btn tap];
    sleep(3);
    
    XCUIElement *readly = self.app.buttons[@"Is Native AD Ready"];
    XCTAssertTrue(readly.exists, @"No Load Native AD  Ready btn.");
    BOOL isReady = NO;
    for(int i = 0; i < 10; i++) {
        XCUIElement *readly = self.app.buttons[@"Is Native AD Ready"];
        [readly tap];
        
        XCUIElement *load = self.app.staticTexts[@"Ready!"];
        if(load.exists) {
            isReady = YES;
            break;
        }
        sleep(3);
    }
    
    if(isReady) {
        XCUIElement *show = self.app.buttons[@"Show Native AD"];
        [show tap];
    }
    sleep(3);
}

- (void)testNativeClose{
    XCUIElement *Label = self.app.staticTexts[@"Native"];
    XCTAssertTrue(Label.exists, @"No Native Type.");
    [Label tap];
    sleep(2);
    
    XCUIElement *Label1 = self.app.staticTexts[@"Native Express"];
    XCTAssertTrue(Label1.exists, @"No Native Type.");
    [Label1 tap];
    sleep(2);
    
    XCUIElement *btn = self.app.buttons[@"Load Native AD"];
    XCTAssertTrue(btn.exists, @"No Load Native AD btn.");
    [btn tap];
    sleep(3);
    
    XCUIElement *readly = self.app.buttons[@"Is Native AD Ready"];
    XCTAssertTrue(readly.exists, @"No Load Native AD  Ready btn.");
    BOOL isReady = NO;
    for(int i = 0; i < 10; i++) {
        XCUIElement *readly = self.app.buttons[@"Is Native AD Ready"];
        [readly tap];
        
        XCUIElement *load = self.app.staticTexts[@"Ready!"];
        if(load.exists) {
            isReady = YES;
            break;
        }
        sleep(3);
    }
    
    if(isReady) {
        XCUIElement *show = self.app.buttons[@"Show Native AD"];
        [show tap];
    }
    sleep(2);
    XCUIElement *web = self.app.webViews[@"ad_webview"];
    XCTAssertTrue(web.exists, @"WKWebView does not exist");
    XCTAssertTrue(web.isHittable, @"WKWebView is not hittable");
    
    XCUIElement *CButton = self.app.buttons[@"CloseBtn"];
    !CButton.exists?:[CButton tap];
    sleep(2);
    XCUIElement *RButton = self.app.buttons[@"Ad was inappropriate"];
    !RButton.exists?:[RButton tap];
    sleep(3);
    
}

- (void)testNativeClick {
    XCUIElement *Label = self.app.staticTexts[@"Native"];
    XCTAssertTrue(Label.exists, @"No Native Type.");
    [Label tap];
    sleep(2);
    
    XCUIElement *Label1 = self.app.staticTexts[@"Native Express"];
    XCTAssertTrue(Label1.exists, @"No Native Type.");
    [Label1 tap];
    sleep(2);
    
    XCUIElement *btn = self.app.buttons[@"Load Native AD"];
    XCTAssertTrue(btn.exists, @"No Load Native AD btn.");
    [btn tap];
    sleep(3);
    
    XCUIElement *readly = self.app.buttons[@"Is Native AD Ready"];
    XCTAssertTrue(readly.exists, @"No Load Native AD  Ready btn.");
    BOOL isReady = NO;
    for(int i = 0; i < 10; i++) {
        XCUIElement *readly = self.app.buttons[@"Is Native AD Ready"];
        [readly tap];
        
        XCUIElement *load = self.app.staticTexts[@"Ready!"];
        if(load.exists) {
            isReady = YES;
            break;
        }
        sleep(3);
    }
    
    if(isReady) {
        XCUIElement *show = self.app.buttons[@"Show Native AD"];
        [show tap];
    }
    
    sleep(2);
    
    XCUIElement *web = self.app.webViews[@"ad_webview"];
    XCTAssertTrue(web.exists, @"WKWebView does not exist");
    XCTAssertTrue(web.isHittable, @"WKWebView is not hittable");
    [web tap];
    
    sleep(3);
}


//- (void)testExample {
//    // UI tests must launch the application that they test.
//    XCUIApplication *app = [[XCUIApplication alloc] init];
//    [app launch];
//
//    // Use XCTAssert and related functions to verify your tests produce the correct results.
//}
//
//- (void)testLaunchPerformance {
//    if (@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *)) {
//        // This measures how long it takes to launch your application.
//        [self measureWithMetrics:@[[[XCTApplicationLaunchMetric alloc] init]] block:^{
//            [[[XCUIApplication alloc] init] launch];
//        }];
//    }
//}

@end
