//
//  SampleAnimation.swift
//  AnimationButtonExample
//
//  Created by kazunori.aoki on 2023/10/25.
//

import SwiftUI

struct SampleAnimation: View {
    @State private var scale: CGFloat = 1.0
    @State private var rotation: Double = 0.0

    var body: some View {
        VStack {
            Text("Animating Views")
                .font(.largeTitle)
                .padding()

            Button("Animate Scale and Rotate") {
                withAnimation {
                    scale += 0.2
                }

                withAnimation {
                    rotation += 45
                }
            }

            Button("Animate Scale and Rotate Together") {
                withAnimation {
                    scale += 0.2
                    rotation += 45
                }
            }

            Button("Animate Scale and Rotate with Group") {
                let animation = Animation.easeInOut(duration: 0.5)
                AnimationContext.runGroup(animations: [
                    { scale += 0.2 },
                    { rotation += 45 }
                ], using: animation)
            }
            
            Spacer()

            Image(systemName: "star.fill")
                .font(.system(size: 100))
                .scaleEffect(scale)
                .rotationEffect(.degrees(rotation))
                .foregroundColor(.yellow)
        }
    }
}

struct AnimationContext {
    static func runGroup(animations: [() -> Void], using animation: Animation) {
        withAnimation(animation) {
            for animationBlock in animations {
                animationBlock()
            }
        }
    }
}

#Preview {
    SampleAnimation()
}
