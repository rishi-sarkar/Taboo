// Views/IndividualGameplayView.swift
import SwiftUI

class IndividualGameViewModel: ObservableObject {
    let players: [String]
    let turnTime: Int
    let rounds: Int
    let maxPasses: Int

    @Published var currentPlayerIndex = 0
    @Published var currentRound = 1
    @Published var showingTurnStart = true
    @Published var timeRemaining: Int
    @Published var miniDeck: [Card] = []
    @Published var currentCardIndex = 0
    @Published var playerScores: [Int]
    @Published var remainingSkips: Int
    @Published var remainingTaboos: Int

    private var allCards: [Card] = []
    private var timer: Timer?

    init(players: [String], turnTime: Int, rounds: Int, passes: Int) {
        self.players = players
        self.turnTime = turnTime
        self.rounds = rounds
        self.maxPasses = passes
        self.remainingSkips = passes
        self.remainingTaboos = 3
        self.timeRemaining = turnTime
        self.playerScores = Array(repeating: 0, count: players.count)
        loadDeck()
    }

    private func loadDeck() {
        guard let url = Bundle.main.url(forResource: "cards", withExtension: "txt") else {
            print("cards.txt not found in bundle")
            return
        }
        do {
            let content = try String(contentsOf: url)
            let lines = content.split(whereSeparator: { $0.isNewline })
            allCards = lines.compactMap { line in
                let parts = line.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespaces) }
                guard parts.count >= 2 else { return nil }
                return Card(word: parts[0], tabooWords: Array(parts.dropFirst()))
            }
        } catch {
            print("Failed to load deck: \(error)")
        }
    }

    func startTurn() {
        timeRemaining = turnTime
        showingTurnStart = false
        remainingSkips = maxPasses
        remainingTaboos = 3
        miniDeck = Array(allCards.shuffled().prefix(30))
        currentCardIndex = 0

        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.endTurn()
            }
        }
    }

    func endTurn() {
        timer?.invalidate()
        showingTurnStart = true
        if currentPlayerIndex + 1 < players.count {
            currentPlayerIndex += 1
        } else if currentRound < rounds {
            currentRound += 1
            currentPlayerIndex = 0
        }
    }

    func nextCard() {
        if currentCardIndex + 1 < miniDeck.count {
            currentCardIndex += 1
        } else {
            currentCardIndex = 0
        }
    }

    func markCorrect() {
        playerScores[currentPlayerIndex] += 1
        nextCard()
    }

    func markPass() {
        if remainingSkips > 0 {
            remainingSkips -= 1
            nextCard()
        }
    }

    func markTaboo() {
        if remainingTaboos > 0 {
            remainingTaboos -= 1
            nextCard()
        }
    }

    var currentPlayer: String { players[currentPlayerIndex] }
    var currentCard: Card {
        if miniDeck.isEmpty {
            return Card(word: "No Cards", tabooWords: [])
        }
        return miniDeck[currentCardIndex]
    }
}

struct IndividualGameplayView: View {
    @StateObject var vm: IndividualGameViewModel

    init(players: [String], turnTime: Int, rounds: Int, passes: Int) {
        let viewModel = IndividualGameViewModel(players: players, turnTime: turnTime, rounds: rounds, passes: passes)
        _vm = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        Group {
            if vm.showingTurnStart {
                TeamTurnView(
                    title: "Get Ready!",
                    name: vm.currentPlayer,
                    bgColor: .purple
                ) {
                    vm.startTurn()
                }
            } else {
                CardPlayView(
                    card: vm.currentCard,
                    timeRemaining: vm.timeRemaining,
                    onPass: vm.markPass,
                    onCorrect: vm.markCorrect,
                    onTaboo: vm.markTaboo,
                    skipsRemaining: vm.remainingSkips,
                    taboosRemaining: vm.remainingTaboos,
                    bgColor: .red
                )
            }
        }
    }
}
