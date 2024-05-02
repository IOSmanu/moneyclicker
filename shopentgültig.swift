import SwiftUI

struct ShopView: View {
    @Binding var money: Int
    @Binding var moneyBoosters: Int
    @Binding var activeBooster: Int?
    @State private var boughtBoosters: Set<Int> = Set()
    let boosterPrices = [2: 0, 3: 0, 10: -75141]
    
    var body: some View {
        VStack {
            Text("Money Boosters Shop")
                .font(.title)
                .padding()
            
            ForEach(boosterPrices.sorted(by: { $0.key < $1.key }), id: \.key) { (count, price) in
                let isBought = boughtBoosters.contains(count)
                
                Button(action: {
                    if !isBought && money >= price {
                        money -= price
                        moneyBoosters = count
                        UserDefaults.standard.set(moneyBoosters, forKey: "MoneyBoosters")
                        UserDefaults.standard.set(money, forKey: "Money")
                        activeBooster = count
                        boughtBoosters.insert(count)
                    }
                }) {
                    Text("\(count)x Booster - \(price) Money")
                        .font(.headline)
                        .padding()
                        .foregroundColor(.white)
                        .background(isBought ? Color.gray : Color.blue)
                        .cornerRadius(10)
                }
                .padding()
                .disabled(isBought)
            }
            
            Spacer()
        }
        .background(Color.white)
        .cornerRadius(20)
        .padding()
        .shadow(radius: 10)
    }
}
