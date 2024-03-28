//
//  ContentView.swift
//  Fathers-Help-9
//
//  Created by a on 25.03.2024.
//

import SwiftUI

struct ContentView: View {
    @State var offset: CGSize = .zero
    
    var ball: some View {
        Circle()
            .frame(width: 150, height: 150)
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            RadialGradient(colors: [.yellow, .red], center: .center, startRadius: 70, endRadius: 160)
                .mask {
                    Canvas { context, size in
                        context.addFilter(.alphaThreshold(min: 0.5))
                        context.addFilter(.blur(radius: 40))
                        
                        context.drawLayer { ctx in
                            for index in [1, 2] {
                                if let resolved = context.resolveSymbol(id: index) {
                                    ctx.draw(resolved, at: .init(x: size.width / 2, y: size.height / 2))
                                }
                            }
                        }
                    } symbols: {
                        ball.tag(1)
                        ball.tag(2)
                            .offset(offset)
                    }
                }
            
            Image(systemName: "cloud.sun.rain.fill")
                .symbolRenderingMode(.hierarchical)
                .resizable()
                .scaledToFit()
                .frame(width: 80)
                .offset(offset)
                .foregroundStyle(.white)
        }
        .gesture(DragGesture()
            .onChanged { drag in
                offset = drag.translation
            }
            .onEnded { _ in
                withAnimation{
                    offset = .zero
                }
            }
        )
        
    }
}

#Preview {
    ContentView()
}
