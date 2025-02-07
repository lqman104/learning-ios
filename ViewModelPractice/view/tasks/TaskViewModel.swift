//
//  ViewModel.swift
//  ViewModelPractice
//
//  Created by luqman hakim on 05/01/25.
//

import Foundation
import SwiftUI

class TaskViewModel: ObservableObject {
    
    private var repository: TaskRepository
    
    @Published var state: TaskViewState = TaskViewState()
    private var lastPerfomType: PerformType? = nil
    
    init(repository: TaskRepository) {
        self.repository = repository
    }
    
    func getList() {
        state.isLoading = true
        
        state.tasks = repository.fetchTasks()
        
        state.isLoading = false
        
        print("Load")
        print(state.tasks.count)
    }
    
    func remove(index: Int) {
        let task = state.tasks[index]
        lastPerfomType = PerformType.Remove(task: task)
        repository.delete(task)
        getList()
    }
    
    func markAsDone(index: Int) {
        let task = state.tasks[index]
        lastPerfomType = PerformType.MarkAsDone(index: index)
        task.isDone = true
        
        repository.changeDoneFlag(task, isDone: true)
        getList()
    }
    
    func undo() {
        objectWillChange.send()
        switch(lastPerfomType) {
        case .Remove(let task):
            repository.addItem(task: task)
            getList()
            break
        case .MarkAsDone(let index):
            let task = state.tasks[index]
            repository.changeDoneFlag(task, isDone: false)
            getList()
            break
        default: break
        }
    }
    
}
