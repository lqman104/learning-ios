//
//  ViewModelPracticeApp.swift
//  ViewModelPractice
//
//  Created by luqman hakim on 05/01/25.
//

import SwiftUI
import SwiftData

@main
struct Apps: App {
    
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: Task.self)
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error.localizedDescription)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            TaskListView(
                modelContext: ModelContext(container)
            )
        }.modelContainer(container)
    }
}
