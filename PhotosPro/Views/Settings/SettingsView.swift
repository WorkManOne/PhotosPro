import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var userService: UserService
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("App Information")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    
                    VStack(spacing: 12) {
                        HStack {
                            Text("Version")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.titleGrayMain)
                            Spacer()
                            Text("1.0.0")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(.textGrayMain)
                        }
                        
                        HStack {
                            Text("Build")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.titleGrayMain)
                            Spacer()
                            Text("1")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(.textGrayMain)
                        }
                    }
                }
                .lightFramed()
                VStack(alignment: .leading, spacing: 12) {
                    Text("Notifications")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    
                    VStack(spacing: 12) {
                        Toggle("Enable Notifications", isOn: $userService.isNotificationEnabled)
                            .toggleStyle(CustomToggleStyle())
                            .onChange(of: userService.isNotificationEnabled) { newValue in
                                userService.toggleNotifications(to: newValue) {
                                }
                            }
                        
                        Toggle("Vibration", isOn: $userService.isVibrationEnabled)
                            .toggleStyle(CustomToggleStyle())
                    }
                }
                .lightFramed()
                VStack(alignment: .leading, spacing: 12) {
                    Text("Data Management")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    
                    VStack(spacing: 12) {
                        Button(action: {
                            userService.reset()
                        }) {
                            Text("Reset All Data")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(.red.opacity(0.2))
                                )
                        }
                        
                        Text("This will delete all your data and cannot be undone.")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(.textGrayMain)
                            .multilineTextAlignment(.center)
                    }
                }
                .lightFramed()
                VStack(alignment: .leading, spacing: 12) {
                    Text("About PhotosPro")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    
                    VStack(spacing: 12) {
                        Text("PhotosPro is a comprehensive photography organizer designed for professional photographers. Manage your portfolio, plan sessions, track clients, organize tasks, and monitor your business finances.")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.textGrayMain)
                            .multilineTextAlignment(.leading)
                            .lineSpacing(4)
                    }
                }
                .lightFramed()
            }
            .padding(.horizontal, 20)
            .padding(.top, getSafeAreaTop() + 100)
            .padding(.bottom, getSafeAreaBottom() + 100)
        }
        .customHeader(title: "Settings", isDismiss: true)
    }
}

#Preview {
    NavigationStack {
        SettingsView()
            .environmentObject(UserService())
            .preferredColorScheme(.dark)
    }
}
