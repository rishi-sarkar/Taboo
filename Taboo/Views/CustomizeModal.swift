// Views/CustomizeModal.swift
import SwiftUI

struct CustomizeModal: View {
    @Binding var turnTime: Int
    @Binding var rounds: Int
    @Binding var passes: Int
    @Binding var isPresented: Bool

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.white
                .cornerRadius(16)
                .padding(.horizontal, 20)

            VStack(spacing: 16) {
                HStack {
                    Spacer()
                    Text("CUSTOMISE YOUR GAME!")
                        .font(.system(size: 20, weight: .bold))
                        .padding(.top, 24)
                    Spacer()
                    Button { isPresented = false } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.purple)
                    }
                }

                SettingRow(
                    icon: "timer",
                    title: "Turn time limit",
                    value: "\(turnTime)s",
                    decrement: { if turnTime > 10 { turnTime -= 10 } },
                    increment: { turnTime += 10 }
                )

                SettingRow(
                    icon: "arrow.triangle.2.circlepath",
                    title: "Number of rounds",
                    value: "\(rounds)",
                    decrement: { if rounds > 1 { rounds -= 1 } },
                    increment: { rounds += 1 }
                )

                SettingRow(
                    icon: "arrow.uturn.backward",
                    title: "Free passes",
                    value: "\(passes)",
                    decrement: { if passes > 0 { passes -= 1 } },
                    increment: { passes += 1 }
                )

                Button { isPresented = false } label: {
                    Text("READY")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                colors: [Color.blue, Color.purple],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
                .padding(.bottom, 24)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 450)
        .transition(.move(edge: .bottom))
        .animation(.spring(), value: isPresented)
    }
}