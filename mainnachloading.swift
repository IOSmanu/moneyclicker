import SwiftUI

struct GameView: View {
    @State private var money = UserDefaults.standard.integer(forKey: "Money")
    @State private var moneyBoosters = UserDefaults.standard.integer(forKey: "MoneyBoosters")
    @State private var showParticles = false
    @State private var showShop = false
    @State private var showCosmeticShop = false
    @State private var activeBooster = UserDefaults.standard.integer(forKey: "ActiveBooster")
    @State private var isPressed = false
    @State private var isLoading = true // Add loading state

    var body: some View {
        if isLoading {
            LoadingView()
                .onAppear {
                    // Simulate loading content...
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        isLoading = false
                    }
                }
        } else {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.gray, Color.white, Color.green]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
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
                                .background(LinearGradient(gradient: Gradient(colors: [Color(red: 0.1, green: 0.5, blue: 0.9), Color(red: 0.3, green: 0.7, blue: 1.0)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                .cornerRadius(10)
                                .shadow(color: .gray, radius: 5, x: 0, y: 2)
                        }
                        .padding()
                        
                        Button(action: {
                            showCosmeticShop.toggle()
                        }) {
                            Text("Cosmetics")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(LinearGradient(gradient: Gradient(colors: [Color(red: 0.9, green: 0.1, blue: 0.5), Color(red: 1.0, green: 0.3, blue: 0.7)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                .cornerRadius(10)
                                .shadow(color: .gray, radius: 5, x: 0, y: 2)
                        }
                        .padding()
                    }
                    .padding(.top, 20)
                    
                    Text("💵 Money: \(money)")
                        .font(.title)
                        .padding()
                    
                    Button(action: {
                        isPressed = true
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            if activeBooster != 0 {
                                money += (activeBooster * moneyBoosters)
                            } else {
                                money += 1
                            }
                            
                            showParticles = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                showParticles = false
                            }
                            saveMoney()
                            
                            isPressed = false
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
                            .scaleEffect(isPressed ? 0.95 : 1.0)
                            .animation(.spring())
                    )
                    .padding()
                    
                    if activeBooster != 0 {
                        Text("\(activeBooster)x Booster aktiv")
                            .padding()
                            .foregroundColor(.black)
                            .background(Color.white)
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
                .sheet(isPresented: $showCosmeticShop) {
                    Text("Cosmetic Shop")
                }
            }
        }
    }
    
    func saveMoney() {
        UserDefaults.standard.set(money, forKey: "Money")
    }
}

