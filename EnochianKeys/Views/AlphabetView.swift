import SwiftUI

struct AlphabetView: View {
    @State private var selectedLetter: EnochianLetter?
    let columns = [GridItem(.adaptive(minimum: 80))]

    var body: some View {
        NavigationStack {
            ZStack {
                StarfieldBackground()

                ScrollView {
                    VStack(spacing: 20) {
                        VStack(spacing: 8) {
                            Text("The Angelic Alphabet")
                                .font(.system(size: 20, weight: .ultraLight))
                                .foregroundColor(Celestial.starWhite)

                            Text("21 Letters Revealed to John Dee")
                                .font(.system(size: 12, weight: .light))
                                .foregroundColor(Celestial.faintStar.opacity(0.5))

                            SacredDivider().frame(width: 200)
                        }
                        .padding(.top, 16)

                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(EnochianData.alphabet) { letter in
                                letterCell(letter)
                                    .onTapGesture {
                                        selectedLetter = letter
                                    }
                            }
                        }
                        .padding(.horizontal, 8)

                        Spacer(minLength: 30)
                    }
                    .padding()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Alphabet")
                        .font(.system(size: 17, weight: .light))
                        .foregroundColor(Celestial.glowCyan)
                }
            }
            .sheet(item: $selectedLetter) { letter in
                letterDetail(letter)
            }
        }
    }

    private func letterCell(_ letter: EnochianLetter) -> some View {
        VStack(spacing: 6) {
            Text(letter.glyph)
                .font(.system(size: 32))
                .foregroundColor(Celestial.runeGlow)

            Text(letter.name)
                .font(.system(size: 11, weight: .light))
                .foregroundColor(Celestial.silver)

            Text(letter.english)
                .font(.system(size: 10, weight: .light))
                .foregroundColor(Celestial.faintStar.opacity(0.5))
        }
        .frame(width: 80, height: 90)
        .glassCard()
    }

    private func letterDetail(_ letter: EnochianLetter) -> some View {
        ZStack {
            StarfieldBackground()

            VStack(spacing: 24) {
                Spacer()

                // Large glyph
                Text(letter.glyph)
                    .font(.system(size: 100))
                    .foregroundColor(Celestial.runeGlow)
                    .celestialGlow(Celestial.glowCyan)

                VStack(spacing: 8) {
                    Text(letter.name)
                        .font(.system(size: 28, weight: .ultraLight))
                        .foregroundColor(Celestial.starWhite)

                    SacredDivider().frame(width: 150)
                }

                VStack(spacing: 16) {
                    detailRow("English", letter.english)
                    detailRow("Value", "\(letter.value)")
                    detailRow("Meaning", letter.meaning)
                }
                .padding(.horizontal, 40)

                Spacer()

                Button("Close") {
                    selectedLetter = nil
                }
                .font(.system(size: 15, weight: .light))
                .foregroundColor(Celestial.glowCyan)
                .padding(.bottom, 40)
            }
        }
        .presentationBackground(Celestial.void)
    }

    private func detailRow(_ label: String, _ value: String) -> some View {
        HStack {
            Text(label)
                .font(.system(size: 13, weight: .light))
                .foregroundColor(Celestial.faintStar)
                .frame(width: 80, alignment: .trailing)

            Text(value)
                .font(.system(size: 16, weight: .light))
                .foregroundColor(Celestial.starWhite)

            Spacer()
        }
    }
}

#Preview { AlphabetView() }
