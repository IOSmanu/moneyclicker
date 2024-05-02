import SwiftUI

struct GameView: View {
    @State private var money = UserDefaults.standard.integer(forKey: "Money")
    @State private var showParticles = false
    
    var body: some View {
        VStack {
            Text("💵 Money: \(money)")
                .font(.title)
                .padding()
            
            Circle()
                .fill(Color.blue)
                .frame(width: 100, height: 100)
                .overlay(Text("💵")
                            .font(.largeTitle)
                            .foregroundColor(.white))
                .onTapGesture {
                    money += 1
                    showParticles = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        showParticles = false
                    }
                    saveMoney()
                }
                .padding()
                .background(Color.white)
                .cornerRadius(50)
                .shadow(radius: 10)
                .overlay(
                    ZStack {
                        if showParticles {
                            ParticleView()
                        }
                    }
                )
        }
    }
    
    func saveMoney() {
        UserDefaults.standard.set(money, forKey: "Money")
    }
}



@main
struct VictareProApp: App {
    var body: some Scene {
        WindowGroup {
            GameView()
        }
    }
}

