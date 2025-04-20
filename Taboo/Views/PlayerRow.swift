import SwiftUI

struct PlayerRow: View {
    var name: String
    var icon: String = "person.fill"

    var body: some View {
        HStack {
            Image(systemName: icon)
            Text(name)
            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.2))
        .cornerRadius(12)
        .foregroundColor(.white)
        .padding(.horizontal)
    }
}
