import SwiftUI

struct DictionaryView: View {
    @State private var searchText = ""

    var filteredWords: [EnochianWord] {
        if searchText.isEmpty {
            return EnochianData.dictionary.sorted { $0.enochian < $1.enochian }
        }
        let query = searchText.lowercased()
        return EnochianData.dictionary.filter {
            $0.enochian.lowercased().contains(query) ||
            $0.english.lowercased().contains(query)
        }.sorted { $0.enochian < $1.enochian }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                StarfieldBackground()

                VStack(spacing: 0) {
                    // Search bar
                    HStack(spacing: 10) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Celestial.glowCyan.opacity(0.5))
                        TextField("Search Enochian or English...", text: $searchText)
                            .foregroundColor(Celestial.starWhite)
                            .autocorrectionDisabled()
                    }
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Celestial.deepIndigo.opacity(0.6))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Celestial.glowBlue.opacity(0.2), lineWidth: 1)
                            )
                    )
                    .padding()

                    // Count
                    HStack {
                        Text("\(filteredWords.count) entries")
                            .font(.system(size: 11, weight: .light))
                            .foregroundColor(Celestial.faintStar.opacity(0.4))
                        Spacer()
                    }
                    .padding(.horizontal)

                    // Word list
                    ScrollView {
                        LazyVStack(spacing: 8) {
                            ForEach(filteredWords) { word in
                                wordRow(word)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 30)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Lexicon")
                        .font(.system(size: 17, weight: .light))
                        .foregroundColor(Celestial.glowCyan)
                }
            }
        }
    }

    private func wordRow(_ word: EnochianWord) -> some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(word.enochian)
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(Celestial.runeGlow)

                Text(word.english)
                    .font(.system(size: 14, weight: .light))
                    .foregroundColor(Celestial.starWhite.opacity(0.8))
            }

            Spacer()

            if !word.notes.isEmpty {
                Text(word.notes)
                    .font(.system(size: 10, weight: .light))
                    .foregroundColor(Celestial.faintStar.opacity(0.4))
                    .multilineTextAlignment(.trailing)
                    .frame(maxWidth: 120)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Celestial.deepIndigo.opacity(0.3))
        )
    }
}

#Preview { DictionaryView() }
