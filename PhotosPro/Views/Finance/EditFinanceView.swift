import SwiftUI

struct EditFinanceView: View {
    @EnvironmentObject var userService: UserService
    @Environment(\.dismiss) var dismiss
    
    @State private var finance: FinanceModel
    @State private var newTag = ""
    
    init(finance: FinanceModel? = nil) {
        _finance = State(initialValue: finance ?? FinanceModel())
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Basic Information")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    
                    VStack(spacing: 12) {
                        CustomTextField(title: "Title", text: $finance.title)
                        CustomTextField(title: "Description", text: $finance.description, isMultiline: true)
                        
                        HStack {
                            Text("Type")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.titleGrayMain)
                            Spacer()
                            Picker("Type", selection: $finance.type) {
                                ForEach(FinanceType.allCases, id: \.self) { type in
                                    Text(type.rawValue).tag(type)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        
                        HStack {
                            Text("Category")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.titleGrayMain)
                            Spacer()
                            Picker("Category", selection: $finance.category) {
                                ForEach(FinanceCategory.allCases, id: \.self) { category in
                                    Text(category.rawValue).tag(category)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        
                        HStack {
                            Text("Amount")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.titleGrayMain)
                            Spacer()
                            TextField("0", value: $finance.amount, format: .currency(code: finance.currency))
                                .keyboardType(.decimalPad)
                                .lightFramed(isBordered: true)
                        }
                        
                        HStack {
                            Text("Currency")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.titleGrayMain)
                            Spacer()
                            TextField("USD", text: $finance.currency)
                                .lightFramed(isBordered: true)
                        }
                        
                        DatePicker("Date", selection: $finance.date, displayedComponents: .date)
                            .datePickerStyle(.compact)
                            .colorScheme(.dark)
                            .accentColor(.primaryBlue)
                    }
                }
                .lightFramed()
                VStack(alignment: .leading, spacing: 12) {
                    Text("Project Information")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    
                    VStack(spacing: 12) {
                        CustomTextField(title: "Client Name", text: Binding(
                            get: { finance.clientName ?? "" },
                            set: { finance.clientName = $0.isEmpty ? nil : $0 }
                        ))
                        CustomTextField(title: "Project Name", text: Binding(
                            get: { finance.projectName ?? "" },
                            set: { finance.projectName = $0.isEmpty ? nil : $0 }
                        ))
                        
                        HStack {
                            Text("Payment Method")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.titleGrayMain)
                            Spacer()
                            Picker("Payment Method", selection: $finance.paymentMethod) {
                                ForEach(PaymentMethod.allCases, id: \.self) { method in
                                    Text(method.rawValue).tag(method)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        
                        HStack {
                            Text("Status")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.titleGrayMain)
                            Spacer()
                            Picker("Status", selection: $finance.status) {
                                ForEach(PaymentStatus.allCases, id: \.self) { status in
                                    Text(status.rawValue).tag(status)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                    }
                }
                .lightFramed()
                VStack(alignment: .leading, spacing: 12) {
                    Text("Invoice & Tax")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    
                    VStack(spacing: 12) {
                        CustomTextField(title: "Invoice Number", text: Binding(
                            get: { finance.invoiceNumber ?? "" },
                            set: { finance.invoiceNumber = $0.isEmpty ? nil : $0 }
                        ))
                        
                        HStack {
                            Text("Tax Amount")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.titleGrayMain)
                            Spacer()
                            TextField("0", value: $finance.taxAmount, format: .currency(code: finance.currency))
                                .lightFramed(isBordered: true)
                                .keyboardType(.decimalPad)
                        }
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
                                .lightFramed(isBordered: true)
                                .onSubmit {
                                    if !newTag.isEmpty {
                                        finance.tags.append(newTag)
                                        newTag = ""
                                    }
                                }
                            
                            Button("Add") {
                                if !newTag.isEmpty {
                                    finance.tags.append(newTag)
                                    newTag = ""
                                }
                            }
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.gradientBlue)
                        }
                        
                        if !finance.tags.isEmpty {
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                                ForEach(finance.tags, id: \.self) { tag in
                                    HStack {
                                        Text("#\(tag)")
                                            .font(.system(size: 12, weight: .medium))
                                            .foregroundColor(.gradientBlue)

                                        Spacer()
                                        
                                        Button(action: {
                                            finance.tags.removeAll { $0 == tag }
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
                                            .fill(.gradientBlue.opacity(0.2))
                                    )
                                }
                            }
                        }
                    }
                }
                .lightFramed()
                VStack(alignment: .leading, spacing: 12) {
                    Text("Notes")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    
                    CustomTextField(title: "Additional Notes", text: $finance.notes, isMultiline: true)
                }
                .lightFramed()
            }
            .padding(.horizontal, 20)
            .padding(.top, getSafeAreaTop() + 100)

            Button(action: {
                saveFinance()
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
        .customHeader(title: "Edit Finance", isDismiss: true)
    }
    
    private func saveFinance() {
        if let index = userService.finances.firstIndex(where: { $0.id == finance.id }) {
            userService.finances[index] = finance
        } else {
            userService.finances.append(finance)
        }
    }
}

#Preview {
    NavigationStack {
        EditFinanceView()
            .environmentObject(UserService())
            .preferredColorScheme(.dark)
    }
}
