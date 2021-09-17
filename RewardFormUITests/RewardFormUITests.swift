//
//  RewardFormUITests.swift
//  RewardFormUITests
//
//  Created by Nikhil Desai on 27/08/21.
//

import XCTest

class RewardFormUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEmailLogin(){
        
        let app = XCUIApplication()
        let emailIdTextfield = app.textFields["   Enter your Email Id"]
        XCTAssertTrue(emailIdTextfield.exists)
        emailIdTextfield.tap()
        emailIdTextfield.typeText("nikhildesai101@gmail.com")
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["arrow right"]/*[[".textFields[\"   Enter your Email Id\"].buttons[\"arrow right\"]",".buttons[\"arrow right\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
                      
    }

    func testPasswordLogin(){
        
        let app = XCUIApplication()
        let passwordTextfield = app.textFields["   Set your Password"]
        XCTAssertTrue(passwordTextfield.exists)
        passwordTextfield.tap()
        passwordTextfield.typeText("Testdata12")
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["arrow right"]/*[[".textFields[\"   Set your Password\"].buttons[\"arrow right\"]",".buttons[\"arrow right\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
                
    }
   
    
}
