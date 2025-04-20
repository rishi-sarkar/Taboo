// Views/GameView.swift
import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        VStack {
            HStack {
                Text("Time: \(viewModel.timeRemaining)")
                    .font(.headline)
                Spacer()
                Text("Score: \(viewModel.score)")
                    .font(.headline)
            }
            .padding()

            if !viewModel.cards.isEmpty {
                CardView(card: viewModel.currentCard)
                    .padding()
            } else {
                Text("No cards available.")
                    .foregroundColor(.gray)
                    .padding()
            }

            HStack(spacing: 40) {
                Button(action: viewModel.nextCard) {
                    Text("Pass")
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                }

                Button(action: viewModel.correctGuess) {
                    Text("Correct")
                        .padding()
                        .background(Color.blue.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()

            Spacer()

            Button(action: viewModel.resetGame) {
                Text("Restart")
                    .font(.subheadline)
            }
            .padding(.bottom)
        }
        .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
    }
}
