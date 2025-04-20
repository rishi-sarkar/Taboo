struct TeamNameInput: View {
    @Binding var title: String
    let color: Color

    var body: some View {
        HStack {
            Image(systemName: "pencil.circle.fill")
            TextField("Team Name", text: $title)
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .medium))
                .multilineTextAlignment(.center)
        }
        .padding()
        .background(color.opacity(0.8))
        .cornerRadius(12)
    }
}