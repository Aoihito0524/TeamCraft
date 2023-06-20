//
//  TopBar_MailView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/20.
//

import SwiftUI

struct TopBar_MailView: View{
    var body: some View{
        HStack{
            UserIcon(size: DEVICE_HEIGHT * 0.07)
                .padding(DEVICE_HEIGHT * 0.03)
            Text("メール")
                .font(.title)
                .padding(.trailing, DEVICE_HEIGHT * 0.05)
        }
        .frame(width: DEVICE_WIDTH)
        .background(Color.white.opacity(0.92))
    }
}
