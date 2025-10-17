import Foundation
import SwiftUI

struct PortfolioModel: Identifiable, Codable {
    var id = UUID()
    var title: String
    var description: String
    var category: PortfolioCategory
    var shootingDate: Date
    var location: String
    var camera: String
    var lens: String
    var settings: String
    var tags: [String]
    var isFavorite: Bool
    var rating: Int
    var imageData: Data?
    var clientName: String?
    var projectType: ProjectType
    var createdDate: Date
    
    init(title: String = "", description: String = "", category: PortfolioCategory = .portrait, shootingDate: Date = Date(), location: String = "", camera: String = "", lens: String = "", settings: String = "", tags: [String] = [], isFavorite: Bool = false, rating: Int = 5, imageData: Data? = nil, clientName: String? = nil, projectType: ProjectType = .personal, createdDate: Date = Date()) {
        self.title = title
        self.description = description
        self.category = category
        self.shootingDate = shootingDate
        self.location = location
        self.camera = camera
        self.lens = lens
        self.settings = settings
        self.tags = tags
        self.isFavorite = isFavorite
        self.rating = rating
        self.imageData = imageData
        self.clientName = clientName
        self.projectType = projectType
        self.createdDate = createdDate
    }
}

enum PortfolioCategory: String, CaseIterable, Codable {
    case portrait = "Portrait"
    case landscape = "Landscape"
    case wedding = "Wedding"
    case commercial = "Commercial"
    case fashion = "Fashion"
    case street = "Street"
    case nature = "Nature"
    case architecture = "Architecture"
    case sports = "Sports"
    case macro = "Macro"
    case other = "Other"
    
    var color: Color {
        switch self {
        case .portrait: return .blue
        case .landscape: return .green
        case .wedding: return .pink
        case .commercial: return .orange
        case .fashion: return .purple
        case .street: return .gray
        case .nature: return .mint
        case .architecture: return .brown
        case .sports: return .red
        case .macro: return .yellow
        case .other: return .secondary
        }
    }
}

enum ProjectType: String, CaseIterable, Codable {
    case personal = "Personal"
    case commercial = "Commercial"
    case client = "Client Work"
    case portfolio = "Portfolio"
    case test = "Test Shoot"
}
