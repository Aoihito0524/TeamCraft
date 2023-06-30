//
//  MessageUI.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/30.
//

import SwiftUI
import FirebaseAuth

struct MessageUI: View{
    let messageWidth = DEVICE_WIDTH * 0.5
    let message: messageDataType
    let dateFormatter = DateFormatter()
    let sender: UserInformation
    init(message: messageDataType, teamCom: TeamCommunication){
        self.message = message
        dateFormatter.dateFormat = "MM月dd日HH:mm"//"yyyy-MM-dd'T'HH:mm:ssXXX"//
        sender = teamCom.userInfos[message.userId]!
    }
    var body: some View{
        ZStack(alignment: isMyMessage() ? .trailing : .leading){
            Color.clear.frame(width: VERTICAL_SCROLLPANEL_WIDTH)
            VStack(alignment: isMyMessage() ? .trailing : .leading){
                //アイコンと名前
                if !isMyMessage(){
                    HStack{
                        UserIcon(size: DEVICE_HEIGHT * 0.02, photoURL: sender.photoURL)
                        Text(sender.userName)
                    }
                }
                //テキスト本体
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.green)
                    Text(message.message)
                        .font(.body)
                        .lineLimit(nil)
                        //そのままだと字が欠けるため少し大きめに
                        .padding(.all, DEVICE_WIDTH * 0.01)
                }
                //送信日時
                Text(dateFormatter.string(from: message.createAt))
                    .font(.caption)
            }
            .frame(width: messageWidth)
        }
    }
    func isMyMessage() -> Bool{
        return message.userId == Auth.auth().currentUser?.uid
    }
}

