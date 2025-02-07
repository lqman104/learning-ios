//
//  TaskAddForm.swift
//  ViewModelPractice
//
//  Created by luqman hakim on 12/01/25.
//

import SwiftUI
import SwiftData

struct TaskAddForm: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject
    private var taskAddViewModel: TaskAddViewModel
    
    let onAddSuccess: () -> Void
    
    @State
    private var title: String = ""
    
    init(modelContext: ModelContext, onAddSuccess: @escaping () -> Void) {
        self.onAddSuccess = onAddSuccess
        let repository = TaskRepository(modelContext: modelContext)
        _taskAddViewModel = StateObject(
            wrappedValue: TaskAddViewModel(repository: repository)
        )
    }
    
    var body: some View {
        VStack {
            Form {
                TextField("Add your task", text: $title)
            }
            
            Text("Add")
                .onTapGesture {
                    taskAddViewModel.addTask(title: title)
                }
        }.onChange(of: taskAddViewModel.state.isAddSuccess) { oldValue, newValue in
            if newValue {
                onAddSuccess()
                dismiss()
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Task.self, configurations: config)
    let context = ModelContext(container)
    
    TaskAddForm(modelContext: context) {
        
    }
}
