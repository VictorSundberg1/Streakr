//
//  ToastModifier.swift
//  Streakr
//
//  Created by Victor Sundberg on 2025-04-29.
//

import Foundation
import SwiftUI

struct ToastModifier: ViewModifier {
    @Binding var isShowing: Bool
    let message: String
    let duration: TimeInterval
    
    func body(content: Content) -> some View {
        content
            .overlay(
                Group {
                    if isShowing {
                        toastView
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                            .onAppear {
                                Task {
                                    try? await Task.sleep(nanoseconds: UInt64(duration * 1_000_000_000))
                                    withAnimation {
                                        isShowing = false
                                    }
                                }
                            }
                    }
                },
                alignment: .bottom
            )
            .animation(.easeInOut, value: isShowing)
        
    }
    private var toastView: some View {
        Text(message)
            .font(.caption)
            .foregroundStyle(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(Color.loginRed.opacity(0.9))
            .clipShape(.rect(cornerRadius: 12))
            .shadow(radius: 4)
            .padding(.bottom, 40)
    }
}

extension View {
    func toast(isShowing: Binding<Bool>, message: String, duration: TimeInterval = 3) -> some View {
        self.modifier(ToastModifier(isShowing: isShowing, message: message, duration: duration))
    }
}

