//  RegisterUserNameView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/08.
//

import SwiftUI
import FirebaseAuth

struct RegisterUserNameView: View{
    @Binding var finishFlag: Bool
    @ObservedObject var VM = RegisterUserNameViewModel()
    @ObservedObject var userIcon = UserInformation.shared.userIcon
    var body: some View{
        VStack{
            Text("ユーザーネームを登録")
                .font(.title)
                .padding(.vertical, DEVICE_HEIGHT * 0.05)
            Button(action: {VM.isSelectingImage = true}){
                UserIcon(size: DEVICE_WIDTH*0.5)
            }
            .sheet(isPresented: $VM.isSelectingImage){
                ImagePicker(image: $userIcon.image)
            }
            TextField("名前を入力", text: $VM.name)
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(TextAlignment.center)
                .frame(width: DEVICE_WIDTH * 0.75)
                .padding(.bottom, DEVICE_HEIGHT * 0.08)
            Divider()
            Button("次へ"){
                VM.RegisterUserName()
                VM.RegisterUserIcon()
                finishFlag.toggle()
            }
            .frame(height: DEVICE_HEIGHT * 0.08)
        }
        .frame(width: VERTICAL_SCROLLPANEL_WIDTH)
        .background(Color.white)
        .cornerRadius(10)
    }
}
