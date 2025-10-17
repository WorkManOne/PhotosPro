import Foundation
import SwiftUI

struct PhotoSessionModel: Identifiable, Codable {
    var id = UUID()
    var title: String
    var description: String
    var concept: String
    var mood: String
    var location: String
    var equipment: [String]
    var models: [String]
    var team: [String]
    var budget: Double
    var priority: SessionPriority
    var status: SessionStatus
    var scheduledDate: Date?
    var estimatedDuration: Int // in hours
    var weatherDependency: Bool
    var indoorOutdoor: IndoorOutdoor
    var lighting: LightingType
    var style: PhotoStyle
    var inspirationImages: [Data]
    var notes: String
    var createdDate: Date
    
    init(title: String = "", description: String = "", concept: String = "", mood: String = "", location: String = "", equipment: [String] = [], models: [String] = [], team: [String] = [], budget: Double = 0.0, priority: SessionPriority = .medium, status: SessionStatus = .idea, scheduledDate: Date? = nil, estimatedDuration: Int = 2, weatherDependency: Bool = false, indoorOutdoor: IndoorOutdoor = .indoor, lighting: LightingType = .natural, style: PhotoStyle = .modern, inspirationImages: [Data] = [], notes: String = "", createdDate: Date = Date()) {
        self.title = title
        self.description = description
        self.concept = concept
        self.mood = mood
        self.location = location
        self.equipment = equipment
        self.models = models
        self.team = team
        self.budget = budget
        self.priority = priority
        self.status = status
        self.scheduledDate = scheduledDate
        self.estimatedDuration = estimatedDuration
        self.weatherDependency = weatherDependency
        self.indoorOutdoor = indoorOutdoor
        self.lighting = lighting
        self.style = style
        self.inspirationImages = inspirationImages
        self.notes = notes
        self.createdDate = createdDate
    }
}

enum SessionPriority: String, CaseIterable, Codable {
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

enum SessionStatus: String, CaseIterable, Codable {
    case idea = "Idea"
    case planning = "Planning"
    case scheduled = "Scheduled"
    case inProgress = "In Progress"
    case completed = "Completed"
    case cancelled = "Cancelled"
    
    var color: Color {
        switch self {
        case .idea: return .gray
        case .planning: return .blue
        case .scheduled: return .yellow
        case .inProgress: return .orange
        case .completed: return .green
        case .cancelled: return .red
        }
    }
}

enum IndoorOutdoor: String, CaseIterable, Codable {
    case indoor = "Indoor"
    case outdoor = "Outdoor"
    case both = "Both"
}

enum LightingType: String, CaseIterable, Codable {
    case natural = "Natural"
    case studio = "Studio"
    case mixed = "Mixed"
    case lowLight = "Low Light"
    case goldenHour = "Golden Hour"
    case blueHour = "Blue Hour"
}

enum PhotoStyle: String, CaseIterable, Codable {
    case modern = "Modern"
    case vintage = "Vintage"
    case minimalist = "Minimalist"
    case dramatic = "Dramatic"
    case soft = "Soft"
    case bold = "Bold"
    case artistic = "Artistic"
    case documentary = "Documentary"
}
