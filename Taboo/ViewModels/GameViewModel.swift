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
