//
//  GridShapesView.swift
//  ShapesDemo
//
//  Created by Morshed Alam on 4/5/25.
//

import SwiftUI

struct GridShapesView <ViewModel>: View where ViewModel: ShapesViewModelProtocol {
    
    @StateObject private var viewModel: ViewModel
    private let layout = [GridItem(.adaptive(minimum: 80))]
    
    init(viewModel: ViewModel) {
       _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: layout, spacing: 20 ) {
                    ForEach(viewModel.allShapes, id: \.id) { item in
                        if let shape = ShapeType(rawValue: item.drawPath) {
                            ShapeView(shape: shape)
                        }
                    }
                }
                .task {
                    await viewModel.fetchAllShapes()
                }
            }
            Spacer()
            bottomView
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Clear ALL") {
                            viewModel.deleteAllShape()
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Edit Circles") {
                           
                        }
                    }
                }
        }
    }
    
    
    @ViewBuilder var bottomView: some View {
        HStack {
            Button("Circle") {
                viewModel.addShape(.circle)
            }
            Spacer()
            Button("Square") {
                viewModel.addShape(.square)
            }
            Spacer()
            Button("Triangle") {
                viewModel.addShape(.triangle)
            }
        }.padding(.horizontal)
    }
}

#Preview {
    GridShapesView(viewModel: ShapesViewModel(networkService: NetworkService()))
}
