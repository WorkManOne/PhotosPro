import SwiftUI

struct CustomTextField: View {
    let title: String
    @Binding var text: String
    var isMultiline: Bool = false
    var placeholder: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.secondaryGray)
            
            if isMultiline {
                TextField(placeholder.isEmpty ? "Enter \(title.lowercased())" : placeholder, text: $text, axis: .vertical)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.white)
                    .lineLimit(3...8)
                    .padding(12)
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color("surfaceGray"))
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.secondaryGray.opacity(0.3), lineWidth: 1)
                        }
                    )
            } else {
                TextField(placeholder.isEmpty ? "Enter \(title.lowercased())" : placeholder, text: $text)
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
            }
        }
    }
}

struct CustomSecureField: View {
    let title: String
    @Binding var text: String
    var placeholder: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.secondaryGray)
            
            SecureField(placeholder.isEmpty ? "Enter \(title.lowercased())" : placeholder, text: $text)
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
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        CustomTextField(title: "Title", text: .constant("Sample text"))
        CustomTextField(title: "Description", text: .constant(""), isMultiline: true)
        CustomSecureField(title: "Password", text: .constant(""))
    }
    .padding()
    .background(.backgroundMain)
    .preferredColorScheme(.dark)
}
