import Foundation
import SwiftUI

class UserService: ObservableObject {
    @AppStorage("isNotificationEnabled") var isNotificationEnabled: Bool = false
    @AppStorage("isVibrationEnabled") var isVibrationEnabled: Bool = true

    @Published var portfolio: [PortfolioModel] {
        didSet {
            UserDefaults.standard.set(try? JSONEncoder().encode(portfolio), forKey: "portfolio")
        }
    }

    @Published var photoSessions: [PhotoSessionModel] {
        didSet {
            UserDefaults.standard.set(try? JSONEncoder().encode(photoSessions), forKey: "photoSessions")
        }
    }

    @Published var clients: [ClientModel] {
        didSet {
            UserDefaults.standard.set(try? JSONEncoder().encode(clients), forKey: "clients")
        }
    }

    @Published var tasks: [TaskModel] {
        didSet {
            UserDefaults.standard.set(try? JSONEncoder().encode(tasks), forKey: "tasks")
        }
    }

    @Published var finances: [FinanceModel] {
        didSet {
            UserDefaults.standard.set(try? JSONEncoder().encode(finances), forKey: "finances")
        }
    }

    init() {
        let userDefaults = UserDefaults.standard
        if let data = userDefaults.data(forKey: "portfolio"),
           let decoded = try? JSONDecoder().decode([PortfolioModel].self, from: data) {
            portfolio = decoded
        } else {
            portfolio = []
        }
        if let data = userDefaults.data(forKey: "photoSessions"),
           let decoded = try? JSONDecoder().decode([PhotoSessionModel].self, from: data) {
            photoSessions = decoded
        } else {
            photoSessions = []
        }
        if let data = userDefaults.data(forKey: "clients"),
           let decoded = try? JSONDecoder().decode([ClientModel].self, from: data) {
            clients = decoded
        } else {
            clients = []
        }
        if let data = userDefaults.data(forKey: "tasks"),
           let decoded = try? JSONDecoder().decode([TaskModel].self, from: data) {
            tasks = decoded
        } else {
            tasks = []
        }
        if let data = userDefaults.data(forKey: "finances"),
           let decoded = try? JSONDecoder().decode([FinanceModel].self, from: data) {
            finances = decoded
        } else {
            finances = []
        }
    }

    func reset() {
        isNotificationEnabled = false
        portfolio = []
        photoSessions = []
        clients = []
        tasks = []
        finances = []
    }

    func toggleNotifications(to newValue: Bool, onDenied: @escaping () -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                switch settings.authorizationStatus {
                case .denied:
                    onDenied()
                    self.isNotificationEnabled = false
                    NotificationManager.shared.removeScheduledNotifications()

                case .notDetermined:
                    NotificationManager.shared.requestPermission { granted in
                        DispatchQueue.main.async {
                            self.isNotificationEnabled = granted && newValue
                            if !granted || !newValue {
                                NotificationManager.shared.removeScheduledNotifications()
                            }
                        }
                    }

                case .authorized, .provisional, .ephemeral:
                    self.isNotificationEnabled = newValue
                    if !newValue {
                        NotificationManager.shared.removeScheduledNotifications()
                    }

                @unknown default:
                    self.isNotificationEnabled = false
                    NotificationManager.shared.removeScheduledNotifications()
                }
            }
        }
    }
}
