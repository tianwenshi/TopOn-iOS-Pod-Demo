//
//  SplashTest.m
//  AnyThinkSDKDemoUITests
//
//  Created by Mirinda on 2023/9/19.
//  Copyright © 2023 抽筋的灯. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface SplashTest : XCTestCase
@property (nonatomic, strong) XCUIApplication *app;

@end

@implementation SplashTest

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

//- (void)testSplashshow {
//    XCUIElement *Label = self.app.staticTexts[@"Splash"];
//    XCTAssertTrue(Label.exists, @"No Splash Type.");
//    [Label tap];
//    sleep(2);
//
//    XCUIElement *btn = self.app.buttons[@"Load Splash AD"];
//    XCTAssertTrue(btn.exists, @"No Load Splash AD btn.");
//    [btn tap];
//    sleep(3);
//
//    XCUIElement *readly = self.app.buttons[@"Is Splash AD Ready"];
//    XCTAssertTrue(readly.exists, @"No Load Splash AD  Ready btn.");
//    BOOL isReady = NO;
//    for(int i = 0; i < 10; i++) {
//        XCUIElement *readly = self.app.buttons[@"Is Splash AD Ready"];
//        [readly tap];
//
//        XCUIElement *load = self.app.staticTexts[@"Ready!"];
//        if(load.exists) {
//            isReady = YES;
//            break;
//        }
//        sleep(3);
//    }
//
//    if(isReady) {
//        XCUIElement *show = self.app.buttons[@"Show Splash AD"];
//        [show tap];
//    }
//    sleep(10);
//}

//- (void)testSplashClose{
//    XCUIElement *Label = self.app.staticTexts[@"Splash"];
//    XCTAssertTrue(Label.exists, @"No Splash Type.");
//    [Label tap];
//    sleep(2);
//
//    XCUIElement *btn = self.app.buttons[@"Load Splash AD"];
//    XCTAssertTrue(btn.exists, @"No Load Splash AD btn.");
//    [btn tap];
//    sleep(3);
//
//    XCUIElement *readly = self.app.buttons[@"Is Splash AD Ready"];
//    XCTAssertTrue(readly.exists, @"No Load Splash AD  Ready btn.");
//    BOOL isReady = NO;
//    for(int i = 0; i < 10; i++) {
//        XCUIElement *readly = self.app.buttons[@"Is Splash AD Ready"];
//        [readly tap];
//
//        XCUIElement *load = self.app.staticTexts[@"Ready!"];
//        if(load.exists) {
//            isReady = YES;
//            break;
//        }
//        sleep(3);
//    }
//
//    if(isReady) {
//        XCUIElement *show = self.app.buttons[@"Show Splash AD"];
//        [show tap];
//    }
//    sleep(10);
//    XCUIElement *web = self.app.webViews[@"ad_webview"];
//    XCTAssertTrue(web.exists, @"WKWebView does not exist");
//    XCTAssertTrue(web.isHittable, @"WKWebView is not hittable");
//
//    XCUIElement *close = self.app.buttons[@"close_x"];
//    if(close.exists) {
//       [close tap];
//    }
//}

//- (void)testSplashClick {
//    XCUIElement *Label = self.app.staticTexts[@"Splash"];
//    XCTAssertTrue(Label.exists, @"No Splash Type.");
//    [Label tap];
//    sleep(2);
//    
//    XCUIElement *btn = self.app.buttons[@"Load Splash AD"];
//    XCTAssertTrue(btn.exists, @"No Load Splash AD btn.");
//    [btn tap];
//    sleep(3);
//    
//    XCUIElement *readly = self.app.buttons[@"Is Splash AD Ready"];
//    XCTAssertTrue(readly.exists, @"No Load Splash AD  Ready btn.");
//    BOOL isReady = NO;
//    for(int i = 0; i < 10; i++) {
//        XCUIElement *readly = self.app.buttons[@"Is Splash AD Ready"];
//        [readly tap];
//        
//        XCUIElement *load = self.app.staticTexts[@"Ready!"];
//        if(load.exists) {
//            isReady = YES;
//            break;
//        }
//        sleep(3);
//    }
//    
//    if(isReady) {
//        XCUIElement *show = self.app.buttons[@"Show Splash AD"];
//        [show tap];
//    }
//    
//    sleep(10);
//    
//    XCUIElement *web = self.app.webViews[@"ad_webview"];
//    XCTAssertTrue(web.exists, @"WKWebView does not exist");
//    XCTAssertTrue(web.isHittable, @"WKWebView is not hittable");
//    [web tap];
//    
//    sleep(3);
//}

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
