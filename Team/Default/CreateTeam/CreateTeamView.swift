//
//  CreateTeamView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/10.
//

import SwiftUI
import FirebaseFirestore
import FirebaseStorage

struct CreateTeamView: View{
    @Binding var isCreatingTeam: Bool
    @ObservedObject var createTeamVM = CreateTeamViewModel()
    var body: some View{
        NavigationView{
            VStack{
                //画像
                Button(action: {createTeamVM.isSelectingImage = true}){
                    ZStack{
                        Rectangle().fill(Color.gray).frame(width: DEVICE_WIDTH, height: DEVICE_WIDTH * 0.4)
                        if let image = createTeamVM.teamInfo.image{
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: DEVICE_WIDTH, height: DEVICE_WIDTH * 0.4)
                        }
                    }
                }
                .sheet(isPresented: $createTeamVM.isSelectingImage){
                    ImagePicker(image: $createTeamVM.teamInfo.image)
                }
                //タグ
                NavigationLink{
                    SelectTagView(selectedTagsGroup: $createTeamVM.teamInfo.tags)
                } label: {
                    Text("タグを選ぶ")
                }
                ForEach(createTeamVM.teamInfo.tags.tags){ tag in
                    HStack{
                        TagLabel(tag: tag)
                    }
                }
                //タイトル
                Text("タイトル")
                TextField("タイトルを入力", text: $createTeamVM.teamInfo.title)
                //概要
                HStack{
                    Text("概要")
                    Text("（検索には影響しません）")
                }
                TextField("概要を入力", text: $createTeamVM.teamInfo.description)
                Button(
                    action: {
                        createTeamVM.CreateTeam()
                        isCreatingTeam = false
                    }
                ){
                    Text("決定")
                }
            }
        }
    }
}

class CreateTeamViewModel: ObservableObject{
    //Model
    @Published var teamInfo = TeamInformation()
    @Published var isSelectingImage = false
    //
    func CreateTeam(){
        teamInfo.register()
    }
}
