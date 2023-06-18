//
//  LoginView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/19.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @Binding var currentView: AuthenticationView.CurrentView
    var body: some View {
        ZStack{
            Rectangle()
                .fill(BACKGROUND_COLOR)
                .ignoresSafeArea()
            LoginByEmailView(currentView: $currentView)
        }
    }
}
