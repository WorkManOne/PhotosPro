import SwiftUI

struct FinanceView: View {
    @EnvironmentObject var userService: UserService
    @State private var selectedType: FinanceType? = nil
    @State private var selectedCategory: FinanceCategory? = nil
    @State private var searchText = ""
    
    var filteredFinances: [FinanceModel] {
        var filtered = userService.finances
        
        if let type = selectedType {
            filtered = filtered.filter { $0.type == type }
        }
        
        if let category = selectedCategory {
            filtered = filtered.filter { $0.category == category }
        }
        
        if !searchText.isEmpty {
            filtered = filtered.filter { 
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.description.localizedCaseInsensitiveContains(searchText) ||
                $0.clientName?.localizedCaseInsensitiveContains(searchText) == true
            }
        }
        
        return filtered.sorted { $0.date > $1.date }
    }
    
    var totalIncome: Double {
        userService.finances.filter { $0.type == .income }.reduce(0) { $0 + $1.amount }
    }
    
    var totalExpenses: Double {
        userService.finances.filter { $0.type == .expense }.reduce(0) { $0 + $1.amount }
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                ScrollView {
                    LazyVStack(spacing: 15) {
                        // Financial Summary
                        VStack(spacing: 15) {
                            HStack {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("Total Income")
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundColor(.titleGrayMain)
                                    Text("$\(totalIncome, specifier: "%.2f")")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(.successGreen)
                                }
                                Spacer()
                                VStack(alignment: .trailing, spacing: 5) {
                                    Text("Total Expenses")
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundColor(.titleGrayMain)
                                    Text("$\(totalExpenses, specifier: "%.2f")")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(.red)
                                }
                            }
                            
                            HStack {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("Net Profit")
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundColor(.titleGrayMain)
                                    Text("$\(totalIncome - totalExpenses, specifier: "%.2f")")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(totalIncome - totalExpenses >= 0 ? .successGreen : .warningRed)
                                }
                                Spacer()
                            }
                        }
                        .lightFramed()
                        .padding(.horizontal, 20)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                Button(action: {
                                    selectedType = nil
                                }) {
                                    Text("All")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(selectedType == nil ? .backgroundMain : .titleGrayMain)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(
                                            RoundedRectangle(cornerRadius: 15)
                                                .fill(selectedType == nil ? .gradientBlue : .surfaceGray)
                                        )
                                }
                                
                                ForEach(FinanceType.allCases, id: \.self) { type in
                                    Button(action: {
                                        selectedType = type
                                    }) {
                                        Text(type.rawValue)
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundColor(selectedType == type ? .backgroundMain : .titleGrayMain)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 6)
                                            .background(
                                                RoundedRectangle(cornerRadius: 15)
                                                    .fill(selectedType == type ? type.color : .darkGrayMain)
                                            )
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        .padding(.bottom, 10)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                Button(action: {
                                    selectedCategory = nil
                                }) {
                                    Text("All Categories")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(selectedCategory == nil ? .backgroundMain : .titleGrayMain)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(
                                            RoundedRectangle(cornerRadius: 15)
                                                .fill(selectedCategory == nil ? .gradientBlue : .surfaceGray)
                                        )
                                }
                                
                                ForEach(FinanceCategory.allCases, id: \.self) { category in
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
                                                    .fill(selectedCategory == category ? category.color : .darkGrayMain)
                                            )
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        .padding(.bottom, 10)
                        LazyVStack(spacing: 12) {
                            ForEach(filteredFinances) { finance in
                                NavigationLink {
                                    EditFinanceView(finance: finance)
                                } label: {
                                    FinancePreviewView(finance: finance)
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
                EditFinanceView()
            } label: {
                Text("+ Add Transaction")
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
        .customHeader(title: "Finance", image: Image(systemName: "dollarsign.circle"))
    }
}

#Preview {
    NavigationStack {
        FinanceView()
            .environmentObject(UserService())
            .preferredColorScheme(.dark)
    }
}
