import SwiftUI

struct CallsView: View {
    @State private var selectedCall: EnochianCall?

    var body: some View {
        NavigationStack {
            ZStack {
                StarfieldBackground()

                ScrollView {
                    VStack(spacing: 20) {
                        VStack(spacing: 8) {
                            Text("The Angelic Calls")
                                .font(.system(size: 20, weight: .ultraLight))
                                .foregroundColor(Celestial.starWhite)

                            Text("19 Keys of Invocation")
                                .font(.system(size: 12, weight: .light))
                                .foregroundColor(Celestial.faintStar.opacity(0.5))

                            SacredDivider().frame(width: 200)
                        }
                        .padding(.top, 16)

                        // Intro
                        Text("The Angelic Calls were dictated to Edward Kelley during scrying sessions, with Dee recording them in his journals. Each Call invokes different aspects of the angelic hierarchy and the created universe.")
                            .font(.system(size: 12, weight: .light))
                            .foregroundColor(Celestial.silver.opacity(0.5))
                            .multilineTextAlignment(.center)
                            .lineSpacing(4)
                            .padding(.horizontal, 20)

                        // Call cards
                        ForEach(EnochianData.calls) { call in
                            callCard(call)
                                .onTapGesture {
                                    selectedCall = call
                                }
                        }

                        // Note about remaining calls
                        if EnochianData.calls.count < 19 {
                            VStack(spacing: 8) {
                                SacredDivider().frame(width: 150)
                                Text("Calls 6–19 available in future updates")
                                    .font(.system(size: 11, weight: .light))
                                    .foregroundColor(Celestial.faintStar.opacity(0.3))
                            }
                        }

                        Spacer(minLength: 30)
                    }
                    .padding()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Calls")
                        .font(.system(size: 17, weight: .light))
                        .foregroundColor(Celestial.glowCyan)
                }
            }
            .sheet(item: $selectedCall) { call in
                CallDetailView(call: call)
            }
        }
    }

    private func callCard(_ call: EnochianCall) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                ZStack {
                    Circle()
                        .fill(Celestial.glowBlue.opacity(0.1))
                        .frame(width: 40, height: 40)

                    Text("\(call.number)")
                        .font(.system(size: 18, weight: .light))
                        .foregroundColor(Celestial.glowCyan)
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text(call.title)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Celestial.starWhite)

                    Text("\(call.lines.count) lines")
                        .font(.system(size: 11, weight: .light))
                        .foregroundColor(Celestial.faintStar.opacity(0.4))
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 12))
                    .foregroundColor(Celestial.glowBlue.opacity(0.3))
            }

            // Preview first line
            if let first = call.lines.first {
                VStack(alignment: .leading, spacing: 2) {
                    Text(first.enochian)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(Celestial.runeGlow.opacity(0.7))

                    Text(first.english)
                        .font(.system(size: 12, weight: .light))
                        .italic()
                        .foregroundColor(Celestial.silver.opacity(0.4))
                }
            }
        }
        .glassCard()
    }
}

// MARK: - Call Detail
struct CallDetailView: View {
    let call: EnochianCall
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            StarfieldBackground()

            ScrollView {
                VStack(spacing: 24) {
                    // Close
                    HStack {
                        Spacer()
                        Button(action: { dismiss() }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 24))
                                .foregroundColor(Celestial.faintStar.opacity(0.4))
                        }
                    }

                    // Title
                    VStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(Celestial.glowBlue.opacity(0.1))
                                .frame(width: 60, height: 60)

                            Text("\(call.number)")
                                .font(.system(size: 28, weight: .ultraLight))
                                .foregroundColor(Celestial.glowCyan)
                        }
                        .celestialGlow()

                        Text(call.title)
                            .font(.system(size: 24, weight: .ultraLight))
                            .foregroundColor(Celestial.starWhite)

                        SacredDivider().frame(width: 200)
                    }

                    // Lines
                    ForEach(Array(call.lines.enumerated()), id: \.offset) { index, line in
                        VStack(alignment: .leading, spacing: 8) {
                            // Line number
                            Text("\(index + 1)")
                                .font(.system(size: 10, weight: .light))
                                .foregroundColor(Celestial.faintStar.opacity(0.3))

                            // Enochian
                            Text(line.enochian)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Celestial.runeGlow)
                                .lineSpacing(4)

                            // English
                            Text(line.english)
                                .font(.system(size: 14, weight: .light))
                                .italic()
                                .foregroundColor(Celestial.silver.opacity(0.6))
                                .lineSpacing(4)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 8)

                        if index < call.lines.count - 1 {
                            Rectangle()
                                .fill(Celestial.glowBlue.opacity(0.08))
                                .frame(height: 1)
                        }
                    }

                    // Source
                    VStack(spacing: 4) {
                        SacredDivider().frame(width: 150)
                        Text("British Library MS Sloane 3191")
                            .font(.system(size: 10, weight: .light))
                            .foregroundColor(Celestial.faintStar.opacity(0.2))
                        Text("Dr. John Dee, 1584 · Public Domain")
                            .font(.system(size: 9, weight: .light))
                            .foregroundColor(Celestial.faintStar.opacity(0.15))
                    }
                    .padding(.bottom, 30)
                }
                .padding()
            }
        }
        .presentationBackground(Celestial.void)
    }
}

#Preview { CallsView() }
