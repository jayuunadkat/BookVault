//
//  ActivityIndicator.swift
//  BookVault
//
//  Created by Jaymeen Unadkat on 10/04/25.
//


import SwiftUI

///`ActivityIndicator`
public struct ActivityIndicator: ViewModifier {
    
    @State private var isCircleRotating: Bool = false
    @State private var animateStart: Bool = false
    @State private var animateEnd: Bool = true
    
    var show: Bool
    var message: String = ""
    
    public func body(content: Content) -> some View {
        
        ZStack {
            content
            if self.show {
                Color.gray.opacity(0.3)
                    .ignoresSafeArea()
                
                VStack(spacing: 0.0) {
                    
                    Circle()
                        .trim(from: self.animateStart ? 1/3 : 1/9, to: self.animateEnd ? 2/5 : 1.0)
                        .stroke(lineWidth: 2.5)
                        .rotationEffect(.degrees(self.isCircleRotating ? 360.0 : 0))
                        .frame(width: 40.0, height: 40.0)
                        .padding(20.0)
                        .foregroundColor(Color.black)
                        .onAppear {
                            
                            DispatchQueue.main.async {
                                
                                withAnimation(.linear(duration: 1).repeatForever(autoreverses: false)) {
                                    self.isCircleRotating.toggle()
                                }
                                
                                withAnimation(.linear(duration: 1).repeatForever(autoreverses: true)) {
                                    self.animateStart.toggle()
                                }
                                
                                withAnimation(.linear(duration: 1).repeatForever(autoreverses: true)) {
                                    self.animateEnd.toggle()
                                }
                            }
                     
                        }.onDisappear {
                            self.isCircleRotating.toggle()
                        }
                    
                    if message != "" {
                        
                        Text(message)
                            .dynamicTypeSize(.medium)
                            .padding(.bottom, 8.0)
                            .padding(.horizontal, 8.0)
                    }
                }
                .background(Color.white)
                .cornerRadius(15.0)
                
            }
        }
    }
}
#Preview {
    VStack {
        
    }
    //ActivityIndicator()
}

///`View Modifier`
public extension View {
    func activityIndicator(show: Bool) -> some View {
        self.modifier(ActivityIndicator(show: show))
    }
}


///`Indicator`
public struct Indicator {
    public static func show()  {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: .showLoader, object: [true])
        }
    }
    public static func hide() {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: .showLoader, object: [false])
        }
    }
}
