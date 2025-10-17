import SwiftUI

struct PortfolioPreviewView: View {
    let portfolio: PortfolioModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack (alignment: .top) {
                ZStack {
                    if let imageData = portfolio.imageData, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 120, height: 120)
                            .clipped()
                            .cornerRadius(8)
                    } else {
                        Rectangle()
                            .fill(.darkGrayMain)
                            .frame(width: 120, height: 120)
                            .cornerRadius(8)
                            .overlay {
                                Image(systemName: "photo")
                                    .font(.system(size: 30))
                                    .foregroundColor(.titleGrayMain)
                            }
                    }
                }
                .overlay {
                    if portfolio.isFavorite {
                        VStack {
                            HStack {
                                Spacer()
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 16))
                                    .foregroundColor(.red)
                                    .padding(8)
                                    .background(
                                        Circle()
                                            .fill(.backgroundMain.opacity(0.8))
                                    )
                            }
                            Spacer()
                        }
                        .padding(8)
                    }
                }
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(portfolio.title)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .lineLimit(1)

                        Spacer()

                        Text(portfolio.category.rawValue)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.backgroundMain)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(portfolio.category.color)
                            )
                    }

                    if !portfolio.description.isEmpty {
                        Text(portfolio.description)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.textGrayMain)
                    }

                    if !portfolio.location.isEmpty {
                        Label(portfolio.location, systemImage: "location")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.titleGrayMain)
                    }

                }
            }
            HStack {
                HStack(spacing: 2) {
                    ForEach(1...5, id: \.self) { star in
                        Image(systemName: star <= portfolio.rating ? "star.fill" : "star")
                            .font(.system(size: 12))
                            .foregroundColor(.yellow)
                    }
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.backgroundMain.opacity(0.8))
                )
                Spacer()
                Text(portfolio.shootingDate, style: .date)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.titleGrayMain)
            }

            if !portfolio.tags.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 6) {
                        ForEach(portfolio.tags, id: \.self) { tag in
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
    PortfolioPreviewView(portfolio: PortfolioModel(
        title: "Sunset Portrait",
        description: "Beautiful golden hour portrait session for two people",
        category: .portrait,
        shootingDate: Date(),
        location: "Central Park",
        camera: "Canon EOS R5",
        lens: "85mm f/1.4",
        settings: "f/1.4, 1/125s, ISO 100",
        tags: ["portrait", "golden hour", "professional"],
        isFavorite: true,
        rating: 5
    ))
    .padding()
    .background(.backgroundMain)
    .preferredColorScheme(.dark)
}
