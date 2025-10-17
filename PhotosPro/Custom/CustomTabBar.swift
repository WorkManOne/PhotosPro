import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Int

    var body: some View {
        HStack (alignment: .top) {
            Spacer()
            TabBarButton(icon: Image(systemName: "photo.on.rectangle"), title: "Portfolio", index: 0, selectedTab: $selectedTab)
            Spacer()
            TabBarButton(icon: Image(systemName: "lightbulb"), title: "Ideas", index: 1, selectedTab: $selectedTab)
            Spacer()
            TabBarButton(icon: Image(systemName: "person.2"), title: "Clients", index: 2, selectedTab: $selectedTab)
            Spacer()
            TabBarButton(icon: Image(systemName: "checklist"), title: "Tasks", index: 3, selectedTab: $selectedTab)
            Spacer()
            TabBarButton(icon: Image(systemName: "dollarsign.circle"), title: "Finance", index: 4, selectedTab: $selectedTab)
            Spacer()
        }
        .padding(.vertical, 20)
        .padding(.bottom, getSafeAreaBottom())
        .background(
            Rectangle()
                .fill(.backgroundMain)
        )
        .overlay (alignment: .top) {
            Rectangle()
                .fill(.grayMain)
                .frame(height: 1)
        }

    }
}

struct TabBarButton: View {
    let icon: Image
    let title: String
    let index: Int
    @Binding var selectedTab: Int

    var body: some View {
        Button(action: {
            selectedTab = index
        }) {
            VStack(spacing: 4) {
                icon
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .padding(10)
                    .foregroundColor(selectedTab == index ? .gradientBlue : .secondaryGray)
                Text(title)
                    .font(.system(size: 10))
                    .foregroundColor(selectedTab == index ? .gradientBlue : .secondaryGray)
                    .minimumScaleFactor(0.7)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    CustomTabBar(selectedTab: .constant(0))
        .ignoresSafeArea()
}
