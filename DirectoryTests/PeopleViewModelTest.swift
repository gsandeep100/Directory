//
//  DirectoryTests.swift
//  DirectoryTests
//
//  Created by Sandeep on 18/07/2021.
//

import XCTest
@testable import Directory


fileprivate class MockPeopleApiService: PeoplesServiceProtocol {
    
    func getPeoples(completion: @escaping (_ success: Bool, _ results: Peoples?, _ error: String?) -> ()){
        do {
            let path = Bundle.main.path(forResource: "peoples", ofType: "json")
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: path!))

            let model = try JSONDecoder().decode(Peoples.self, from: jsonData)
            completion(true, model, nil)
        } catch {
            completion(false, nil, "Error: Trying to parse Peoples to model")
        }
    }
}

fileprivate class MockRoomsApiService: RoomsServiceProtocol {
    
    func getRooms(completion: @escaping (_ success: Bool, _ results: Rooms?, _ error: String?) -> ()){
        do {
            let path = Bundle.main.path(forResource: "rooms", ofType: "json")
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: path!))

            let model = try JSONDecoder().decode(Rooms.self, from: jsonData)
            completion(true, model, nil)
        } catch {
            completion(false, nil, "Error: Trying to parse Peoples to model")
        }
    }
}

class PeopleViewModelTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
