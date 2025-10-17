import SwiftUI

struct ClientPreviewView: View {
    let client: ClientModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(client.name)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .lineLimit(1)
                        
                        if client.isVIP {
                            Image(systemName: "crown.fill")
                                .font(.system(size: 14))
                                .foregroundColor(.yellow)
                        }
                    }
                    
                    if let company = client.company {
                        Text(company)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.textGrayMain)
                            .lineLimit(1)
                    }
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(client.status.rawValue)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.backgroundMain)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(client.status.color)
                        )
                    
                    if client.rating > 0 {
                        HStack(spacing: 2) {
                            ForEach(1...5, id: \.self) { star in
                                Image(systemName: star <= client.rating ? "star.fill" : "star")
                                    .font(.system(size: 10))
                                    .foregroundColor(.yellow)
                            }
                        }
                    }
                }
            }
            VStack(alignment: .leading, spacing: 6) {
                if !client.email.isEmpty {
                    HStack {
                        Image(systemName: "envelope")
                            .font(.system(size: 12))
                            .foregroundColor(.titleGrayMain)
                            .frame(width: 16)
                        Text(client.email)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(.textGrayMain)
                            .lineLimit(1)
                    }
                }
                
                if !client.phone.isEmpty {
                    HStack {
                        Image(systemName: "phone")
                            .font(.system(size: 12))
                            .foregroundColor(.titleGrayMain)
                            .frame(width: 16)
                        Text(client.phone)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(.textGrayMain)
                            .lineLimit(1)
                    }
                }
                
                if !client.city.isEmpty {
                    HStack {
                        Image(systemName: "location")
                            .font(.system(size: 12))
                            .foregroundColor(.titleGrayMain)
                            .frame(width: 16)
                        Text(client.city)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(.textGrayMain)
                            .lineLimit(1)
                    }
                }
            }
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Projects: \(client.totalProjects)")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.titleGrayMain)
                    
                    if client.totalRevenue > 0 {
                        Text("Revenue: $\(client.totalRevenue, specifier: "%.0f")")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.white)
                    }
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 2) {
                    Text(client.clientType.rawValue)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.titleGrayMain)
                }
            }
            if !client.tags.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 6) {
                        ForEach(client.tags, id: \.self) { tag in
                            Text("#\(tag)")
                                .font(.system(size: 10, weight: .medium))
                                .foregroundColor(.gradientBlue)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(.gradientBlue.opacity(0.2))
                                )
                        }
                    }
                    .padding(.horizontal, 1)
                }
            }
        }
        .lightFramed()
    }
}

#Preview {
    ClientPreviewView(client: ClientModel(
        name: "Sarah Johnson",
        email: "sarah@example.com",
        phone: "+1 (555) 123-4567",
        company: "Fashion Magazine",
        position: "Editor",
        city: "New York",
        country: "USA",
        clientType: .magazine,
        status: .active,
        source: .referral,
        budget: 5000,
        preferredContact: .email,
        tags: ["fashion", "editorial", "high-budget"], totalProjects: 3,
        totalRevenue: 15000,
        rating: 5,
        isVIP: true
    ))
    .padding()
    .background(.backgroundMain)
    .preferredColorScheme(.dark)
}
