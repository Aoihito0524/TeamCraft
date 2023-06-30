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
    @ObservedObject var VM = ContentViewModel()
    var body: some View{
        ZStack{
            if VM.needAuthentication{
                AuthenticationView(needAuthentication: $VM.needAuthentication)
            }
            else{
                HomeView()
            }
        }
    }
}

class ContentViewModel: ObservableObject{
    @Published var needAuthentication = true
    func SetListener_WhenAuthChanged(){
        Auth.auth().addStateDidChangeListener{ auth, user in
            self.needAuthentication = (user == nil)
        }
    }
}

