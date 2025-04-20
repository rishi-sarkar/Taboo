// Views/OneVsAllSettingsView.swift
import SwiftUI

struct OneVsAllSettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var players: [String] = ["Player1"]
    @State private var turnTime = 60
    @State private var rounds = 3
    @State private var passes = 5
    @State private var showCustomize = false

    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.purple, Color.black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                // Header
                HStack {
                    Button { dismiss() } label: {
                        Image(systemName: "chevron.left.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Text("ONE VS ALL MODE")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                    Button { /* home */ } label: {
                        Image(systemName: "house.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal)
                Spacer().frame(height: 10)

                // Editable Players List
                VStack(spacing: 12) {
                    ForEach(players.indices, id: \.self) { index in
                        PlayerRow(name: $players[index])
                    }
                    Button {
                        players.append("Player\(players.count + 1)")
                    } label: {
                        PlayerRow(name: .constant("Add Player"), icon: "person.badge.plus", isEditable: false)
                    }
                }

                // Preferences Button
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

                Spacer()
                // Start Button
                Button { /* start game */ } label: {
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
                CustomizeModal(turnTime: $turnTime, rounds: $rounds, passes: $passes, isPresented: $showCustomize)
            }
        }
    }
}
