//
//  IntroView.swift
//  WalkthroughPageAnimation
//
//  Created by Seungchul Ha on 2022/12/16.
//

import SwiftUI

struct IntroView: View {
    
    // MARK: Animation Properties
    @State var showWalkThroughScreens: Bool = false
    
    var body: some View {
        ZStack {
            Color("BG")
                .ignoresSafeArea()
            
            IntroScreen()
                
            NavBar()
        }
        .animation(.interactiveSpring(response: 1.1, dampingFraction: 0.85, blendDuration: 0.85), value: showWalkThroughScreens)
    }
    
    // MARK: Nav Bar
    @ViewBuilder
    func NavBar() -> some View {
        HStack {
            Button {
                showWalkThroughScreens.toggle()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("Blue"))
            }
            
            Spacer()
            
            Button("Skip") {
                
            }
            .font(.custom(sansRegular, size: 14))
            .foregroundColor(Color("Blue"))
        }
        .padding(.horizontal, 14)
        .padding(.top, 10)
        .frame(maxHeight: .infinity, alignment: .top)
        .offset(y: showWalkThroughScreens ? 0 : -120)
    }
    
    @ViewBuilder
    func IntroScreen() -> some View {
        
        GeometryReader {
            let size = $0.size
            
            VStack(spacing: 10) {
                Image("Intro")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height / 2)
                
                Text("Clearhead")
                    .font(.custom(sansBold, size: 27))
                    .padding(.top, 55)
                
                Text(dummyText)
                    .font(.custom(sansRegular, size: 14))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                
                Text("Let's Begin")
                    .font(.custom(sansSemiBold, size: 14))
                    .padding(.horizontal, 40)
                    .padding(.vertical, 14)
                    .foregroundColor(.white)
                    .background {
                        Capsule()
                            .fill(Color("Blue"))
                    }
                    .onTapGesture {
                        showWalkThroughScreens.toggle()
                    }
                    .padding(.top, 30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
            // MARK: Moving Up When Clicked
            .offset(y: showWalkThroughScreens ? -size.height : 0)
        }
        .ignoresSafeArea()
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: Home View
struct Home: View {
    
    var body: some View {
        NavigationStack {
            Text("")
                .navigationTitle("Home")
        }
    }
}
