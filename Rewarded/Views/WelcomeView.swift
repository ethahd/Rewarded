//
//  WelcomeView.swift
//  Rewarded
//
//  Created by Ethan AK on 4/21/25.
//
import SwiftUI

struct WelcomeView: View {
    @State private var showWallet = false
    @State private var moveWallet = false
    @State private var showLine1 = false
    @State private var showLine2 = false
    @State private var showButton = false
    @State private var navigateToHome = false

    var body: some View {
        ZStack {
            Color.black.opacity(0.9)
                .ignoresSafeArea()
            if navigateToHome {
                MainTabView()
                    .transition(.move(edge: .trailing))
            }
            else {
                VStack (spacing: 20) {
                    
                    Image("credit")
                        .resizable()
                        .scaledToFit()
                        .frame(width: moveWallet ? 200 : 100, height: moveWallet ? 200 : 100)
                        .opacity(showWallet ? 1 : 0)
                        .offset(y: moveWallet ? -150 : 0)
                        .padding(.top, 50)
                    
                    if showLine1 {
                        Text("Rewarded.")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(Color("Gold"))
                            .transition(AnyTransition.move(edge: .trailing))
                    }
                    
                    if showLine2 {
                        Text("Maximize your rewards.")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(Color("Plat"))
                            .transition(AnyTransition.move(edge: .leading))
                        
                    }
                    
                    if showButton {
                        Button (action: {
                            withAnimation {
                                navigateToHome = true
                            }
                        }) {
                            Text("Get Started")
                                .font(.title3)
                                .fontWeight(.regular)
                                .foregroundStyle(Color.black)
                                .padding()
                                .background(LinearGradient(gradient: Gradient(colors: [Color("Plat"), Color("Gold")]), startPoint: .top, endPoint: .bottom))
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                    }
                }
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.5)) {
                        showWallet = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        withAnimation(.easeInOut(duration: 1.1)) {
                            moveWallet = true
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                        withAnimation(.easeInOut(duration: 1.0)) {
                            showLine1 = true
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) {
                        withAnimation(.easeInOut(duration: 1.0)) {
                            showLine2 = true
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.2) {
                        withAnimation(.easeInOut(duration: 1.0)) {
                            showButton = true
                        }
                    }
                }
            }
            
            
        }
    }
}

struct WelcomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
