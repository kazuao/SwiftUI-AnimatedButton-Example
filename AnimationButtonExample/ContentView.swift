//
//  ContentView.swift
//  AnimationButtonExample
//
//  Created by kazunori.aoki on 2023/10/24.
//

import SwiftUI

struct ContentView: View {
    @State var appear = false
    @State private var appear2: Bool = false
    @State private var appear3: Bool = false

    private let duration: Double = 0.2
    @State private var delayTime: Double = 0

    var body: some View {
        Image(.image)
            .resizable()
            .frame(width: 96, height: 96)
            .scaleEffect(appear ? 1.1 : 1)
            .offset(y: appear ? -20 : 0)
            .rotationEffect(
                .init(degrees: appear2 ? 8 : 0)
            )
            .rotationEffect(
                .init(degrees: appear3 ? -8 : 0)
            )
            .task {
                await animation()
            }
    }

    func animation() async {
        while !Task.isCancelled {
            withAnimation(.easeOut(duration: duration)) {
                appear = true
                addDelayTime()
            }
            withAnimation(.easeOut(duration: duration).delay(delayTime)) {
                appear2 = true
                addDelayTime()
            }

            withAnimation(.easeOut(duration: duration).delay(delayTime)) {
                appear2 = false
                addDelayTime()
            }

            withAnimation(.easeOut(duration: duration).delay(delayTime)) {
                appear3 = true
                addDelayTime()
            }

            withAnimation(.easeOut(duration: duration).delay(delayTime)) {
                appear3 = false
                addDelayTime()
            }

            withAnimation(.easeOut(duration: duration).delay(delayTime)) {
                appear = false
                addDelayTime()
            }

            try? await Task.sleep(seconds: delayTime + 0.5)
            resetDelayTime()
        }
    }

    private func addDelayTime() {
        delayTime += duration
    }

    private func resetDelayTime() {
        delayTime = 0
    }

    @ViewBuilder
    func CircleView() -> some View {
        Circle()
            .trim(from: 0.2, to: 1)
            .stroke(
                Color.blue,
                style: StrokeStyle(
                    lineWidth: 5, lineCap: .round, lineJoin: .round
                )
            )
            .frame(width: 44, height: 44)
    }
}

#Preview {
    ContentView()
}

extension Task where Success == Never, Failure == Never {
    static func sleep(seconds duration: TimeInterval) async throws {
        let delay = UInt64(duration * 1000 * 1000 * 1000)
        try await Task.sleep(nanoseconds: delay)
    }
}
