//
//  ShapesViewModelProtocol.swift
//  ShapesDemo
//
//  Created by Morshed Alam on 4/5/25.
//

import Foundation

protocol ShapesViewModelProtocol: ObservableObject {
    var allShapes: [ShapeModel]  { get }
    var circleShapes: [ShapeModel] { get }
    var errMsg: String { get }
    var hasError: Bool { get set }
    func fetchAllShapes() async
    func addShape(_ shapeType: ShapeType)
    func addCircleShape()
    func deleteAllShapes()
    func deleAllCircleShapes()
    func deleteLastCircle()
    
}

class ShapesViewModel: ShapesViewModelProtocol {
    @Published var allShapes: [ShapeModel] = []
    @Published var circleShapes: [ShapeModel] = []
    @Published var errMsg: String = ""
    @Published var hasError: Bool = false
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchAllShapes() async {
        do {
            let data =  try await networkService.fetchAllShapes()
            
            let response = try JSONDecoder().decode(ShapesModel.self, from: data)
            
            await MainActor.run {
                allShapes = response.buttons
                circleShapes = allShapes.filter { $0.name == "Circle" }
            }
        } catch  {
            await MainActor.run {
                errMsg = "Something went wrong"
                hasError = true
            }
            print(error.localizedDescription)
        }
    }
    
    // Mark: add new shape
    func addShape(_ shapeType: ShapeType) {
        let shapeModel:ShapeModel = .init(name: shapeType.name, drawPath: shapeType.rawValue)
        allShapes.append(shapeModel)
        if shapeType == .circle {
            circleShapes.append(shapeModel)
        }
    }
    
   // Mark: add Circle shape
    func addCircleShape() {
        let shapeModel:ShapeModel = .init(name: ShapeType.circle.name, drawPath: ShapeType.circle.rawValue)
        allShapes.append(shapeModel)
        circleShapes.append(shapeModel)
    }
    
    // Mark: delete all shapes
    func deleteAllShapes() {
        allShapes.removeAll()
        circleShapes.removeAll()
    }
    
    // Mark: delete all Circle shapes
    func deleAllCircleShapes() {
        circleShapes.removeAll()
        allShapes.removeAll(where: { $0.name == "Circle" })
    }
    // Mark: delete last Circle shape
    func deleteLastCircle() {
        if circleShapes.count > 0, let id = circleShapes.last?.id {
            circleShapes.removeLast()
            allShapes.removeAll(where: { $0.id == id })
        }
    }
}
