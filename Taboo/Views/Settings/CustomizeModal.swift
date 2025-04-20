// Views/CustomizeModal.swift
import SwiftUI

struct CustomizeModal: View {
    @Binding var turnTime: Int
    @Binding var rounds: Int
    @Binding var passes: Int
    @Binding var isPresented: Bool

    var body: some View {
        ZStack(alignment: .topTrailing) {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(radius: 8)
            VStack(spacing: 24) {
                HStack {
                    Spacer()
                    Text("Settings")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                    Spacer()
                    Button { isPresented = false } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 24)).foregroundColor(.purple)
                    }
                }
                .padding(.top, 16).padding(.horizontal, 24)

                VStack(spacing: 16) {
                    SettingRow(icon: "timer", title: "Turn time limit", value: "\(turnTime)s", decrement: { if turnTime>10 { turnTime-=10 } }, increment: { turnTime+=10 })
                    SettingRow(icon: "arrow.triangle.2.circlepath", title: "Number of rounds", value: "\(rounds)", decrement: { if rounds>1 { rounds-=1 } }, increment: { rounds+=1 })
                    SettingRow(icon: "arrow.uturn.backward", title: "Free passes", value: "\(passes)", decrement: { if passes>0 { passes-=1 } }, increment: { passes+=1 })
                }
                .frame(maxWidth: 300)
                Spacer()
                Button { isPresented=false } label: {
                    Text("READY")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 48)
                        .background(LinearGradient(colors: [Color.blue, Color.purple], startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(12)
                }
                .padding(.bottom, 16)
            }
            .padding(.bottom, 16)
        }
        .frame(maxWidth: .infinity, maxHeight: 360)
        .padding(.horizontal, 24)
        .transition(.move(edge: .bottom)).animation(.spring(), value: isPresented)
    }
}

struct SettingRow: View {
    let icon: String
    let title: String
    let value: String
    let decrement: () -> Void
    let increment: () -> Void

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .foregroundColor(.purple)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black)
                HStack {
                    Button { decrement() } label: {
                        Image(systemName: "minus.circle.fill")
                            .font(.title2)
                            .foregroundColor(.purple)
                    }
                    Text(value)
                        .font(.system(size: 16, weight: .medium))
                        .frame(minWidth: 40)
                        .foregroundColor(.black)
                    Button { increment() } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundColor(.purple)
                    }
                }
                .padding(.vertical, 8)
                .padding(.horizontal)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            }
            Spacer()
        }
        .padding(.horizontal, 32)
    }
}
