//
//  Model.swift
//  ViewModelPractice
//
//  Created by luqman hakim on 06/01/25.
//

import Foundation
import SwiftData

@Model
class Task {
    @Attribute(.unique) var id: UUID
    var title: String
    var date: Date
    var isDone: Bool {
        get { isDoneRaw == 1 }
        set { isDoneRaw = newValue ? 1 : 0 }
    }
    private(set) var isDoneRaw: UInt8 = 0
    
    init(title: String, date: Date = Date()) {
        self.id = UUID()
        self.title = title
        self.date = date
    }
}
