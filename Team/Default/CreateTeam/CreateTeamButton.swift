//
//  CreateTeamButton.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/20.
//

import SwiftUI

struct CreateTeamButton: View{
    @ObservedObject var VM: CreateTeamViewModel
    @Binding var isCreatingTeam: Bool
    var body: some View{
        Button(
            action: {
                if !VM.CanCreateTeam(){return;}
                VM.CreateTeam()
                isCreatingTeam = false
            }
        ){
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray)
                    .frame(width: DEVICE_WIDTH*0.25, height: DEVICE_WIDTH * 0.12)
                Text("決定")
            }
        }
    }
}
