import SwiftUI

func getSafeAreaBottom() -> CGFloat {
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let window = windowScene.windows.first else {
        return 44
    }
    return window.safeAreaInsets.bottom
}

func getSafeAreaTop() -> CGFloat {
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let window = windowScene.windows.first else {
        return 44
    }
    return window.safeAreaInsets.top
}

extension View {
    func customHeader(
        title: String,
        image: Image? = nil,
        isDismiss: Bool = false,
    ) -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
            .navigationTitle("")
            .background(.backgroundMain)
            .overlay {
                CustomHeader(title: title, image: image, isDismiss: isDismiss)
            }
            .onAppear {
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first,
                   let nav = window.rootViewController?.children.first as? UINavigationController {
                    nav.interactivePopGestureRecognizer?.isEnabled = true
                    nav.interactivePopGestureRecognizer?.delegate = nil
                }
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                                to: nil, from: nil, for: nil)
            }
    }
}

struct CustomHeader: View {
    var title: String
    var image: Image? = nil
    var isDismiss: Bool = false

    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 0) {
            HStack (spacing: 10) {
                if let image = image {
                    image
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.backgroundMain)
                        .frame(width: 15, height: 15)
                        .padding(10)
                        .background(
                            Circle()
                                .fill(.gradientBlue)
                        )

                }
                Text(title)
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                Spacer()
                if !isDismiss {
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Image(systemName: "person.fill")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.gradientBlue)
                            .padding(8)
                            .background(
                                Circle()
                                    .fill(.gradientBlue.opacity(0.2))
                            )
                            .frame(width: 35, height: 35)
                    }

                } else {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Cancel")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.secondaryGray)
                    }
                }
            }
            .frame(height: 35)
            .padding(.vertical, 10)
            .padding(.bottom, 10)
            .padding(.horizontal, 20)
            .padding(.top, 8)
            .padding(.top, getSafeAreaTop())
            .background(Color.backgroundMain)
            .overlay (alignment: .bottom) {
                Rectangle()
                    .fill(.grayMain)
                    .frame(height: 1)
                    .padding(.horizontal, -20)
            }
            Spacer()
        }
        .ignoresSafeArea(edges: .top)

    }
}



#Preview {
    NavigationStack {
        VStack {
            Text("a")
            NavigationLink("nav") {
                ZStack {
                    Text("wow")

                }

                .customHeader(title: "Home", isDismiss: true)
            }
        }
        .customHeader(title: "MainView", image: Image("magnet"), isDismiss: false)
    }
}
