//
//  TaskItemView.swift
//  ViewModelPractice
//
//  Created by luqman hakim on 06/01/25.
//

import SwiftUI

struct TaskItemView: View {
    
    let task: Task
    let onMarkDone: () -> Void
    
    var body: some View {
        HStack {
            Text(task.title)
                .font(.title3)
                .strikethrough(task.isDone, color: .black)
            Spacer()
                .allowsHitTesting(false)
            
            
            VStack(alignment: .trailing) {
                Spacer()
                    .allowsHitTesting(false)
                
                if(!task.isDone) {
                    Image(systemName: "circle")
                        .frame(height: 40)
                        .onTapGesture {
                            onMarkDone()
                        }
                } else {
                    Image(systemName: "checkmark.circle.fill")
                        .frame(height: 40)
                        .foregroundColor(.green)
                }
                
                Spacer()
                    .allowsHitTesting(false)
            }
        }.padding()
    }
}

#Preview {
    List {
        TaskItemView(
            task: Task(title: "Task 1"),
            onMarkDone: {}
        )
    }
}
