import Foundation
import SwiftUI

struct FinanceModel: Identifiable, Codable {
    var id = UUID()
    var title: String
    var description: String
    var type: FinanceType
    var category: FinanceCategory
    var amount: Double
    var currency: String
    var date: Date
    var clientName: String?
    var projectName: String?
    var paymentMethod: PaymentMethod
    var status: PaymentStatus
    var invoiceNumber: String?
    var taxAmount: Double
    var notes: String
    var tags: [String]
    var createdDate: Date
    
    init(title: String = "", description: String = "", type: FinanceType = .income, category: FinanceCategory = .shooting, amount: Double = 0.0, currency: String = "USD", date: Date = Date(), clientName: String? = nil, projectName: String? = nil, paymentMethod: PaymentMethod = .cash, status: PaymentStatus = .pending, invoiceNumber: String? = nil, taxAmount: Double = 0.0, notes: String = "", tags: [String] = [], createdDate: Date = Date()) {
        self.title = title
        self.description = description
        self.type = type
        self.category = category
        self.amount = amount
        self.currency = currency
        self.date = date
        self.clientName = clientName
        self.projectName = projectName
        self.paymentMethod = paymentMethod
        self.status = status
        self.invoiceNumber = invoiceNumber
        self.taxAmount = taxAmount
        self.notes = notes
        self.tags = tags
        self.createdDate = createdDate
    }
}

enum FinanceType: String, CaseIterable, Codable {
    case income = "Income"
    case expense = "Expense"
    case investment = "Investment"
    case tax = "Tax"
    
    var color: Color {
        switch self {
        case .income: return .green
        case .expense: return .red
        case .investment: return .blue
        case .tax: return .orange
        }
    }
}

enum FinanceCategory: String, CaseIterable, Codable {
    case shooting = "Shooting"
    case editing = "Editing"
    case equipment = "Equipment"
    case marketing = "Marketing"
    case travel = "Travel"
    case studio = "Studio"
    case software = "Software"
    case education = "Education"
    case insurance = "Insurance"
    case office = "Office"
    case other = "Other"
    
    var color: Color {
        switch self {
        case .shooting: return .blue
        case .editing: return .purple
        case .equipment: return .brown
        case .marketing: return .orange
        case .travel: return .mint
        case .studio: return .pink
        case .software: return .yellow
        case .education: return .green
        case .insurance: return .red
        case .office: return .gray
        case .other: return .secondary
        }
    }
}

enum PaymentMethod: String, CaseIterable, Codable {
    case cash = "Cash"
    case card = "Card"
    case bank = "Bank Transfer"
    case paypal = "PayPal"
    case stripe = "Stripe"
    case check = "Check"
    case crypto = "Cryptocurrency"
    case other = "Other"
}

enum PaymentStatus: String, CaseIterable, Codable {
    case pending = "Pending"
    case paid = "Paid"
    case overdue = "Overdue"
    case cancelled = "Cancelled"
    case refunded = "Refunded"
    
    var color: Color {
        switch self {
        case .pending: return .yellow
        case .paid: return .green
        case .overdue: return .red
        case .cancelled: return .gray
        case .refunded: return .blue
        }
    }
}
