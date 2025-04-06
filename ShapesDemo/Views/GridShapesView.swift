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
    @State private var editCircleBttonClicked: Bool = false
    
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
            }
            .navigationDestination(isPresented: $editCircleBttonClicked) {
                EditCircleView(viewModel: viewModel)
            }
            
            .alert("", isPresented: $viewModel.hasError, actions: {}) {
                Text(viewModel.errMsg)
            }
            Spacer()
            bottomView
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Clear ALL") {
                            viewModel.deleteAllShapes()
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Edit Circles") {
                           editCircleBttonClicked.toggle()
                        }
                    }
                }
        }
        .task {
            await viewModel.fetchAllShapes()
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
