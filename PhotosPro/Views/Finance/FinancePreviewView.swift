import SwiftUI

struct FinancePreviewView: View {
    let finance: FinanceModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(finance.title)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .lineLimit(1)
                    
                    if !finance.description.isEmpty {
                        Text(finance.description)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.textGrayMain)
                            .lineLimit(2)
                    }
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(finance.type.rawValue)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.backgroundMain)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(finance.type.color)
                        )
                    
                    Text(finance.status.rawValue)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.backgroundMain)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(finance.status.color)
                        )
                }
            }
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(finance.type == .income ? "+" : "-")$\(finance.amount, specifier: "%.2f")")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(finance.type == .income ? .successGreen : .warningRed)
                    
                    Text(finance.date, style: .date)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.titleGrayMain)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(finance.category.rawValue)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.titleGrayMain)
                    
                    Text(finance.currency)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.textGrayMain)
                }
            }
            VStack(alignment: .leading, spacing: 6) {
                if let clientName = finance.clientName {
                    HStack {
                        Image(systemName: "person")
                            .font(.system(size: 12))
                            .foregroundColor(.titleGrayMain)
                            .frame(width: 16)
                        Text("Client: \(clientName)")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(.textGrayMain)
                            .lineLimit(1)
                    }
                }
                
                if let projectName = finance.projectName {
                    HStack {
                        Image(systemName: "folder")
                            .font(.system(size: 12))
                            .foregroundColor(.titleGrayMain)
                            .frame(width: 16)
                        Text("Project: \(projectName)")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(.textGrayMain)
                            .lineLimit(1)
                    }
                }
                
                HStack {
                    Image(systemName: "creditcard")
                        .font(.system(size: 12))
                        .foregroundColor(.titleGrayMain)
                        .frame(width: 16)
                    Text("Payment: \(finance.paymentMethod.rawValue)")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.textGrayMain)
                        .lineLimit(1)
                }
            }
            if let invoiceNumber = finance.invoiceNumber {
                HStack {
                    Image(systemName: "doc.text")
                        .font(.system(size: 12))
                        .foregroundColor(.titleGrayMain)
                        .frame(width: 16)
                    Text("Invoice: \(invoiceNumber)")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.textGrayMain)
                        .lineLimit(1)
                }
            }
            
            if finance.taxAmount > 0 {
                HStack {
                    Image(systemName: "percent")
                        .font(.system(size: 12))
                        .foregroundColor(.titleGrayMain)
                        .frame(width: 16)
                    Text("Tax: $\(finance.taxAmount, specifier: "%.2f")")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.textGrayMain)
                        .lineLimit(1)
                }
            }
            
            if !finance.tags.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 6) {
                        ForEach(finance.tags, id: \.self) { tag in
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
    FinancePreviewView(finance: FinanceModel(
        title: "Wedding Photography Payment",
        description: "Payment for Sarah & John's wedding photography",
        type: .income,
        category: .shooting,
        amount: 2500,
        currency: "USD",
        date: Date(),
        clientName: "Sarah & John",
        projectName: "Wedding Photography",
        paymentMethod: .bank,
        status: .paid,
        invoiceNumber: "INV-2024-001",
        taxAmount: 250,
        tags: ["wedding", "photography", "paid"]
    ))
    .padding()
    .background(.backgroundMain)
    .preferredColorScheme(.dark)
}
