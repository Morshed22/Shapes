//
//  ShapesDemoTests.swift
//  ShapesDemoTests
//
//  Created by Morshed Alam on 4/5/25.
//

import XCTest
@testable import ShapesDemo

final class ShapesDemoTests: XCTestCase {
    private var  shapesViewModel: ShapesViewModel!
    
    override func setUpWithError() throws {
        shapesViewModel = ShapesViewModel(networkService: MockNetworkService())
    }

    override func tearDownWithError() throws {
        shapesViewModel = nil
    }

    func testGetAllShapes() async  {
        await shapesViewModel.fetchAllShapes()
        XCTAssertTrue(shapesViewModel.allShapes.count > 0)
        XCTAssertEqual(shapesViewModel.allShapes[0].name, "Circle")
        XCTAssertEqual(shapesViewModel.errMsg, "")
        XCTAssertFalse(shapesViewModel.hasError)
    }
    
    func testAddShape() async {
        await shapesViewModel.fetchAllShapes()
        shapesViewModel.addShape(.circle)
        XCTAssertEqual(shapesViewModel.allShapes.count, 4)
        XCTAssertEqual(shapesViewModel.circleShapes.count, 2)
    }
    
    func testDeleteShape() async {
        await shapesViewModel.fetchAllShapes()
        shapesViewModel.deleteLastCircle()
        XCTAssertEqual(shapesViewModel.allShapes.count, 2)
        XCTAssertEqual(shapesViewModel.circleShapes.count, 0)
    }
    
    func testDeleteallShapes() async {
        await shapesViewModel.fetchAllShapes()
        shapesViewModel.deleteAllShapes()
        XCTAssertEqual(shapesViewModel.allShapes.count, 0)
        XCTAssertEqual(shapesViewModel.circleShapes.count,  0)
    }
    
    func testAddCircleShape() async {
        await shapesViewModel.fetchAllShapes()
        shapesViewModel.addCircleShape()
        XCTAssertEqual(shapesViewModel.circleShapes.count, 2)
    }
    
    func testDeleallCircleShapes() async {
        await shapesViewModel.fetchAllShapes()
        shapesViewModel.addShape(.circle)
        shapesViewModel.deleAllCircleShapes()
        XCTAssertEqual(shapesViewModel.circleShapes.count, 0)
    }

}

class MockNetworkService: NetworkServiceProtocol {
    func fetchAllShapes() async throws -> Data {
        guard let url = Bundle.main.url(forResource: "Shapes", withExtension: "json") else {
            throw NetworkError.invalidUrl
        }
        let data =  try Data(contentsOf: url)
        return data
    }
}
