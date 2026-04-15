import SwiftUI

struct TranslatorView: View {
    @State private var inputText = ""
    @State private var isEnochianToEnglish = true
    @State private var results: [(String, String)] = []

    var body: some View {
        NavigationStack {
            ZStack {
                StarfieldBackground()

                ScrollView {
                    VStack(spacing: 24) {
                        // Header
                        VStack(spacing: 8) {
                            Text("Translator")
                                .font(.system(size: 20, weight: .ultraLight))
                                .foregroundColor(Celestial.starWhite)

                            SacredDivider().frame(width: 200)
                        }
                        .padding(.top, 16)

                        // Direction toggle
                        HStack(spacing: 16) {
                            Text(isEnochianToEnglish ? "Enochian" : "English")
                                .font(.system(size: 14, weight: .light))
                                .foregroundColor(Celestial.runeGlow)

                            Button {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    isEnochianToEnglish.toggle()
                                    inputText = ""
                                    results = []
                                }
                            } label: {
                                Image(systemName: "arrow.left.arrow.right")
                                    .font(.system(size: 18))
                                    .foregroundColor(Celestial.glowCyan)
                                    .padding(10)
                                    .background(
                                        Circle()
                                            .fill(Celestial.deepIndigo.opacity(0.6))
                                            .overlay(
                                                Circle()
                                                    .stroke(Celestial.glowCyan.opacity(0.3), lineWidth: 1)
                                            )
                                    )
                            }

                            Text(isEnochianToEnglish ? "English" : "Enochian")
                                .font(.system(size: 14, weight: .light))
                                .foregroundColor(Celestial.starWhite.opacity(0.6))
                        }

                        // Input field
                        VStack(alignment: .leading, spacing: 8) {
                            Text(isEnochianToEnglish ? "Enter Enochian text" : "Enter English text")
                                .font(.system(size: 11, weight: .light))
                                .foregroundColor(Celestial.faintStar.opacity(0.5))

                            TextField(
                                isEnochianToEnglish ? "e.g. ZACAR OD ZAMRAN" : "e.g. move and show yourselves",
                                text: $inputText
                            )
                            .foregroundColor(isEnochianToEnglish ? Celestial.runeGlow : Celestial.starWhite)
                            .font(.system(size: 18, weight: .light))
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .padding(14)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Celestial.deepIndigo.opacity(0.5))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Celestial.glowBlue.opacity(0.2), lineWidth: 1)
                                    )
                            )
                            .onChange(of: inputText) { _, _ in
                                translate()
                            }
                        }

                        // Results
                        if !results.isEmpty {
                            VStack(alignment: .leading, spacing: 12) {
                                HStack {
                                    Text("Translation")
                                        .font(.system(size: 12, weight: .medium))
                                        .tracking(2)
                                        .foregroundColor(Celestial.glowCyan.opacity(0.6))
                                        .textCase(.uppercase)
                                    Spacer()
                                }

                                ForEach(results, id: \.0) { pair in
                                    resultRow(source: pair.0, translated: pair.1)
                                }
                            }
                            .glassCard()
                        }

                        // Quick phrases
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Common Phrases")
                                .font(.system(size: 12, weight: .medium))
                                .tracking(2)
                                .foregroundColor(Celestial.glowCyan.opacity(0.6))
                                .textCase(.uppercase)

                            phraseButton("ZACAR OD ZAMRAN", "Move and show yourselves")
                            phraseButton("MICMA GOHO IAD", "Behold says your God")
                            phraseButton("NOCO MAD HOATH IAIDA", "Servant of your God, true worshiper of the Highest")
                            phraseButton("ODO CICLE QAA", "Open the mysteries of your creation")
                            phraseButton("OL SONF VORSG", "I reign over you")
                            phraseButton("TORZU GOHEL", "Arise, saith")
                        }
                        .glassCard()

                        Spacer(minLength: 30)
                    }
                    .padding()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Translate")
                        .font(.system(size: 17, weight: .light))
                        .foregroundColor(Celestial.glowCyan)
                }
            }
        }
    }

    private func resultRow(source: String, translated: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(source)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(isEnochianToEnglish ? Celestial.runeGlow : Celestial.starWhite)

            Text(translated)
                .font(.system(size: 14, weight: .light))
                .foregroundColor(isEnochianToEnglish ? Celestial.starWhite.opacity(0.8) : Celestial.runeGlow)
        }
        .padding(.vertical, 4)
    }

    private func phraseButton(_ enochian: String, _ english: String) -> some View {
        Button {
            if isEnochianToEnglish {
                inputText = enochian
            } else {
                inputText = english
            }
            translate()
        } label: {
            VStack(alignment: .leading, spacing: 2) {
                Text(enochian)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Celestial.runeGlow)
                Text(english)
                    .font(.system(size: 12, weight: .light))
                    .foregroundColor(Celestial.silver.opacity(0.5))
            }
        }
    }

    private func translate() {
        guard !inputText.isEmpty else {
            results = []
            return
        }

        let words = inputText
            .uppercased()
            .components(separatedBy: .whitespaces)
            .filter { !$0.isEmpty }

        if isEnochianToEnglish {
            results = words.compactMap { word in
                if let match = EnochianData.dictionary.first(where: { $0.enochian == word }) {
                    return (match.enochian, match.english)
                }
                return (word, "(?)")
            }
        } else {
            let query = inputText.lowercased()
            let matches = EnochianData.dictionary.filter {
                $0.english.lowercased().contains(query)
            }
            results = matches.map { ($0.english, $0.enochian) }
            if results.isEmpty {
                // Try word-by-word
                results = words.compactMap { word in
                    let w = word.lowercased()
                    if let match = EnochianData.dictionary.first(where: {
                        $0.english.lowercased() == w
                    }) {
                        return (match.english, match.enochian)
                    }
                    return nil
                }
            }
        }
    }
}

#Preview { TranslatorView() }
