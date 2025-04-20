// Views/TeamsSettingsView.swift
import SwiftUI

struct TeamsSettingsView: View {
    @Environment(\.dismiss) private var dismiss

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

                Text("Create Game")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white.opacity(0.8))

                Spacer().frame(height: 20)

                Text("TEAMS MODE")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)

                Button(action: { /* show how to play */ }) {
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

                Spacer().frame(height: 20)

                TeamSelectionView()

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

struct TeamSelectionView: View {
    var body: some View {
        VStack(spacing: 16) {
            TeamButton(title: "Red Team", color: .red)
            Text("VS")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white)
            TeamButton(title: "Blue Team", color: .blue)
        }
        .padding(.horizontal)
    }
}

struct TeamButton: View {
    let title: String
    let color: Color

    var body: some View {
        Button(action: { /* edit team name */ }) {
            HStack {
                Image(systemName: "pencil.circle.fill")
                Spacer()
                Text(title)
                Spacer()
            }
            .font(.system(size: 16, weight: .medium))
            .foregroundColor(.white)
            .padding()
            .background(color.opacity(0.8))
            .cornerRadius(12)
        }
    }
}

struct PreferencesRow: View {
    var body: some View {
        HStack(spacing: 16) {
            PreferenceItem(icon: "globe", label: "English-UK")
            PreferenceItem(icon: "timer", label: "1m")
            PreferenceItem(icon: "arrow.2.circlepath", label: "2")
            PreferenceItem(icon: "arrow.right.circle", label: "2")
        }
        .padding()
        .background(Color.white.opacity(0.2))
        .cornerRadius(16)
        .padding(.horizontal)
    }
}

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

struct DeckSelectionView: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Image(systemName: "pencil.circle.fill")
                Text("MY DECK (1/8)")
                Spacer()
            }
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(.white)
            Text("Base")
                .font(.system(size: 16))
                .foregroundColor(.white)
        }
        .padding()
        .background(Color.white.opacity(0.2))
        .cornerRadius(16)
        .padding(.horizontal)
    }
}
