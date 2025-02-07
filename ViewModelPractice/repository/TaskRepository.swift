//
//  TaskRepository.swift
//  ViewModelPractice
//
//  Created by luqman hakim on 11/01/25.
//

import Foundation
import SwiftData


class TaskRepository {
    
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func fetchTasks() -> [Task] {
        var fetchDescriptor = FetchDescriptor<Task>()
        fetchDescriptor.sortBy = [
            SortDescriptor(\.isDoneRaw, order: .forward),
            SortDescriptor(\.date, order: .reverse),
            
        ]
    
        return (try? modelContext.fetch(fetchDescriptor)) ?? []
    }
    
    func addItem(title: String) {
        let task = Task(
            title: title
        )
        modelContext.insert(task)
    }
    
    
    func addItem(task: Task) {
        modelContext.insert(task)
    }
    
    func updateItem(_ task: Task, title: String) {
        task.title = title
        saveContext()
    }
    
    func delete(_ task : Task) {
        modelContext.delete(task)
        saveContext()
    }
    
    func changeDoneFlag(_ task: Task, isDone: Bool) {
        task.isDone = isDone
        saveContext()
    }
    
    private func saveContext() {
        (try? modelContext.save()) ?? print("Error when saving data")
    }
}

