//
//  GridShapesView.swift
//  ShapesDemo
//
//  Created by Morshed Alam on 4/5/25.
//

import SwiftUI

struct GridShapesView: View {
    var body: some View {
        NavigationStack {
            Spacer()
            
            bottomView
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Clear ALL") {
                            
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Edit Circles") {
                            print("Help tapped!")
                        }
                    }
                }
        }
    }
    
    
    @ViewBuilder var bottomView: some View {
        HStack {
            Button("Circle") {
                
            }
            Spacer()
            Button("Square") {
                
            }
            Spacer()
            Button("Triangle") {
                
            }
        }.padding(.horizontal)
    }
}

#Preview {
    GridShapesView()
}
