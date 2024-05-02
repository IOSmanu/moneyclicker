// LoadingView.swift

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red: 0.1, green: 0.5, blue: 0.9), Color(red: 0.3, green: 0.7, blue: 1.0)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack {
                Image(systemName: "gamecontroller.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    .frame(width: 100, height: 100)
                    .padding()
                
                Text("Lädt Inhalte herunter...")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
            }
        }
    }
}

