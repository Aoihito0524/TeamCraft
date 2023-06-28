//
//  MyAccountView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/10.
//

import SwiftUI
import FirebaseAuth

struct MyAccountView: View{
    var body: some View{
        ZStack{
            Rectangle().fill(BACKGROUND_COLOR)
                .ignoresSafeArea()
            VStack(spacing: 0){
                TopBar_MyAccountView()
                AccountInformationView()
                Spacer()
            }
        }
    }
}

//struct MyAccountPreview: PreviewProvider{
//    @State static var flag = false
//    static var previews: some View{
//        MyAccountView()
//    }
//}
