// Views/CardView.swift
import SwiftUI

struct CardView: View {
    let card: Card

    var body: some View {
        VStack(spacing: 20) {
            Text(card.word)
                .font(.largeTitle)
                .fontWeight(.bold)

            ForEach(card.tabooWords, id: \.self) { taboo in
                Text(taboo)
                    .font(.body)
                    .foregroundColor(.red)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(radius: 4)
        )
    }
}
