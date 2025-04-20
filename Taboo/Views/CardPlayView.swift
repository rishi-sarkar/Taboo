// Views/CardPlayView.swift
import SwiftUI

struct CardPlayView: View {
    let card: Card
    let timeRemaining: Int
    let onPass: () -> Void
    let onCorrect: () -> Void
    let onTaboo: () -> Void
    let skipsRemaining: Int
    let taboosRemaining: Int
    let bgColor: Color

    var body: some View {
        ZStack {
            bgColor.ignoresSafeArea()
            VStack(spacing: 20) {
                HStack {
                    Text("TURN 1")
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 6)
                            .opacity(0.2)
                            .frame(width: 54, height: 54)
                        Circle()
                            .trim(from: 0, to: CGFloat(timeRemaining) / 60.0)
                            .stroke(style: StrokeStyle(lineWidth: 6, lineCap: .round))
                            .rotationEffect(.degrees(-90))
                            .frame(width: 54, height: 54)
                            .foregroundColor(.white)
                        Text("\(timeRemaining)")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal)
                
                // Card Display (expanded vertically)
                VStack(spacing: 10) {
                    Text(card.word.uppercased())
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(Color.purple)

                    VStack(spacing: 6) {
                        ForEach(card.tabooWords, id: \.self) { word in
                            Text(word)
                                .font(.system(size: 24, weight: .medium))
                                .foregroundColor(.black)
                                .padding(.vertical)
                        }
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .shadow(radius: 6)
                )
                .padding(.horizontal)
                .frame(maxWidth: 300, maxHeight: .infinity)
                .clipped()

                Spacer()
                
                HStack(spacing: 30) {
                    Button(action: onPass) {
                        ZStack(alignment: .topTrailing) {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 60, height: 60)
                            Image(systemName: "arrow.uturn.backward")
                                .font(.title)
                                .foregroundColor(bgColor)
                            if skipsRemaining > 0 {
                                Text("\(skipsRemaining)")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .padding(4)
                                    .background(Color.orange)
                                    .clipShape(Circle())
                                    .offset(x: 12, y: -12)
                            }
                        }
                    }

                    Button(action: onTaboo) {
                        ZStack(alignment: .topTrailing) {
                            Circle()
                                .fill(Color.red)
                                .frame(width: 60, height: 60)
                            Text("T")
                                .font(.system(size: 26, weight: .bold))
                                .foregroundColor(.white)
                            if taboosRemaining > 0 {
                                Text("\(taboosRemaining)")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .padding(4)
                                    .background(Color.black)
                                    .clipShape(Circle())
                                    .offset(x: 12, y: -12)
                            }
                        }
                    }

                    Button(action: onCorrect) {
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 60, height: 60)
                            Image(systemName: "checkmark")
                                .font(.title)
                                .foregroundColor(bgColor)
                        }
                    }
                }
                .padding(.bottom, 20)
            }
        }
    }
}
