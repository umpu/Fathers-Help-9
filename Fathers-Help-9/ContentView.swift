//
//  ContentView.swift
//  Fathers-Help-9
//
//  Created by a on 25.03.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var offset: CGSize = .zero
    @State private var point = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
    
    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(
                    RadialGradient(
                        gradient: .init(colors: [.yellow, .red]),
                        center: .center,
                        startRadius: 55,
                        endRadius: 110
                    )
                )
                .mask {
                    Canvas { context, size in
                        let symbol_0 = context.resolveSymbol(id: 0)!
                        let symbol_1 = context.resolveSymbol(id: 1)!
                        
                        context.addFilter(.alphaThreshold(min: 0.5, color: .yellow))
                        context.addFilter(.blur(radius: 30))
                        
                        context.drawLayer { context in
                            context.draw(symbol_0, at: point)
                            context.draw(symbol_1, at: point)
                        }
                    } symbols: {
                        Circle().frame(width: 110).tag(0)
                        Circle().frame(width: 111).tag(1)
                            .offset(x: offset.width, y: offset.height)
                    }
                }
                .overlay {
                    Image(systemName: "cloud.sun.rain.fill")
                        .font(.system(size: 40))
                        .symbolRenderingMode(.hierarchical)
                        .foregroundStyle(.white)
                        .offset(x: offset.width, y: offset.height)
                }
                .gesture(DragGesture()
                    .onChanged { value in
                        offset = value.translation
                    }
                    .onEnded { _ in
                        withAnimation(.bouncy) {
                            offset = .zero
                        }
                    }
                )
                .ignoresSafeArea()
                .background(.black)
        }
    }
}

#Preview {
    ContentView()
}
