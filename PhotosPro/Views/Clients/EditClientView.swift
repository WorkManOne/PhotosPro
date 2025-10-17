import SwiftUI

struct EditClientView: View {
    @EnvironmentObject var userService: UserService
    @Environment(\.dismiss) var dismiss
    
    @State private var client: ClientModel
    @State private var newTag = ""
    @State private var newSocialPlatform = ""
    @State private var newSocialHandle = ""
    
    init(client: ClientModel? = nil) {
        _client = State(initialValue: client ?? ClientModel())
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Basic Information")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    
                    VStack(spacing: 12) {
                        CustomTextField(title: "Name", text: $client.name)
                        CustomTextField(title: "Email", text: $client.email)
                        CustomTextField(title: "Phone", text: $client.phone)
                        CustomTextField(title: "Company", text: Binding(
                            get: { client.company ?? "" },
                            set: { client.company = $0.isEmpty ? nil : $0 }
                        ))
                        CustomTextField(title: "Position", text: Binding(
                            get: { client.position ?? "" },
                            set: { client.position = $0.isEmpty ? nil : $0 }
                        ))
                        
                        HStack {
                            Text("Client Type")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.titleGrayMain)
                            Spacer()
                            Picker("Client Type", selection: $client.clientType) {
                                ForEach(ClientType.allCases, id: \.self) { type in
                                    Text(type.rawValue).tag(type)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        
                        HStack {
                            Text("Status")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.titleGrayMain)
                            Spacer()
                            Picker("Status", selection: $client.status) {
                                ForEach(ClientStatus.allCases, id: \.self) { status in
                                    Text(status.rawValue).tag(status)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                    }
                }
                .lightFramed()
                VStack(alignment: .leading, spacing: 12) {
                    Text("Contact & Location")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    
                    VStack(spacing: 12) {
                        CustomTextField(title: "Address", text: $client.address)
                        CustomTextField(title: "City", text: $client.city)
                        CustomTextField(title: "Country", text: $client.country)
                        
                        HStack {
                            Text("Preferred Contact")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.titleGrayMain)
                            Spacer()
                            Picker("Contact Method", selection: $client.preferredContact) {
                                ForEach(ContactMethod.allCases, id: \.self) { method in
                                    Text(method.rawValue).tag(method)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        
                        HStack {
                            Text("Source")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.titleGrayMain)
                            Spacer()
                            Picker("Source", selection: $client.source) {
                                ForEach(ClientSource.allCases, id: \.self) { source in
                                    Text(source.rawValue).tag(source)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                    }
                }
                .lightFramed()
                VStack(alignment: .leading, spacing: 12) {
                    Text("Business Information")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    
                    VStack(spacing: 12) {
                        HStack {
                            Text("Budget")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.titleGrayMain)
                            Spacer()
                            TextField("0", value: $client.budget, format: .currency(code: "USD"))
                                .keyboardType(.decimalPad)
                                .darkFramed(isBordered: true)
                        }
                        
                        HStack {
                            Text("Rating")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.titleGrayMain)
                            Spacer()
                            HStack(spacing: 4) {
                                ForEach(1...5, id: \.self) { star in
                                    Button(action: {
                                        client.rating = star
                                    }) {
                                        Image(systemName: star <= client.rating ? "star.fill" : "star")
                                            .font(.system(size: 20))
                                            .foregroundColor(.yellow)
                                    }
                                }
                            }
                        }
                        
                        Toggle("VIP Client", isOn: $client.isVIP)
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
                                .lightFramed(isBordered: true)
                                .onSubmit {
                                    if !newTag.isEmpty {
                                        client.tags.append(newTag)
                                        newTag = ""
                                    }
                                }
                            
                            Button("Add") {
                                if !newTag.isEmpty {
                                    client.tags.append(newTag)
                                    newTag = ""
                                }
                            }
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.gradientBlue)
                        }
                        
                        if !client.tags.isEmpty {
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                                ForEach(client.tags, id: \.self) { tag in
                                    HStack {
                                        Text("#\(tag)")
                                            .font(.system(size: 12, weight: .medium))
                                            .foregroundColor(.gradientBlue)
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            client.tags.removeAll { $0 == tag }
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
                    
                    CustomTextField(title: "Additional Notes", text: $client.notes, isMultiline: true)
                }
                .lightFramed()
            }
            .padding(.horizontal, 20)
            .padding(.top, getSafeAreaTop() + 100)
            
            Button(action: {
                saveClient()
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
        .customHeader(title: "Edit Client", isDismiss: true)
    }
    
    private func saveClient() {
        if let index = userService.clients.firstIndex(where: { $0.id == client.id }) {
            userService.clients[index] = client
        } else {
            userService.clients.append(client)
        }
    }
}

#Preview {
    NavigationStack {
        EditClientView()
            .environmentObject(UserService())
            .preferredColorScheme(.dark)
    }
}
