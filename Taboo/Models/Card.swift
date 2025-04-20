// Models/Card.swift
import Foundation

struct Card: Identifiable {
    let id = UUID()
    let word: String
    let tabooWords: [String]