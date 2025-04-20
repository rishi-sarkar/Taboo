// Views/PlayerRow.swift
import SwiftUI

struct PlayerRow: View {
    @Binding var name: String
    var icon: String = "person.fill"
    var isEditable: Bool = true

    init(name: Binding<String>, icon: String = "person.fill", isEditable: Bool = true) {
        self._name = name
        self.icon = icon
        self.isEditable = isEditable
    }

    var body: some View {
        HStack {
            Image(systemName: icon)
            if isEditable {
                TextField("Player Name", text: $name)
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .medium))
            } else {
                Text(name)
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .medium))
            }
            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.2))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}
