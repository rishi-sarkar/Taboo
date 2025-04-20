// Shared PreferenceItem
struct PreferenceItem: View {
    let icon: String
    let label: String

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
            Text(label)
        }
        .font(.system(size: 14, weight: .medium))
        .foregroundColor(.white)
    }
}
