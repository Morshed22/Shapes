//
//  ShapesDemoApp.swift
//  ShapesDemo
//
//  Created by Morshed Alam on 4/5/25.
//

import SwiftUI

@main
struct ShapesDemoApp: App {
    var body: some Scene {
        WindowGroup {
            GridShapesView(viewModel: ShapesViewModel(networkService: NetworkService()))
        }
    }
}
