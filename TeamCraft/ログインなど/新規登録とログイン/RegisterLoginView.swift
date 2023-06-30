//
//  AuthenticationView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/19.
//

import SwiftUI

struct RegisterLoginView: View{
    enum CurrentView{
        case registerByEmail
        case loginByEmail
    }
    @State var currentView = CurrentView.loginByEmail
    var body: some View{
        ZStack{
            if currentView == CurrentView.registerByEmail{
                RegisterView(currentView: $currentView)
            }
            if currentView == CurrentView.loginByEmail{
                LoginView(currentView: $currentView)
            }
        }
    }
}
