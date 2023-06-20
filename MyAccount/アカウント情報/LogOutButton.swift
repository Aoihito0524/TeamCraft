//
//  LogOutButton.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/20.
//

import SwiftUI
import FirebaseAuth

struct LogOutButton: View{
    var body: some View{
        Button("ログアウト"){
            do {
                try Auth.auth().signOut()
                print("ログアウトしました")
            } catch let signOutError as NSError {
                print("Error signing out: \(signOutError)")
            }
        }
        .foregroundColor(Color.red)
    }
}
