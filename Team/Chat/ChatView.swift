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
    @ObservedObject var ChatVM: ChatViewModel
    init(teamId: String){
        self.teamId = teamId
        ChatVM = ChatViewModel(teamId: teamId)
    }
    var body: some View{
        ZStack{
            Rectangle().fill(Color.white)
            VStack{
                ForEach(ChatVM.messages){message in
                    MessageUI(message: message)
                }
                Spacer()
                HStack{
                    TextField("", text: $ChatVM.textMessage)
                    Button(action:
                            {
                        ChatVM.AddMessage(message: ChatVM.textMessage, user: (Auth.auth().currentUser?.displayName)!)
                    }
                    ){
                        Rectangle().fill(Color.blue).frame(width: DEVICE_WIDTH*0.1, height: DEVICE_HEIGHT*0.05)
                    }
                }
            }
        }
    }
}

struct MessageUI: View{
    let message: messageDataType
    let dateFormatter = DateFormatter()
    init(message: messageDataType){
        self.message = message
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXX"//"MM月dd日HH:mm"
    }
    var body: some View{
        VStack{
            Text(dateFormatter.string(from: message.createAt))
            Text(message.message)
                .background(Color.green)
                .cornerRadius(20)
        }
    }
}

