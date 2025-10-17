import SwiftUI

struct EditPortfolioView: View {
    @EnvironmentObject var userService: UserService
    @Environment(\.dismiss) var dismiss
    
    @State private var portfolio: PortfolioModel
    @State private var showingImagePicker = false
    @State private var newTag = ""
    
    init(portfolio: PortfolioModel? = nil) {
        let initialPortfolio = portfolio ?? PortfolioModel()
        _portfolio = State(initialValue: initialPortfolio)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Media")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    
                    ZStack {
                        if let imageData = portfolio.imageData, let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 200)
                                .clipped()
                                .cornerRadius(12)
                        } else {
                            Rectangle()
                                .fill(.darkGrayMain)
                                .frame(height: 200)
                                .cornerRadius(12)
                                .overlay {
                                    VStack(spacing: 10) {
                                        Text("Add Photo")
                                            .font(.system(size: 16, weight: .medium))
                                            .foregroundColor(.titleGrayMain)
                                    }
                                }
                        }
                        
                        VStack {
                            HStack {
                                Spacer()
                                Button(action: {
                                    showingImagePicker = true
                                }) {
                                    Image(systemName: "camera")
                                        .font(.system(size: 16))
                                        .foregroundColor(.white)
                                        .padding(8)
                                        .background(
                                            Circle()
                                                .fill(.gradientBlue)
                                        )
                                }
                            }
                            Spacer()
                        }
                        .padding(12)
                    }
                }
                .lightFramed()
                VStack(alignment: .leading, spacing: 12) {
                    Text("Basic Information")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    
                    VStack(spacing: 12) {
                        CustomTextField(title: "Title", text: $portfolio.title)
                        CustomTextField(title: "Description", text: $portfolio.description, isMultiline: true)
                        
                        HStack {
                            Text("Category")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.titleGrayMain)
                            Spacer()
                            Picker("Category", selection: $portfolio.category) {
                                ForEach(PortfolioCategory.allCases, id: \.self) { category in
                                    Text(category.rawValue).tag(category)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        
                        HStack {
                            Text("Project Type")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.titleGrayMain)
                            Spacer()
                            Picker("Project Type", selection: $portfolio.projectType) {
                                ForEach(ProjectType.allCases, id: \.self) { type in
                                    Text(type.rawValue).tag(type)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                    }
                }
                .lightFramed()
                VStack(alignment: .leading, spacing: 12) {
                    Text("Shooting Details")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    
                    VStack(spacing: 12) {
                        CustomTextField(title: "Location", text: $portfolio.location)
                        CustomTextField(title: "Camera", text: $portfolio.camera)
                        CustomTextField(title: "Lens", text: $portfolio.lens)
                        CustomTextField(title: "Settings", text: $portfolio.settings)
                        
                        DatePicker("Shooting Date", selection: $portfolio.shootingDate, displayedComponents: .date)
                            .datePickerStyle(.compact)
                            .colorScheme(.dark)
                            .accentColor(.gradientBlue)
                    }
                }
                .lightFramed()
                VStack(alignment: .leading, spacing: 12) {
                    Text("Client Information")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    
                    VStack(spacing: 12) {
                        CustomTextField(title: "Client Name", text: Binding(
                            get: { portfolio.clientName ?? "" },
                            set: { portfolio.clientName = $0.isEmpty ? nil : $0 }
                        ))
                        
                        HStack {
                            Text("Rating")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.titleGrayMain)
                            Spacer()
                            HStack(spacing: 4) {
                                ForEach(1...5, id: \.self) { star in
                                    Button(action: {
                                        portfolio.rating = star
                                    }) {
                                        Image(systemName: star <= portfolio.rating ? "star.fill" : "star")
                                            .font(.system(size: 20))
                                            .foregroundColor(.yellow)
                                    }
                                }
                            }
                        }
                        
                        Toggle("Favorite", isOn: $portfolio.isFavorite)
                            .toggleStyle(CustomToggleStyle())
                    }
                }
                .lightFramed()
                VStack(alignment: .leading, spacing: 12) {
                    Text("Tags")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    
                    VStack(spacing: 12) {
                        HStack {
                            TextField("Add tag", text: $newTag)
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(.white)
                                .padding(12)
                                .background(
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color("surfaceGray"))
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(.secondaryGray.opacity(0.3), lineWidth: 1)
                                    }
                                )
                                .onSubmit {
                                    if !newTag.isEmpty {
                                        portfolio.tags.append(newTag)
                                        newTag = ""
                                    }
                                }
                            
                            Button("Add") {
                                if !newTag.isEmpty {
                                    portfolio.tags.append(newTag)
                                    newTag = ""
                                }
                            }
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.primaryBlue)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(.primaryBlue.opacity(0.2))
                            )
                        }
                        
                        if !portfolio.tags.isEmpty {
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                                ForEach(portfolio.tags, id: \.self) { tag in
                                    HStack {
                                        Text("#\(tag)")
                                            .font(.system(size: 12, weight: .medium))
                                            .foregroundColor(.primaryBlue)
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            portfolio.tags.removeAll { $0 == tag }
                                        }) {
                                            Image(systemName: "xmark")
                                                .font(.system(size: 10))
                                                .foregroundColor(.red)
                                        }
                                    }
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(
                                        RoundedRectangle(cornerRadius: 6)
                                            .fill(.primaryBlue.opacity(0.2))
                                    )
                                }
                            }
                        }
                    }
                }
                .lightFramed()
            }
            .padding(.horizontal, 20)
            .padding(.top, getSafeAreaTop() + 100)
            Button(action: {
                savePortfolio()
                dismiss()
            }) {
                Text("Save")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .colorFramed(color: .gradientBlue)
            }
            .padding(.top, 10)
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .customHeader(title: "Edit Portfolio", isDismiss: true)
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker { data in
                portfolio.imageData = data
            }
        }
    }
    
    private func savePortfolio() {
        if let index = userService.portfolio.firstIndex(where: { $0.id == portfolio.id }) {
            userService.portfolio[index] = portfolio
        } else {
            userService.portfolio.append(portfolio)
        }
    }
}


#Preview {
    NavigationStack {
        EditPortfolioView()
            .environmentObject(UserService())
            .preferredColorScheme(.dark)
    }
}
