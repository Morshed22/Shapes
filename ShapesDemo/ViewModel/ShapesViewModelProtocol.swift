//
//  ShapesViewModelProtocol.swift
//  ShapesDemo
//
//  Created by Morshed Alam on 4/5/25.
//

import Foundation

protocol ShapesViewModelProtocol: ObservableObject {
    var allShapes: [ShapeModel]  { get set }
    var errMsg: String { get }
    var hasError: Bool { get set }
    func fetchAllShapes() async
    func addShape(_ shapeType: ShapeType)
}

class ShapesViewModel: ShapesViewModelProtocol {
    
    @Published var allShapes: [ShapeModel] = []
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
            }
        } catch  {
            await MainActor.run {
                errMsg = "Something went wrong"
                hasError = true
            }
            print(error.localizedDescription)
        }
    }
    
    func addShape(_ shapeType: ShapeType) {
        let shapeModel:ShapeModel = .init(name: shapeType.name, drawPath: shapeType.rawValue)
        allShapes.append(shapeModel)
    }
}
