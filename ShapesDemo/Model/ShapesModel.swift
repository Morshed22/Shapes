//
//  ShapesModel.swift
//  ShapesDemo
//
//  Created by Morshed Alam on 4/5/25.
//


// MARK: - ShapesModel
class ShapesModel: Codable {
    let buttons: [ShapeModel]

    init(buttons: [ShapeModel]) {
        self.buttons = buttons
    }
}

// MARK: - Shape
class ShapeModel: Codable {
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
