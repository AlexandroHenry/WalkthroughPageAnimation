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
    @State var currentIndex: Int = 0
    
    var body: some View {
        ZStack {
            Color("BG")
                .ignoresSafeArea()
            
            IntroScreen()
                
            WalkThroughScreens()
            
            NavBar()
        }
        .animation(.interactiveSpring(response: 1.1, dampingFraction: 0.85, blendDuration: 0.85), value: showWalkThroughScreens)
    }
    
    // MARK: WalkThrough Screens
    @ViewBuilder
    func WalkThroughScreens() -> some View {
        
        let isLast = currentIndex == intros.count
        
        GeometryReader {
            let size = $0.size
            
            ZStack {
                
                // MARK: Walk Through Screens
                ForEach(intros.indices, id: \.self) { index in
                    ScreenView(size: size, index: index)
                }
                
                WelcomeView(size: size, index: intros.count)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            // MARK: Next Button
            .overlay(alignment: .bottom) {
                // MARK: Converting Next Button Into SignUp Button
                ZStack {
                    Image(systemName: "chevron.right")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .scaleEffect(!isLast ? 1 : 0.001)
                        .opacity(!isLast ? 1 : 0)
                    
                    HStack {
                        Text("Sign Up")
                            .font(.custom(sansBold, size: 15))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Image(systemName: "arrow.right")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 15)
                    .scaleEffect(isLast ? 1 : 0.001)
                    .frame(height: isLast ? nil : 0)
                    .opacity(isLast ? 1 : 0)
                }
                .frame(width: isLast ? size.width / 1.5 : 55, height: isLast ? 50 : 55)
                .foregroundColor(.white)
                .background {
                    RoundedRectangle(cornerRadius: isLast ? 10 :30, style: isLast ? .continuous : .circular)
                        .fill(Color("Blue"))
                }
                .onTapGesture {
                    // MARK: Upadting Index
                    currentIndex += 1
                }
                .offset(y: isLast ? -40 : -90)
                // Animation
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5), value: isLast)
            }
            .offset(y: showWalkThroughScreens ? 0 : size.height)
        }
    }
    
    @ViewBuilder
    func ScreenView(size: CGSize, index: Int) -> some View {
        let intro = intros[index]
        
        VStack(spacing: 10) {
            
            Text(intro.title)
                .font(.custom(sansBold, size: 28))
                // MARK: Applying Offset For Each Screen's
                .offset(x: -size.width * CGFloat(currentIndex - index))
                // MARK: Adding Animation
                // MARK: Adding Delay to Elements based On Index
                // My Delay Starts From Top
                // You can also modify code to start delay from Bottom
                // Delay
                // 0.2, 0.1, 0
                // Adding Extra 0.2 For Current Index
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0.2 : 0).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
            
            Text(dummyText)
                .font(.custom(sansRegular, size: 14))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(0.1).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
            
            Image(intro.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 250, alignment: .top)
                .padding(.horizontal, 20)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0 : 0.2).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
        }
    }
    
    // MARK: Welcome Screen
    @ViewBuilder
    func WelcomeView(size: CGSize, index: Int) -> some View {
        
        VStack(spacing: 10) {
            
            Image("Welcome")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 250, alignment: .top)
                .padding(.horizontal, 20)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0 : 0.2).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
            
            Text("Welcome")
                .font(.custom(sansBold, size: 28))
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0.2 : 0).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
            
            Text("Stay organised and live stress-free with\nyou-do app.")
                .font(.custom(sansRegular, size: 14))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(0.1).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
        }
    }
    
    // MARK: Nav Bar
    @ViewBuilder
    func NavBar() -> some View {
        HStack {
            Button {
                
                // If Greater than Zero Then Eliminating Index
                if currentIndex > 0 {
                    currentIndex -= 1
                } else {
                    showWalkThroughScreens.toggle()
                }
                
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
