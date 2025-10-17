import SwiftUI

struct IdeasView: View {
    @EnvironmentObject var userService: UserService
    @State private var selectedStatus: SessionStatus? = nil
    @State private var searchText = ""
    
    var filteredSessions: [PhotoSessionModel] {
        var filtered = userService.photoSessions
        
        if let status = selectedStatus {
            filtered = filtered.filter { $0.status == status }
        }
        
        if !searchText.isEmpty {
            filtered = filtered.filter { 
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.description.localizedCaseInsensitiveContains(searchText) ||
                $0.concept.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        return filtered.sorted { $0.priority.rawValue > $1.priority.rawValue }
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                ScrollView {
                    LazyVStack(spacing: 15) {
                        VStack(spacing: 5) {
                            Text("\(userService.photoSessions.count)")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.gradientBlue)
                            Text("Photo Ideas")
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
                                                .fill(selectedStatus == nil ? .gradientBlue : .surfaceGray)
                                        )
                                }
                                
                                ForEach(SessionStatus.allCases, id: \.self) { status in
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
                            ForEach(filteredSessions) { session in
                                NavigationLink {
                                    EditPhotoSessionView(photoSession: session)
                                } label: {
                                    PhotoSessionPreviewView(photoSession: session)
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
                EditPhotoSessionView()
            } label: {
                Text("+ Add Idea")
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
        .customHeader(title: "Ideas", image: Image(systemName: "lightbulb"))
    }
}

#Preview {
    NavigationStack {
        IdeasView()
            .environmentObject(UserService())
            .preferredColorScheme(.dark)
    }
}
