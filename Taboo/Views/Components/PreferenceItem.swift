import SwiftUI

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

// Reusable Slider Sheets
struct SliderSheet: View {
    let title: String
    @Binding var value: Double
    let range: ClosedRange<Double>
    let step: Double
    let unit: String

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text(title)
                    .font(.headline)
                Slider(value: $value, in: range, step: step)
                Text("\(Int(value))\(unit)")
                Spacer()
            }
            .padding()
            .navigationTitle(title)
            .toolbar { ToolbarItem(placement: .confirmationAction) {
                Button("Done") { dismiss() }
            }}
        }
    }
}

struct SliderSheetInt: View {
    let title: String
    @Binding var value: Int
    let range: ClosedRange<Int>
    let step: Int

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text(title)
                    .font(.headline)
                Slider(
                    value: Binding(get: { Double(value) }, set: { value = Int($0) }),
                    in: Double(range.lowerBound)...Double(range.upperBound),
                    step: Double(step)
                )
                Text("\(value)")
                Spacer()
            }
            .padding()
            .navigationTitle(title)
            .toolbar { ToolbarItem(placement: .confirmationAction) {
                Button("Done") { dismiss() }
            }}
        }
    }
}
