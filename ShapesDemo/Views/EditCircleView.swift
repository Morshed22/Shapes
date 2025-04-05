//
//  EditCircleView.swift
//  ShapesDemo
//
//  Created by Morshed Alam on 4/5/25.
//

import SwiftUI

struct EditCircleView <ViewModel>: View where ViewModel: ShapesViewModelProtocol {
    
    @StateObject private var viewModel: ViewModel
    private let layout = [GridItem(.adaptive(minimum: 80))]
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: layout, spacing: 20 ) {
                    ForEach(viewModel.circleShapes, id: \.id) { item in
                        if let shape = ShapeType(rawValue: item.drawPath) {
                            ShapeView(shape: shape)
                        }
                    }
                }
            }
            Spacer()
            bottomView
        }
    }
    
    @ViewBuilder var bottomView: some View {
        HStack {
            Button("Delete All") {
                viewModel.deleAllCircleShapes()
            }
            Spacer()
            Button("Add") {
                viewModel.addCircleShape()
            }
            Spacer()
            Button("Remove") {
                viewModel.deleteLastCircle()
            }
        }.padding(.horizontal)
    }
}

#Preview {
    EditCircleView(viewModel: ShapesViewModel(networkService: NetworkService()))
}
