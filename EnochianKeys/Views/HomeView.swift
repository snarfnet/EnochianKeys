import SwiftUI

struct HomeView: View {
    @State private var glowing = false

    var body: some View {
        NavigationStack {
            ZStack {
                StarfieldBackground()

                ScrollView {
                    VStack(spacing: 24) {
                        // Header
                        VStack(spacing: 12) {
                            HeptagramShape()
                                .stroke(Celestial.glowBlue.opacity(0.4), lineWidth: 1)
                                .frame(width: 60, height: 60)
                                .celestialGlow()

                            Text("The Enochian System")
                                .font(.system(size: 22, weight: .ultraLight))
                                .foregroundColor(Celestial.starWhite)

                            Text("Received by Dr. John Dee & Edward Kelley\n1581–1589, London & Prague")
                                .font(.system(size: 11, weight: .light))
                                .foregroundColor(Celestial.faintStar.opacity(0.5))
                                .multilineTextAlignment(.center)
                        }
                        .padding(.top, 20)

                        // Info cards
                        infoCard(
                            icon: "character.book.closed.fill",
                            title: "21 Letters",
                            subtitle: "The Angelic Alphabet",
                            description: "A unique writing system revealed through scrying sessions. Each letter carries a name, numerical value, and symbolic meaning."
                        )

                        infoCard(
                            icon: "text.book.closed.fill",
                            title: "130+ Words",
                            subtitle: "Enochian Lexicon",
                            description: "Vocabulary extracted from the 19 Calls, with English translations and contextual notes."
                        )

                        infoCard(
                            icon: "arrow.left.arrow.right",
                            title: "Translator",
                            subtitle: "English ↔ Enochian",
                            description: "Look up words in both directions. Enter English to find Enochian equivalents, or decode Enochian text."
                        )

                        infoCard(
                            icon: "waveform.circle.fill",
                            title: "19 Calls",
                            subtitle: "The Angelic Invocations",
                            description: "The Keys of Enoch — ritual invocations in the angelic tongue with line-by-line English translation."
                        )

                        // Historical note
                        VStack(spacing: 8) {
                            SacredDivider()
                                .frame(width: 200)

                            Text("The Enochian language was recorded by Dr. John Dee, mathematician and advisor to Queen Elizabeth I, and his scryer Edward Kelley between 1581 and 1589. Dee believed they were communicating with angels who revealed a complete language system including alphabet, grammar, and ritual texts known as the 'Angelic Keys' or 'Calls'.")
                                .font(.system(size: 11, weight: .light))
                                .foregroundColor(Celestial.faintStar.opacity(0.35))
                                .multilineTextAlignment(.center)
                                .lineSpacing(4)
                                .padding(.horizontal, 20)

                            Text("Sources: British Library MS Sloane 3191, 3188\nPublic Domain — 16th Century Manuscripts")
                                .font(.system(size: 9, weight: .light))
                                .foregroundColor(Celestial.faintStar.opacity(0.2))
                                .multilineTextAlignment(.center)
                                .lineSpacing(3)
                        }
                        .padding(.bottom, 30)
                    }
                    .padding()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Enochian Keys")
                        .font(.system(size: 17, weight: .light))
                        .foregroundColor(Celestial.glowCyan)
                }
            }
        }
    }

    private func infoCard(icon: String, title: String, subtitle: String, description: String) -> some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 28))
                .foregroundColor(Celestial.glowCyan)
                .frame(width: 50)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Celestial.starWhite)

                Text(subtitle)
                    .font(.system(size: 12, weight: .light))
                    .foregroundColor(Celestial.glowBlue.opacity(0.7))

                Text(description)
                    .font(.system(size: 12, weight: .light))
                    .foregroundColor(Celestial.silver.opacity(0.5))
                    .lineSpacing(3)
            }

            Spacer()
        }
        .glassCard()
    }
}

#Preview { HomeView() }
