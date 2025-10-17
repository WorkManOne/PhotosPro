import Foundation
import SwiftUI

struct TaskModel: Identifiable, Codable {
    var id = UUID()
    var title: String
    var description: String
    var category: TaskCategory
    var priority: TaskPriority
    var status: TaskStatus
    var dueDate: Date?
    var estimatedDuration: Int
    var actualDuration: Int?
    var clientName: String?
    var projectName: String?
    var location: String?
    var equipment: [String]
    var team: [String]
    var notes: String
    var tags: [String]
    var createdDate: Date
    var completedDate: Date?
    
    init(title: String = "", description: String = "", category: TaskCategory = .shooting, priority: TaskPriority = .medium, status: TaskStatus = .pending, dueDate: Date? = nil, estimatedDuration: Int = 60, actualDuration: Int? = nil, clientName: String? = nil, projectName: String? = nil, location: String? = nil, equipment: [String] = [], team: [String] = [], notes: String = "", tags: [String] = [], createdDate: Date = Date(), completedDate: Date? = nil) {
        self.title = title
        self.description = description
        self.category = category
        self.priority = priority
        self.status = status
        self.dueDate = dueDate
        self.estimatedDuration = estimatedDuration
        self.actualDuration = actualDuration
        self.clientName = clientName
        self.projectName = projectName
        self.location = location
        self.equipment = equipment
        self.team = team
        self.notes = notes
        self.tags = tags
        self.createdDate = createdDate
        self.completedDate = completedDate
    }
}

enum TaskCategory: String, CaseIterable, Codable {
    case shooting = "Shooting"
    case editing = "Editing"
    case client = "Client Work"
    case marketing = "Marketing"
    case equipment = "Equipment"
    case business = "Business"
    case personal = "Personal"
    case learning = "Learning"
    case networking = "Networking"
    case other = "Other"
    
    var color: Color {
        switch self {
        case .shooting: return .blue
        case .editing: return .purple
        case .client: return .green
        case .marketing: return .orange
        case .equipment: return .brown
        case .business: return .red
        case .personal: return .pink
        case .learning: return .mint
        case .networking: return .yellow
        case .other: return .gray
        }
    }
}

enum TaskPriority: String, CaseIterable, Codable {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
    case urgent = "Urgent"
    
    var color: Color {
        switch self {
        case .low: return .green
        case .medium: return .yellow
        case .high: return .orange
        case .urgent: return .red
        }
    }
}

enum TaskStatus: String, CaseIterable, Codable {
    case pending = "Pending"
    case inProgress = "In Progress"
    case completed = "Completed"
    case cancelled = "Cancelled"
    case onHold = "On Hold"
    
    var color: Color {
        switch self {
        case .pending: return .gray
        case .inProgress: return .blue
        case .completed: return .green
        case .cancelled: return .red
        case .onHold: return .yellow
        }
    }
}
