import Foundation
import UserNotifications
import UIKit

class NotificationManager {
    static let shared = NotificationManager()

    private init() {}

    func requestPermission(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }

    func scheduleNotification(withVibration: Bool) {
        let content = UNMutableNotificationContent()
        content.title = "Plan your photosessions!"
        content.body = "Add them to calendar or add new photos and clients"

        if withVibration {
            content.sound = .default
        } else {
            content.sound = nil
        }

        var triggerDate = DateComponents()
        triggerDate.hour = 10
        triggerDate.minute = 0

        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)

        let request = UNNotificationRequest(identifier: "daily", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }

    func removeScheduledNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    func openAppSettings() {
        if let settingsURL = URL(string: UIApplication.openSettingsURLString),
           UIApplication.shared.canOpenURL(settingsURL) {
            UIApplication.shared.open(settingsURL)
        }
    }
}
