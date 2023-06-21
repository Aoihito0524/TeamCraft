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
    @ObservedObject var VM = CreateTeamViewModel()
    var body: some View{
        NavigationView{
            ZStack{
                Rectangle()
                    .fill(BACKGROUND_COLOR)
                    .ignoresSafeArea()
                VStack(spacing: 0){
                    TopBar_CreateTeamView()
                    ScrollView{
                        VStack(alignment: .leading, spacing: DEVICE_HEIGHT * 0.06){
                            Rectangle().fill(Color.clear)
                                .frame(height: DEVICE_HEIGHT * 0.03)
                            if let message = VM.retryMessage{
                                Text(message)
                            }
                            //画像 こいつはpaddingすると画像もずれてダメ
                            SelectHeadlineImage(isSelectingImage: $VM.isSelectingImage, image: $VM.teamInfo.image.image)
                            Group{
                                //タイトル
                                CreateTitleTextField(titleText: $VM.teamInfo.title)
                                //タグ
                                SelectTagRow(tagGroup: $VM.teamInfo.tags)
                                //概要
                                DescriptionTextField(descriptionText: $VM.teamInfo.description)
                                //人数と役割
                                TeamRolesRow(teamRoles: $VM.teamInfo.teamRolesLeft, myRole: $VM.myRole, Set_Num_FullMember: {VM.Set_Num_FullMember()})
                                //準備期間
                                PrepareDurationPicker(prepareDays: $VM.teamInfo.prepareDays)
                            }
                            .padding(.leading, DEVICE_WIDTH * 0.1)
                            //チーム作成ボタン
                            HStack{
                                Spacer()
                                CreateTeamButton(VM: VM, isCreatingTeam: $isCreatingTeam)
                                Spacer()
                            }
                            .padding(.bottom, DEVICE_HEIGHT * 0.05)
                        }
                        .frame(width: VERTICAL_SCROLLPANEL_WIDTH)
                        .background(Color.white.opacity(0.82))
                    }
                }
            }
        }
    }
}

struct TopBar_CreateTeamView: View{
    var body: some View{
        HStack{
            UserIcon(size: DEVICE_HEIGHT * 0.07)
                .padding(DEVICE_HEIGHT * 0.03)
            Text("チームを作成")
                .font(.title)
                .padding(.trailing, DEVICE_HEIGHT * 0.05)
        }
        .frame(width: DEVICE_WIDTH)
        .background(Color.white.opacity(0.92))
    }
}

class CreateTeamViewModel: ObservableObject{
    @Published var teamInfo = TeamInformation()
    @Published var isSelectingImage = false
    @Published var retryMessage: String?
    @Published var myRole: String?
    func CreateTeam(){
        teamInfo.register()
        let teamCom = TeamCommunication(teamId: teamInfo.teamId)
        teamCom.Join(role: myRole!, teamInfo: teamInfo)
    }
    func Set_Num_FullMember(){
        teamInfo.num_FullMember = teamInfo.NumLeft_Member()
    }
    //全条件を満たし作成可能な場合Trueを返す
    func CanCreateTeam() -> Bool{
        if teamInfo.title == ""{
            retryMessage = "タイトルを入力してください"
            return false;
        }
        else if teamInfo.description == ""{
            retryMessage = "概要を入力してください"
            return false;
        }
        else if teamInfo.tags.tags.count == 0{
            retryMessage = "タグは一つ以上設定してください"
            return false;
        }
        else if teamInfo.teamRolesLeft.count == 0{
            retryMessage = "役割は一つ以上設定してください"
            return false;
        }
        else if myRole == nil{
            retryMessage = "自分の役割を設定してください"
            return false;
        }
        return true
    }
}
