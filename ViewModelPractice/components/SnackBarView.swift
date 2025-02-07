//
//  SnackBarView.swift
//  ViewModelPractice
//
//  Created by luqman hakim on 06/01/25.
//

import SwiftUI

struct SnackBarView: View {
    
    let message: String
    let onUndo: () -> Void
    let onDismiss: () -> Void
    
    var body: some View {
        // Snackbar overlay
        VStack {
            Spacer()
            HStack {
                Text(message)
                    .foregroundColor(.white)
                Spacer()
                Button(
                    action: {
                        onUndo()
                        onDismiss()
                    }
                ) {
                    Text("Undo")
                        .fontWeight(.bold)
                        .foregroundColor(.yellow)
                }
            }.padding()
                .background(Color.black.opacity(0.8))
                .cornerRadius(10)
                .padding()
                .transition(.move(edge: .bottom)) // Snackbar enters from the bottom
                .animation(.easeInOut, value: true)
        }
        .zIndex(1)
        .onAppear {
            // Hide snackbar after 3 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                onDismiss()
            }
        }
    }
}

#Preview {
    SnackBarView(
        message: "This is a snackbar",
        onUndo: {},
        onDismiss: {}
    )
}
