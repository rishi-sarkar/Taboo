// Views/TeamsSettingsView.swift
import SwiftUI

struct TeamsSettingsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var redTeam = "Red Team"
    @State private var blueTeam = "Blue Team"
    @State private var turnTime = 60
    @State private var rounds = 3
    @State private var passes = 5
    @State private var showCustomize = false

    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.purple, Color.black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                // Header with Back and Home
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Text("TEAMS MODE")
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

                Spacer().frame(height: 20)

                // Team Name Inputs
                VStack(spacing: 16) {
                    TeamNameInput(title: $redTeam, color: .red)
                    Text("VS")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                    TeamNameInput(title: $blueTeam, color: .blue)
                }
                .padding(.horizontal)

                // Preferences Row (timer, skips, rounds)
                Button(action: { showCustomize = true }) {
                    HStack(spacing: 16) {
                        PreferenceItem(icon: "timer", label: "\(turnTime)")
                        PreferenceItem(icon: "arrow.2.circlepath", label: "\(rounds)")
                        PreferenceItem(icon: "arrow.uturn.backward", label: "\(passes)")
                    }
                    .padding()
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(16)
                    .padding(.horizontal)
                }
                .padding(.horizontal)


                Spacer()

                // Start Button
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
            .blur(radius: showCustomize ? 5 : 0)

            if showCustomize {
                CustomizeModal(
                    turnTime: $turnTime,
                    rounds: $rounds,
                    passes: $passes,
                    isPresented: $showCustomize
                )
            }
        }
    }
}
