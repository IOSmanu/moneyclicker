import SwiftUI

struct GameView: View {
    @State private var money = UserDefaults.standard.integer(forKey: "Money")
    @State private var moneyBoosters = UserDefaults.standard.integer(forKey: "MoneyBoosters")
    @State private var showParticles = false
    @State private var showShop = false
    @State private var activeBooster: Int?
    
    var body: some View {
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
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
            }
            .padding(.top, 20)
            
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
            
            Spacer()
            
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
    
    func saveMoney() {
        UserDefaults.standard.set(money, forKey: "Money")
    }
}
