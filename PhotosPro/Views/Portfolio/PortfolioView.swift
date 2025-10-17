import SwiftUI

struct PortfolioView: View {
    @EnvironmentObject var userService: UserService
    @State private var selectedCategory: PortfolioCategory? = nil
    @State private var searchText = ""
    
    var filteredPortfolio: [PortfolioModel] {
        var filtered = userService.portfolio
        
        if let category = selectedCategory {
            filtered = filtered.filter { $0.category == category }
        }
        
        if !searchText.isEmpty {
            filtered = filtered.filter { 
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.description.localizedCaseInsensitiveContains(searchText) ||
                $0.tags.contains { $0.localizedCaseInsensitiveContains(searchText) }
            }
        }
        
        return filtered.sorted { $0.isFavorite && !$1.isFavorite }
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                ScrollView {
                    LazyVStack(spacing: 15) {
                        VStack(spacing: 5) {
                            Text("\(userService.portfolio.count)")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.gradientBlue)
                            Text("Total Photos")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(.titleGrayMain)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                Button(action: {
                                    selectedCategory = nil
                                }) {
                                    Text("All")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(selectedCategory == nil ? .backgroundMain : .titleGrayMain)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(
                                            RoundedRectangle(cornerRadius: 15)
                                                .fill(selectedCategory == nil ? .gradientBlue : .surfaceGray)
                                        )
                                }
                                
                                ForEach(PortfolioCategory.allCases, id: \.self) { category in
                                    Button(action: {
                                        selectedCategory = category
                                    }) {
                                        Text(category.rawValue)
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundColor(selectedCategory == category ? .backgroundMain : .titleGrayMain)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 6)
                                            .background(
                                                RoundedRectangle(cornerRadius: 15)
                                                    .fill(selectedCategory == category ? .gradientBlue : .surfaceGray)
                                            )
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        .padding(.bottom, 10)
                        LazyVStack {
                            ForEach(filteredPortfolio) { item in
                                NavigationLink {
                                    EditPortfolioView(portfolio: item)
                                } label: {
                                    PortfolioPreviewView(portfolio: item)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    .padding(.top, getSafeAreaTop() + 100)
                    .padding(.bottom, getSafeAreaBottom() + 200)
                }
            }
            NavigationLink {
                EditPortfolioView()
            } label: {
                Text("+ Add Photo")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .colorFramed(color: .gradientBlue)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.horizontal, 20)
            .padding(.bottom, getSafeAreaBottom() + 120)
        }
        .customHeader(title: "Portfolio", image: Image(systemName: "photo.on.rectangle"))
    }
}

#Preview {
    NavigationStack {
        PortfolioView()
            .environmentObject(UserService())
            .preferredColorScheme(.dark)
    }
}
