import SwiftUI

struct ContentView: View {
    @State private var showPortal = true
    @State private var portalOpacity = 1.0
    @State private var portalScale = 1.0
    @State private var selectedTab = 0

    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem { Label("Keys", systemImage: "key.fill") }
                    .tag(0)

                AlphabetView()
                    .tabItem { Label("Alphabet", systemImage: "character.book.closed.fill") }
                    .tag(1)

                DictionaryView()
                    .tabItem { Label("Lexicon", systemImage: "text.book.closed.fill") }
                    .tag(2)

                TranslatorView()
                    .tabItem { Label("Translate", systemImage: "arrow.left.arrow.right") }
                    .tag(3)

                CallsView()
                    .tabItem { Label("Calls", systemImage: "waveform.circle.fill") }
                    .tag(4)
            }
            .tint(Celestial.glowCyan)

            if showPortal {
                PortalView {
                    withAnimation(.easeInOut(duration: 1.5)) {
                        portalOpacity = 0
                        portalScale = 1.15
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        showPortal = false
                    }
                }
                .opacity(portalOpacity)
                .scaleEffect(portalScale)
            }
        }
    }
}

// MARK: - Portal (Launch Screen)
struct PortalView: View {
    let onOpen: () -> Void
    @State private var ringRotation = 0.0
    @State private var glowPulse = false
    @State private var titleReveal = false

    var body: some View {
        ZStack {
            StarfieldBackground()

            // Rotating rings
            ZStack {
                ForEach(0..<3) { i in
                    Circle()
                        .stroke(
                            Celestial.glowBlue.opacity(0.2 + Double(i) * 0.1),
                            lineWidth: 1
                        )
                        .frame(width: CGFloat(180 + i * 60), height: CGFloat(180 + i * 60))
                        .rotationEffect(.degrees(ringRotation + Double(i * 40)))
                }

                // Central glow
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [Celestial.glowCyan.opacity(glowPulse ? 0.3 : 0.1), .clear],
                            center: .center,
                            startRadius: 20,
                            endRadius: 100
                        )
                    )
                    .frame(width: 200, height: 200)

                // Heptagram
                HeptagramShape()
                    .stroke(Celestial.glowBlue.opacity(0.6), lineWidth: 1.5)
                    .frame(width: 120, height: 120)
                    .rotationEffect(.degrees(-ringRotation * 0.3))

                Text("∴")
                    .font(.system(size: 40))
                    .foregroundColor(Celestial.starWhite)
            }
            .padding(.bottom, 100)

            VStack {
                Spacer()

                VStack(spacing: 16) {
                    Text("E N O C H I A N")
                        .font(.system(size: 13, weight: .light))
                        .tracking(10)
                        .foregroundColor(Celestial.glowCyan.opacity(0.6))

                    Text("KEYS")
                        .font(.system(size: 52, weight: .ultraLight, design: .default))
                        .tracking(16)
                        .foregroundColor(Celestial.starWhite)

                    SacredDivider()
                        .frame(width: 200)

                    Text("The Language of Angels")
                        .font(.system(size: 15, weight: .light, design: .serif))
                        .italic()
                        .foregroundColor(Celestial.silver.opacity(0.6))

                    Text("From the Journals of Dr. John Dee, 1581–1589")
                        .font(.system(size: 10, weight: .light))
                        .foregroundColor(Celestial.faintStar.opacity(0.4))
                }
                .opacity(titleReveal ? 1 : 0)

                Spacer()

                Text("Tap to Enter")
                    .font(.system(size: 13, weight: .light))
                    .foregroundColor(Celestial.glowBlue.opacity(glowPulse ? 0.6 : 0.2))
                    .padding(.bottom, 50)
            }
        }
        .onTapGesture { onOpen() }
        .onAppear {
            withAnimation(.linear(duration: 30).repeatForever(autoreverses: false)) {
                ringRotation = 360
            }
            withAnimation(.easeInOut(duration: 2.5).repeatForever(autoreverses: true)) {
                glowPulse = true
            }
            withAnimation(.easeIn(duration: 1.5)) {
                titleReveal = true
            }
        }
    }
}

// MARK: - Heptagram
struct HeptagramShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let points = (0..<7).map { i -> CGPoint in
            let angle = (CGFloat(i) * 4 * .pi / 7) - .pi / 2
            return CGPoint(
                x: center.x + radius * cos(angle),
                y: center.y + radius * sin(angle)
            )
        }
        path.move(to: points[0])
        for i in 1..<7 { path.addLine(to: points[i]) }
        path.closeSubpath()
        return path
    }
}

#Preview { ContentView() }
