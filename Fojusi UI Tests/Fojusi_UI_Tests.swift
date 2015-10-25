//
//  Fojusi_UI_Tests.swift
//  Fojusi UI Tests
//
//  Created by dasdom on 13.06.15.
//  Copyright © 2015 Dominik Hauser. All rights reserved.
//

import Foundation
import XCTest

class Fojusi_UI_Tests: XCTestCase {
  
  let app = XCUIApplication()

  var breakButton: XCUIElement!
  var procrastinateButton: XCUIElement!
  var workButton: XCUIElement!
  
  override func setUp() {
    super.setUp()
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    breakButton = app.buttons["Break"]
    procrastinateButton = app.buttons["Procrastinate"]
    workButton = app.buttons["Work"]
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    XCUIApplication().launch()
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testSelectingBreak_DisablesOtherButtons() {
    XCTAssertTrue(procrastinateButton.enabled)
    XCTAssertTrue(workButton.enabled)
    XCTAssertTrue(breakButton.enabled)
    
    breakButton.tap()
    
    XCTAssertFalse(procrastinateButton.enabled)
    XCTAssertFalse(workButton.enabled)
    
    XCTAssertTrue(breakButton.enabled)
    breakButton.tap()
    app.alerts["Stop?"].collectionViews.buttons["Stop"].tap()
  }
  
  func testSelectingWork_DisablesOtherButtons() {
    XCTAssertTrue(procrastinateButton.enabled)
    XCTAssertTrue(workButton.enabled)
    XCTAssertTrue(breakButton.enabled)
    
    workButton.tap()
    
    XCTAssertFalse(procrastinateButton.enabled)
    XCTAssertFalse(breakButton.enabled)
    
    XCTAssertTrue(workButton.enabled)
    workButton.tap()
    app.alerts["Stop?"].collectionViews.buttons["Stop"].tap()
  }
  
  func testSelectingProcrastinate_DisablesOtherButtons() {
    XCTAssertTrue(procrastinateButton.enabled)
    XCTAssertTrue(workButton.enabled)
    XCTAssertTrue(breakButton.enabled)
    
    procrastinateButton.tap()
    
    XCTAssertFalse(workButton.enabled)
    XCTAssertFalse(breakButton.enabled)
    
    XCTAssertTrue(procrastinateButton.enabled)
    procrastinateButton.tap()
    app.alerts["Stop?"].collectionViews.buttons["Stop"].tap()
  }
  
  func testTimerValues_CanBeChangedInSettings() {
    
    app.buttons["Settings"].tap()
    
    app.pickerWheels.element.adjustToPickerWheelValue("55 min")
    XCTAssertTrue(app.staticTexts["55 min"].exists)
    app.pickerWheels.element.adjustToPickerWheelValue("10 min")
    XCTAssertTrue(app.staticTexts["10 min"].exists)
    app.pickerWheels.element.adjustToPickerWheelValue("25 min")
    XCTAssertTrue(app.staticTexts["25 min"].exists)

    app.staticTexts["Break duration"].tap()
    app.childrenMatchingType(.Window).elementBoundByIndex(0).childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.tap()
    app.pickerWheels.element.adjustToPickerWheelValue("1 min")
    XCTAssertTrue(app.staticTexts["1 min"].exists)
    app.pickerWheels.element.adjustToPickerWheelValue("10 min")
    XCTAssertTrue(app.staticTexts["10 min"].exists)
    app.pickerWheels.element.adjustToPickerWheelValue("5 min")
    XCTAssertTrue(app.staticTexts["5 min"].exists)

    app.navigationBars["Settings"].buttons["Done"].tap()
  }
  
  func testCanShowTwitter_InAbout() {
    
    app.buttons["About"].tap()
    app.buttons["Twitter"].tap()
    XCTAssertTrue(app.toolbars.buttons["OpenInSafari"].exists)
    XCTAssertTrue(app.toolbars.buttons["Share"].exists)
    app.buttons["Done"].tap()
  }
  
  func testCanShowGithub_InAbout() {
    
    app.buttons["About"].tap()
    app.buttons["Github"].tap()
    XCTAssertTrue(app.toolbars.buttons["OpenInSafari"].exists)
    XCTAssertTrue(app.toolbars.buttons["Share"].exists)
    app.buttons["Done"].tap()
  }
  
}
