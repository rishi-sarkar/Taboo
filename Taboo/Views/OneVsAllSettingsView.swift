// Views/OneVsAllSettingsView.swift
import SwiftUI

struct OneVsAllSettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var players: [String] = ["FancyFrog560"]

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.purple, Color.black],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Text("LOCAL PARTY MODE")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                    Button(action: { /* go home */ }) {
                        Image(systemName: "house.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal)

                Text("ONE VS ALL MODE")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)

                Button(action: { /* how to play */ }) {
                    HStack {
                        Image(systemName: "questionmark.circle.fill")
                        Text("How to Play")
                    }
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(12)
                }

                Spacer().frame(height: 16)

                VStack(spacing: 12) {
                    ForEach(players, id: \ .self) { player in
                        HStack {
                            Image(systemName: "person.fill")
                            Text(player)
                            Spacer()
                        }
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(12)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    }

                    Button(action: { players.append("Player\(players.count+1)") }) {
                        HStack {
                            Image(systemName: "person.badge.plus")
                            Text("Add Player")
                        }
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(12)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    }
                }

                PreferencesRow()
                DeckSelectionView()

                Spacer()

                Button(action: { /* start game */ }) {
                    Text("START")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(16)
                        .padding(.horizontal)
                }

                Spacer().frame(height: 40)
            }
        }
    }
}
