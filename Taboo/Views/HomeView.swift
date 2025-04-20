// Views/HomeView.swift
import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [Color.purple, Color.black],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 20) {
                    Spacer().frame(height: 60)

                    Text("TABOO")
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(.white)

                    Spacer().frame(height: 50)

                    NavigationLink {
                        TeamsSettingsView()
                    } label: {
                        ModeCard(
                            title: "TEAMS MODE",
                            description: "Play with 2 teams",
                            playerCount: "(4+ PLAYERS)"
                        )
                    }

                    NavigationLink {
                        OneVsAllSettingsView()
                    } label: {
                        ModeCard(
                            title: "ONE VS ALL MODE",
                            description: "Every player for themselves, scoring points as the Clue Giver",
                            playerCount: "(2–5 PLAYERS)"
                        )
                    }

                    Spacer()
                }
            }
        }
    }
}

struct ModeCard: View {
    let title: String
    let description: String
    let playerCount: String

    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.2))
                .frame(height: 120)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                )

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(title)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                    Text(playerCount)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                }

                Text(description)
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.9))
            }
            .padding()
        }
        .padding(.horizontal)
    }
}
