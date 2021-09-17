//
//  RewardFormTests.swift
//  RewardFormTests
//
//  Created by Nikhil Desai on 27/08/21.
//

import XCTest
import Combine
@testable import RewardForm

class RewardFormTests: XCTestCase {
    let validationViewModel = RegisterFormViewModel()
    var cancel = Set<AnyCancellable>()
    var password = "Tfuyuyyy7"
    
    func testLowerCaseValidPassword(){
        let expectation = self.expectation(description: "ExpectationLowerCase")
        validationViewModel.password = password
        validationViewModel.lowerCaseValidPassword
            .receive(on: RunLoop.main)
            .sink { (data) in
                XCTAssertNotNil(data)
                expectation.fulfill()
            }
            .store(in: &cancel)
            waitForExpectations(timeout: 10)
    }
    
    
    func testUpperCaseDataValidPassword(){
        let expectation = self.expectation(description: "ExpectationUpperCaseData")
        validationViewModel.password = password
        validationViewModel.upperCaseValidPassword
            .receive(on: RunLoop.main)
            .sink { (data) in
                XCTAssertNotNil(data)
                expectation.fulfill()
            }
            .store(in: &cancel)
            waitForExpectations(timeout: 10)
    }
    

    func testCharactersDataValidPassword(){
        let expectation = self.expectation(description: "testCharactersDataValidPassword")
        validationViewModel.password = password
        validationViewModel.charValidPassword
            .receive(on: RunLoop.main)
            .sink { (data) in
                XCTAssertNotNil(data)
                expectation.fulfill()
            }
            .store(in: &cancel)
            waitForExpectations(timeout: 10)
    }
    
    func testDecimalDataValidPassword(){
        let expectation = self.expectation(description: "testDecimalDataValidPassword")
        validationViewModel.password = password
        validationViewModel.numberValidPassword
            .receive(on: RunLoop.main)
            .sink { (data) in
                XCTAssertNotNil(data)
                expectation.fulfill()
            }
            .store(in: &cancel)
            waitForExpectations(timeout: 10)
    }
    
    func testValidPassword(){
        let expectation = self.expectation(description: "testValidPassword")
        validationViewModel.password = password
        validationViewModel.isValidPassword
            .receive(on: RunLoop.main)
            .sink { (data) in
                XCTAssertTrue(data)
                expectation.fulfill()
            }
            .store(in: &cancel)
            waitForExpectations(timeout: 10)
    }
}
