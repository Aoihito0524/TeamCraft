//
//  ChatView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/10.
//

import SwiftUI
import FirebaseAuth

struct ChatView: View{
    let teamId: String
    @ObservedObject var VM: ChatViewModel
    init(teamId: String){
        self.teamId = teamId
        VM = ChatViewModel(teamId: teamId)
    }
    var body: some View{
        ZStack(alignment: .bottom){
            //背景
            Rectangle()
                .fill(BACKGROUND_COLOR)
                .ignoresSafeArea()
            VStack(spacing: 0){
                TopBar_ChatView()
                //メッセージ
                MessagesView(teamCom: VM.teamCom)
            }
            //メッセージ入力
            ZStack{
                Rectangle().fill(Color.white)
                    .frame(height: DEVICE_HEIGHT * 0.05)
                HStack{
                    TextField("", text: $VM.textMessage)
                        .background(Color(red: 0.9, green: 0.9, blue: 0.9))
                        .cornerRadius(15)
                    Button(action:
                            {
                        VM.AddMessage(message: VM.textMessage, user: (Auth.auth().currentUser?.displayName)!)
                    }
                    ){
                        Image(systemName: "paperplane")
                            .foregroundColor(Color.blue)
                    }
                }
                .padding(.horizontal, DEVICE_WIDTH * 0.05)
            }
            .frame(width: VERTICAL_SCROLLPANEL_WIDTH)
        }
    }
}

struct TopBar_ChatView: View{
    var body: some View{
        HStack{
            UserIcon(size: DEVICE_HEIGHT * 0.07)
                .padding(DEVICE_HEIGHT * 0.03)
            HStack{
                Text("チーム")
                    .font(.title)
                Image(systemName: "gearshape")
                Image(systemName: "person")
            }
            .padding(.trailing, DEVICE_HEIGHT * 0.05)
        }
        .frame(width: DEVICE_WIDTH)
        .background(Color.white.opacity(0.92))
    }
}

struct MessageUI: View{
    let messageWidth = DEVICE_WIDTH * 0.5
    let message: messageDataType
    let dateFormatter = DateFormatter()
    init(message: messageDataType){
        self.message = message
        dateFormatter.dateFormat = "MM月dd日HH:mm"//"yyyy-MM-dd'T'HH:mm:ssXXX"//
    }
    var body: some View{
        ZStack(alignment: isMyMessage() ? .trailing : .leading){
            Color.clear.frame(width: VERTICAL_SCROLLPANEL_WIDTH)
            VStack(alignment: isMyMessage() ? .trailing : .leading){
                //アイコンと名前
                if !isMyMessage(){
                    HStack{
                        UserIcon(size: DEVICE_HEIGHT * 0.02)
                        Text(message.userName)
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
        return message.userName == Auth.auth().currentUser?.displayName
    }
}

