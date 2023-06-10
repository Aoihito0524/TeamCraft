//
//  ContentView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/08.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View{
    @State var needRegister = false
    @State var registerFinishFlag = false
    var body: some View{
        ZStack{
            if needRegister{
                RegisterView(registerFinishFlag: $registerFinishFlag)
            }
            else{
                HomeView()
            }
        }
        .onAppear{
            needRegister = !AllRegisterDone()
        }
        .onChange(of: registerFinishFlag){_ in
            needRegister = false
        }
    }
    func AllRegisterDone() -> Bool{
        if let user = Auth.auth().currentUser{
            print(user.isEmailVerified)
            print(user.displayName!)
            return user.isEmailVerified && user.displayName != nil;
        }
        return false;
    }
}
