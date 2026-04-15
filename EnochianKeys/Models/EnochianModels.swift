import Foundation

// MARK: - Enochian Letter
struct EnochianLetter: Identifiable, Hashable {
    let id = UUID()
    let glyph: String      // Unicode/display character
    let name: String        // Letter name
    let english: String     // English equivalent
    let value: Int          // Numerical value
    let meaning: String     // Symbolic meaning
}

// MARK: - Enochian Word
struct EnochianWord: Identifiable, Hashable {
    let id = UUID()
    let enochian: String
    let english: String
    let notes: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(enochian)
    }

    static func == (lhs: EnochianWord, rhs: EnochianWord) -> Bool {
        lhs.enochian == rhs.enochian
    }
}

// MARK: - Enochian Call
struct EnochianCall: Identifiable {
    let id = UUID()
    let number: Int
    let title: String
    let lines: [CallLine]
}

struct CallLine: Identifiable {
    let id = UUID()
    let enochian: String
    let english: String
}
