struct ParticleView: View {
    private let particlesCount = 30
    
    var body: some View {
        ForEach(0..<particlesCount, id: \.self) { index in
            Text("💵")
                .font(.headline)
                .foregroundColor(.yellow)
                .offset(x: CGFloat.random(in: -50...50), y: CGFloat.random(in: -50...50))
                .animation(Animation.linear(duration: Double.random(in: 0.5...1)).repeatCount(1))
        }
    }
}
