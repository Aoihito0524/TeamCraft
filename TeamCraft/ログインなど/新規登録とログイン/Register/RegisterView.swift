//
//  ContentView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/08.
//

import SwiftUI
import FirebaseAuth

struct RegisterView: View {
    @Binding var currentView: RegisterLoginView.CurrentView
    var body: some View {
        ZStack{
            Rectangle()
                .fill(BACKGROUND_COLOR)
                .ignoresSafeArea()
            RegisterByEmailView(currentView: $currentView)
        }
    }
}
