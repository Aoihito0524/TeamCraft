//
//  TextFields.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/18.
//

import SwiftUI

extension View {
    func textFieldTexture() -> some View {
        self.frame(width: DEVICE_WIDTH * 0.75, height: DEVICE_HEIGHT * 0.04)
        .background(Color(red: 0.396, green: 0.737, blue: 0.929))
        .cornerRadius(10)
        .textFieldStyle(.roundedBorder)
        .multilineTextAlignment(TextAlignment.center)
        .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(Color.black, lineWidth: 1)
            .background(Color.clear))
    }
    func enterButtonTexture() -> some View {
        self.frame(width: DEVICE_WIDTH * 0.75, height: DEVICE_HEIGHT * 0.04)
        .background(Color(red: 0.396, green: 0.737, blue: 0.929))
        .cornerRadius(10)
        .textFieldStyle(.roundedBorder)
        .multilineTextAlignment(TextAlignment.center)
        .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(Color.black, lineWidth: 1)
            .background(Color.clear))
    }
}
