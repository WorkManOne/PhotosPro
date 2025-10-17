import SwiftUI

struct PhotoSessionPreviewView: View {
    let photoSession: PhotoSessionModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(photoSession.title)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .lineLimit(1)
                    
                    if !photoSession.description.isEmpty {
                        Text(photoSession.description)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.textGrayMain)
                            .lineLimit(2)
                    }
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(photoSession.priority.rawValue)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.backgroundMain)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(photoSession.priority.color)
                        )
                    
                    Text(photoSession.status.rawValue)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.backgroundMain)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(photoSession.status.color)
                        )
                }
            }
            VStack(alignment: .leading, spacing: 8) {
                if !photoSession.concept.isEmpty {
                    HStack {
                        Text("Concept:")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.titleGrayMain)
                        Text(photoSession.concept)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(.textGrayMain)
                    }
                }
                
                if !photoSession.mood.isEmpty {
                    HStack {
                        Text("Mood:")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.titleGrayMain)
                        Text(photoSession.mood)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(.textGrayMain)
                    }
                }
                
                if !photoSession.location.isEmpty {
                    HStack {
                        Label(photoSession.location, systemImage: "location")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.titleGrayMain)
                    }
                }
                
                HStack {
                    if photoSession.scheduledDate != nil {
                        Text(photoSession.scheduledDate?.formatted() ?? "")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.titleGrayMain)
                    }
                    
                    Spacer()
                    
                    if photoSession.budget > 0 {
                        Text("$\(photoSession.budget, specifier: "%.0f")")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.gradientBlue)
                    }
                }
                if !photoSession.equipment.isEmpty || !photoSession.team.isEmpty {
                    VStack(alignment: .leading, spacing: 4) {
                        if !photoSession.equipment.isEmpty {
                            HStack {
                                Text("Equipment:")
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(.titleGrayMain)
                                Text(photoSession.equipment.joined(separator: ", "))
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundColor(.textGrayMain)
                                    .lineLimit(1)
                            }
                        }
                        
                        if !photoSession.team.isEmpty {
                            HStack {
                                Text("Team:")
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(.titleGrayMain)
                                Text(photoSession.team.joined(separator: ", "))
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundColor(.textGrayMain)
                                    .lineLimit(1)
                            }
                        }
                    }
                }
            }
        }
        .lightFramed()
    }
}

#Preview {
    PhotoSessionPreviewView(photoSession: PhotoSessionModel(
        title: "Urban Fashion Shoot",
        description: "Modern street fashion photography session",
        concept: "Urban lifestyle meets high fashion",
        mood: "Edgy and contemporary",
        location: "Downtown District",
        equipment: ["Canon R5", "24-70mm lens", "Flash setup"],
        team: ["Model: Sarah", "Stylist: Mike"],
        budget: 2500,
        priority: .high,
        status: .planning,
        scheduledDate: Date().addingTimeInterval(86400 * 7)
    ))
    .padding()
    .background(.backgroundMain)
    .preferredColorScheme(.dark)
}
