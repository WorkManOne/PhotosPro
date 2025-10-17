import SwiftUI

struct ClientsView: View {
    @EnvironmentObject var userService: UserService
    @State private var selectedStatus: ClientStatus? = nil
    @State private var searchText = ""
    
    var filteredClients: [ClientModel] {
        var filtered = userService.clients
        
        if let status = selectedStatus {
            filtered = filtered.filter { $0.status == status }
        }
        
        if !searchText.isEmpty {
            filtered = filtered.filter { 
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.company?.localizedCaseInsensitiveContains(searchText) == true ||
                $0.email.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        return filtered.sorted { $0.isVIP && !$1.isVIP }
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                ScrollView {
                    LazyVStack(spacing: 15) {
                        VStack(spacing: 5) {
                            Text("\(userService.clients.count)")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.gradientBlue)
                            Text("Total Clients")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(.titleGrayMain)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                Button(action: {
                                    selectedStatus = nil
                                }) {
                                    Text("All")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(selectedStatus == nil ? .backgroundMain : .titleGrayMain)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(
                                            RoundedRectangle(cornerRadius: 15)
                                                .fill(selectedStatus == nil ? .gradientBlue : .darkGrayMain)
                                        )
                                }
                                
                                ForEach(ClientStatus.allCases, id: \.self) { status in
                                    Button(action: {
                                        selectedStatus = status
                                    }) {
                                        Text(status.rawValue)
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundColor(selectedStatus == status ? .backgroundMain : .titleGrayMain)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 6)
                                            .background(
                                                RoundedRectangle(cornerRadius: 15)
                                                    .fill(selectedStatus == status ? status.color : .darkGrayMain)
                                            )
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        .padding(.bottom, 10)
                        LazyVStack(spacing: 12) {
                            ForEach(filteredClients) { client in
                                NavigationLink {
                                    EditClientView(client: client)
                                } label: {
                                    ClientPreviewView(client: client)
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
                EditClientView()
            } label: {
                Text("+ Add Client")
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
        .customHeader(title: "Clients", image: Image(systemName: "person.2"))
    }
}

#Preview {
    NavigationStack {
        ClientsView()
            .environmentObject(UserService())
            .preferredColorScheme(.dark)
    }
}
