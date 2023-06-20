//
//  MailView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/10.
//

import SwiftUI

struct MailView: View{
    var body: some View{
        ZStack{
            Rectangle()
                .fill(BACKGROUND_COLOR)
                .ignoresSafeArea()
            VStack{
                TopBar_MailView()
                Spacer()
                Text("メールがありません")
                Spacer()
            }
        }
    }
}
