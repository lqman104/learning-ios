//
//  TaskAddViewmodel.swift
//  ViewModelPractice
//
//  Created by luqman hakim on 12/01/25.
//

import Foundation

@MainActor
class TaskAddViewModel: ObservableObject {
    
    
    @Published
    var state: TaskAddState = TaskAddState()
    private var repository: TaskRepository? = nil
    
    init(repository: TaskRepository?) {
        self.repository = repository
    }
    
    func addTask(title: String) {
        if title == "" {
            state.errorMessage = "Title field is required"
        }
        
        repository?.addItem(title: title)
        state.errorMessage = nil
        state.isAddSuccess = true
        
    }
    
}
