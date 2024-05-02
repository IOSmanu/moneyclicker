import SwiftUI

struct GameView: View {
    @State private var money = UserDefaults.standard.integer(forKey: "Money")
    @State private var moneyBoosters = UserDefaults.standard.integer(forKey: "MoneyBoosters")
    @State private var showParticles = false
    @State private var showShop = false
    @State private var activeBooster: Int?
    @State private var isPressed = false // Zustand für den Push-Effekt
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.gray, Color.white, Color.green]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea() // Farbverlauf für den Hintergrund
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        showShop.toggle()
                    }) {
                        Text("Shop")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(LinearGradient(gradient: Gradient(colors: [Color(red: 0.1, green: 0.5, blue: 0.9), Color(red: 0.3, green: 0.7, blue: 1.0)]), startPoint: .topLeading, endPoint: .bottomTrailing)) // Farbverlauf
                            .cornerRadius(10)
                            .shadow(color: .gray, radius: 5, x: 0, y: 2) // Schatten
                    }
                    .padding()
                }
                .padding(.top, 20)
                
                Text("💵 Money: \(money)")
                    .font(.title)
                    .padding()
                
                Button(action: {
                    isPressed = true // Setze den Zustand für den Push-Effekt auf true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        if let booster = activeBooster {
                            money += (booster * moneyBoosters)
                        } else {
                            money += 1
                        }
                        
                        showParticles = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            showParticles = false
                        }
                        saveMoney()
                        
                        isPressed = false // Setze den Zustand für den Push-Effekt zurück
                    }
                }) {
                    Text("Tap to Earn Money")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 0.1, green: 0.5, blue: 0.9), Color(red: 0.3, green: 0.7, blue: 1.0)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .shadow(color: .gray, radius: 5, x: 0, y: 2)
                        .scaleEffect(isPressed ? 0.95 : 1.0) // Skalierung basierend auf dem Zustand für den Push-Effekt
                        .animation(.spring()) // Animation für den Push-Effekt
                )
                .padding()
                
                if let booster = activeBooster {
                    Text("\(booster)x Booster aktiv")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.bottom, 20)
                        .padding(.trailing, 20)
                } else {
                    Spacer()
                }
            }
            .sheet(isPresented: $showShop) {
                ShopView(money: $money, moneyBoosters: $moneyBoosters, activeBooster: $activeBooster)
            }
        }
    }
    
    func saveMoney() {
        UserDefaults.standard.set(money, forKey: "Money")
    }
}

