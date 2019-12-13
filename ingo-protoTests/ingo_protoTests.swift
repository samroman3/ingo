//
//  ingo_protoTests.swift
//  ingo-protoTests
//
//  Created by Sam Roman on 11/12/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import XCTest
@testable import ingo_proto

class ingo_protoTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLocationIQDecoder(){
      var testLocation: LocationData?
            guard let path = Bundle.main.path(forResource: "locationtest", ofType: "json") else { return }
                       
                       let url = URL(fileURLWithPath: path)
                       do {
                           let data = try Data(contentsOf: url)
                        testLocation = try LocationData.getLocationFromData(data: data)
                        print(testLocation?.placeID)
                       } catch {
                           print(error)
                          
                       }
                   XCTAssertTrue(testLocation != nil , "Failed to load listings" )
        }

}
