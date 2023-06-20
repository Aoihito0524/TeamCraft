//
//  EmailInfoText.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/20.
//

import SwiftUI
import FirebaseAuth

struct EmailInfoText: View{
    var body: some View{
        VStack{
            Text("アカウント")
                .font(.caption)
            if let email = Auth.auth().currentUser?.email{
                Text(email)
            }
        }
    }
}
