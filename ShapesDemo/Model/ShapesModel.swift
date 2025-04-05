//
//  ShapesModel.swift
//  ShapesDemo
//
//  Created by Morshed Alam on 4/5/25.
//

import Foundation
// MARK: - ShapesModel
class ShapesModel: Decodable {
    let buttons: [ShapeModel]

    init(buttons: [ShapeModel]) {
        self.buttons = buttons
    }
}

// MARK: - Shape
class ShapeModel: Decodable, Identifiable {
    
    let id = UUID()
    let name, drawPath: String

    enum CodingKeys: String, CodingKey {
        case name
        case drawPath = "draw_path"
    }

    init(name: String, drawPath: String) {
        self.name = name
        self.drawPath = drawPath
    }
}

enum ShapeType: String, Codable {
    case circle, square, triangle
    var name: String {
        switch self {
        case .circle:
            return "Circle"
        case .square:
            return "Square"
        case .triangle:
            return "Triangle"
        }
    }
}
