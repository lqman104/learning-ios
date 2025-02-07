//
//  ContentView.swift
//  ViewModelPractice
//
//  Created by luqman hakim on 05/01/25.
//

import SwiftUI
import SwiftData

struct TaskListView: View {
    
    @StateObject private var viewModel: TaskViewModel
    @State private var showSnackbar = false
    @State private var isAddShowBottomSheet = false
    private var modelContext: ModelContext? = nil
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        let repository = TaskRepository(modelContext: modelContext)
        _viewModel = StateObject(wrappedValue: TaskViewModel(repository: repository))
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.state.tasks.count <= 0 {
                    EmptyView() {
                        isAddShowBottomSheet = true
                    }
                } else {
                    List {
                        ForEach(Array(viewModel.state.tasks.enumerated()), id: \.element.id) { (index, task) in
                            TaskItemView(
                                task: task,
                                onMarkDone: {
                                    showSnackbar = true
                                    viewModel.markAsDone(index: index)
                                }
                            )
                        }.onDelete(perform: delete)
                    }
                }
                
                if showSnackbar {
                    SnackBarView(
                        message: "Success perform the action",
                        onUndo: {
                            viewModel.undo()
                        },
                        onDismiss: {
                            showSnackbar = false
                        }
                    )
                }
                
                // Full-screen overlay when loading
                if viewModel.state.isLoading {
                    Color.black.opacity(0.5) // Semi-transparent black background
                        .edgesIgnoringSafeArea(.all) // Cover the entire screen
                    
                    ProgressView() // Circular loading indicator
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(2) // Scale the indicator to make it larger
                        .foregroundColor(.white) // White color for the indicator
                }
            }.sheet(isPresented: $isAddShowBottomSheet) {
                if let context = modelContext {
                    TaskAddForm(
                        modelContext: context,
                        onAddSuccess: {
                            // refresh the list
                            viewModel.getList()
                        }
                    )
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
                }
            }.onAppear {
                viewModel.getList()
            }
            .navigationTitle("Tasks")
            .toolbar {
                if 0 < viewModel.state.tasks.count {
                    ToolbarItem {
                        Button("+ Add task") {
                            isAddShowBottomSheet = true
                        }
                        .font(.headline)
                    }
                }
            }
        }
    }
    
    private func delete(at offset: IndexSet) {
        if let index = offset.first {
            showSnackbar = true
            viewModel.remove(index: index)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Task.self, configurations: config)
    let context = ModelContext(container)
    
    context.insert(Task(title: "Task 1"))
    context.insert(Task(title: "Task 2"))
    context.insert(Task(title: "Task 3"))
    
    
    return NavigationStack {
        TaskListView(
            modelContext: context
        )
    }
    
}
