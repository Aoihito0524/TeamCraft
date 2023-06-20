//
//  UserSymbols.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/20.
//

import SwiftUI
import FirebaseAuth

struct UserSymbols: View{
    var body: some View{
        HStack{
            UserIcon(size: DEVICE_WIDTH * 0.18)
                .padding(.trailing, DEVICE_WIDTH * 0.05)
            VStack(alignment: .leading){
                Text("ユーザーネーム")
                    .font(.caption)
                Text((Auth.auth().currentUser?.displayName)!)
                    .font(.largeTitle)
            }
        }
    }
}
