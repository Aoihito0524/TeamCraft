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
                        if let image = createTeamVM.teamImage{
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: DEVICE_WIDTH, height: DEVICE_WIDTH * 0.4)
                        }
                    }
                }
                .sheet(isPresented: $createTeamVM.isSelectingImage){
                    ImagePicker(image: $createTeamVM.teamImage)
                }
                //タグ
                NavigationLink{
                    SelectTagView(selectedTags: $createTeamVM.teamTags)
                } label: {
                    Text("タグを選ぶ")
                }
                ForEach(createTeamVM.teamTags){ tag in
                    HStack{
                        TagLabel(tag: tag)
                    }
                }
                //タイトル
                Text("タイトル")
                TextField("タイトルを入力", text: $createTeamVM.teamTitle)
                //概要
                HStack{
                    Text("概要")
                    Text("（検索には影響しません）")
                }
                TextField("概要を入力", text: $createTeamVM.teamDescription)
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
    var teamTitle: String{
        get { return teamInfo.title }
        set{ teamInfo.title = newValue }
    }
    var teamDescription: String{
        get { return teamInfo.description }
        set{ teamInfo.description = newValue }
    }
    var teamTags: [Tag]{
        get { return teamInfo.tags.tags }
        set{ teamInfo.tags.tags = newValue }
    }
    var teamImage: UIImage?{
        get { return teamInfo.image }
        set{ teamInfo.image = newValue }
    }
    func CreateTeam(){
        teamInfo.register()
    }
}
