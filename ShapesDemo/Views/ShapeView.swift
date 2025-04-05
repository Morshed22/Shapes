//
//  ShapeView.swift
//  ShapesDemo
//
//  Created by Morshed Alam on 4/5/25.
//

import SwiftUI

struct ShapeView: View {
    var shape: ShapeType
    
    var body: some View {
        switch shape {
        case .circle:
            Circle()
                .fill(.blue)
                .frame(width: 80, height: 80)
        case .square:
            Rectangle()
                .fill(.blue)
                .frame(width: 80, height: 80)
        case .triangle:
            Triangle()
                .fill(.blue)
                .frame(width: 80, height: 80)
        }
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}
