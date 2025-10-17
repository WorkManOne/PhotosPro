import Foundation
import SwiftUI

struct ClientModel: Identifiable, Codable {
    var id = UUID()
    var name: String
    var email: String
    var phone: String
    var company: String?
    var position: String?
    var address: String
    var city: String
    var country: String
    var clientType: ClientType
    var status: ClientStatus
    var source: ClientSource
    var budget: Double
    var preferredContact: ContactMethod
    var notes: String
    var tags: [String]
    var totalProjects: Int
    var totalRevenue: Double
    var rating: Int
    var isVIP: Bool
    var socialMedia: [String: String]
    var createdDate: Date
    
    init(name: String = "", email: String = "", phone: String = "", company: String? = nil, position: String? = nil, address: String = "", city: String = "", country: String = "", clientType: ClientType = .individual, status: ClientStatus = .prospect, source: ClientSource = .referral, budget: Double = 0.0, preferredContact: ContactMethod = .email, notes: String = "", tags: [String] = [], totalProjects: Int = 0, totalRevenue: Double = 0.0, rating: Int = 5, isVIP: Bool = false, socialMedia: [String: String] = [:], createdDate: Date = Date()) {
        self.name = name
        self.email = email
        self.phone = phone
        self.company = company
        self.position = position
        self.address = address
        self.city = city
        self.country = country
        self.clientType = clientType
        self.status = status
        self.source = source
        self.budget = budget
        self.preferredContact = preferredContact
        self.notes = notes
        self.tags = tags
        self.totalProjects = totalProjects
        self.totalRevenue = totalRevenue
        self.rating = rating
        self.isVIP = isVIP
        self.socialMedia = socialMedia
        self.createdDate = createdDate
    }
}

enum ClientType: String, CaseIterable, Codable {
    case individual = "Individual"
    case business = "Business"
    case agency = "Agency"
    case magazine = "Magazine"
    case brand = "Brand"
    case influencer = "Influencer"
    case model = "Model"
    case other = "Other"
}

enum ClientStatus: String, CaseIterable, Codable {
    case prospect = "Prospect"
    case lead = "Lead"
    case active = "Active"
    case inactive = "Inactive"
    case lost = "Lost"
    case referral = "Referral"
    
    var color: Color {
        switch self {
        case .prospect: return .gray
        case .lead: return .blue
        case .active: return .green
        case .inactive: return .yellow
        case .lost: return .red
        case .referral: return .purple
        }
    }
}

enum ClientSource: String, CaseIterable, Codable {
    case referral = "Referral"
    case socialMedia = "Social Media"
    case website = "Website"
    case networking = "Networking"
    case advertising = "Advertising"
    case coldCall = "Cold Call"
    case exhibition = "Exhibition"
    case other = "Other"
}

enum ContactMethod: String, CaseIterable, Codable {
    case email = "Email"
    case phone = "Phone"
    case text = "Text"
    case whatsapp = "WhatsApp"
    case instagram = "Instagram"
    case facebook = "Facebook"
    case linkedin = "LinkedIn"
    case other = "Other"
}
