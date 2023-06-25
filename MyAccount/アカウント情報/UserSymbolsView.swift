//
//  UserSymbols.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/20.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage

struct UserSymbolsView: View{
    @ObservedObject var VM = UserSymbolsViewModel()
    var body: some View{
        HStack{
            Button(action: {VM.isSelectingImage = true}){
                UserIcon(size: DEVICE_WIDTH * 0.18)
                    .padding(DEVICE_WIDTH * 0.05)
            }
            .sheet(isPresented: $VM.isSelectingImage){
                ImagePicker(image: $VM.userSymbols.userIcon.image)
            }
            VStack(alignment: .leading){
                Text("ユーザーネーム")
                    .font(.caption)
                TextField("名前", text: $VM.userSymbols.userName)
                    .font(.largeTitle)
            }
            Button("更新"){
                VM.Save()
            }
        }
    }
}

class UserSymbolsViewModel: ObservableObject{
    @Published var userSymbols = UserSymbols.shared
    @Published var isSelectingImage = false
    func Save(){
        userSymbols.Save()
    }
}
