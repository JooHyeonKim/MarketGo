import SwiftUI

struct CircleView: View {
    let storeName: String
    let isFilled: Bool
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(Color.black.opacity(0.2), lineWidth: 0.5)
                    .frame(width: 70, height: 70)
                
                if isFilled {
                    Image("stamp") // 스탬프 이미지 이름으로 변경
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 70, height: 70)
                }
            }
            Text(storeName)
                .font(.subheadline)
                .foregroundColor(.black)
                .frame(width: 70, height: 30)
                .lineLimit(nil) // 두 줄로 표기되도록 설정
                .multilineTextAlignment(.center) // 가운데 정렬
        }
    }
}
