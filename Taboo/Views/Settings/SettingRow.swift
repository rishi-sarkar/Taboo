//
//  SettingRow.swift
//  Taboo
//
//  Created by Rishi Sarkar on 2025-04-20.
//


// Views/SettingRow.swift
import SwiftUI

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
