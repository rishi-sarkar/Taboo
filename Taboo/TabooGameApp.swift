// TabooGameApp.swift
import SwiftUI

@main
struct TabooGameApp: App {
    var body: some Scene {
        WindowGroup {
            GameView(viewModel: GameViewModel())
        }
    }
}

// Models/Card.swift
import Foundation

struct Card: Identifiable {
    let id = UUID()
    let word: String
    let tabooWords: [String]
}

// ViewModels/GameViewModel.swift
import Combine
import Foundation

class GameViewModel: ObservableObject {
    @Published private(set) var cards: [Card] = []
    @Published var currentIndex = 0
    @Published var timeRemaining = 60
    @Published var score = 0
    private var timer: AnyCancellable?

    init() {
        loadCards()
        startTimer()
    }

    /// Loads cards from a bundled text file named "cards.txt".
    /// Each line in the file should be formatted as:
    /// Word,Taboo1,Taboo2,Taboo3,Taboo4,Taboo5
    private func loadCards() {
        guard let url = Bundle.main.url(forResource: "cards", withExtension: "txt") else {
            print("cards.txt not found in bundle")
            return
        }

        do {
            let content = try String(contentsOf: url)
            let lines = content.components(separatedBy: .newlines).filter { !$0.isEmpty }
            cards = lines.compactMap { line in
                let parts = line.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) }
                guard parts.count >= 2 else { return nil }
                let word = parts[0]
                let tabooWords = Array(parts.dropFirst())
                return Card(word: word, tabooWords: tabooWords)
            }
        } catch {
            print("Failed to read cards.txt: \(error)")
        }
    }

    func startTimer() {
        timer?.cancel()
        timeRemaining = 60
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else {
                    self.timer?.cancel()
                }
            }
    }

    func nextCard() {
        if currentIndex + 1 < cards.count {
            currentIndex += 1
        }
    }

    func correctGuess() {
        score += 1
        nextCard()
    }

    func resetGame() {
        currentIndex = 0
        score = 0
        startTimer()
    }

    var currentCard: Card {
        guard !cards.isEmpty else {
            return Card(word: "", tabooWords: [])
        }
        return cards[currentIndex]
    }
}

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

