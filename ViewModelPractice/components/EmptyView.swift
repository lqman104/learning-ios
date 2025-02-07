//
//  EmptyView.swift
//  ViewModelPractice
//
//  Created by luqman hakim on 14/01/25.
//

import SwiftUI

struct EmptyView: View {
    
    let addTask: () -> Void
    
    var body: some View {
        VStack {
            Image(systemName: "plus.square")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height:50)
            
            Text("Add your first task")
                .font(.title2)
                .padding(.bottom, 20)
            
            Button("Add task") {
                addTask()
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
                .frame(height: 30)
        }
    }
}

#Preview {
    EmptyView() {
        
    }
}
