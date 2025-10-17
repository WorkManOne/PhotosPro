import SwiftUI

extension View {
    func darkFramed(isBordered: Bool = false) -> some View {
        self
            .padding(15)
            .frame(maxWidth: .infinity)
            .background(.surfaceGray)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.secondaryGray.opacity(0.3), lineWidth: isBordered ? 1 : 0)
            }
    }
    func lightFramed(isBordered: Bool = false) -> some View {
        self
            .padding(20)
            .frame(maxWidth: .infinity)
            .background(.surfaceGray)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.secondaryGray.opacity(0.3), lineWidth: isBordered ? 1 : 0)
            }
    }
    func colorFramed(color: Color, isBordered: Bool = false, borderColor: Color = .secondaryGray, lineWidth: CGFloat = 1) -> some View {
        self
            .padding(15)
            .frame(maxWidth: .infinity)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: isBordered ? lineWidth : 0)
            }
    }
}

#Preview {
    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        .lightFramed()

}

//
//struct GrayFrameBackground: ViewModifier {
//    func body(content: Content) -> some View {
//        content
//            .padding()
//            .frame(maxWidth: .infinity)
//            .background(.grayAccent)
//            .clipShape(RoundedRectangle(cornerRadius: 10))
//    }
//}

