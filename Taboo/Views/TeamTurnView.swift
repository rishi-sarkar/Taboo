import SwiftUI

struct TeamTurnView: View {
    let title: String
    let name: String
    let bgColor: Color
    let onReady: () -> Void

    var body: some View {
        ZStack {
            bgColor.ignoresSafeArea()
            VStack(spacing: 40) {
                HStack {
                    Button(action: onReady) {
                        Image(systemName: "house.fill")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                Text(title)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                Image(systemName: "person.3.fill")
                    .resizable().scaledToFit()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.white.opacity(0.8))
                Text(name)
                    .font(.system(size: 20, weight: .bold))
                    .padding(.horizontal, 32).padding(.vertical, 12)
                    .background(Color.white.opacity(0.3)).cornerRadius(12)
                    .foregroundColor(.white)
                Spacer()
                Button(action: onReady) {
                    Text("READY!")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity).padding()
                        .background(Color.white.opacity(0.3))
                        .cornerRadius(16).padding(.horizontal)
                }
                Spacer().frame(height: 40)
            }
        }
    }
}
