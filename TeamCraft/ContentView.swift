//
//  ContentView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/08.
//

import SwiftUI
import FirebaseAuth

@MainActor

struct ContentView: View{
    @State var needAuthentication = true
    var body: some View{
        if needAuthentication{
            AuthenticationView(needAuthentication: $needAuthentication)
        }
        else{
            HomeView()
        }
    }
}
