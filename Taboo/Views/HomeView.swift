// Views/HomeView.swift
import SwiftUI

struct HomeView: View {
    @State private var selectedMode: String? = nil

    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Text("Taboo Game")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                NavigationLink(destination: GameView(viewModel: GameViewModel()), tag: "Solo", selection: $selectedMode) {
                    EmptyView()
                }

                NavigationLink(destination: GameView(viewModel: GameViewModel()), tag: "Team", selection: $selectedMode) {
                    EmptyView()
                }

                Button("Solo Mode") {
                    selectedMode = "Solo"
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(12)
                .padding(.horizontal)

                Button("Team Mode") {
                    selectedMode = "Team"
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(12)
                .padding(.horizontal)

                Spacer()
            }
            .padding()
        }
    }
}