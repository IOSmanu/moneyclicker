import SwiftUI

struct ParticleView: View {
    private let particlesCount = 30
    
    var body: some View {
        ForEach(0..<particlesCount, id: \.self) { index in
            ParticleShape()
        }
    }
}

struct ParticleShape: View {
    @State private var scale: CGFloat = 0
    
    var body: some View {
        Text("💵")
            .font(.headline)
            .foregroundColor(.yellow)
            .scaleEffect(scale)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: Double.random(in: 0.5...1)).repeatCount(1, autoreverses: true)) {
                    scale = 1
                }
            }
            .onDisappear {
                withAnimation {
                    scale = 0
                }
            }
    }
}

