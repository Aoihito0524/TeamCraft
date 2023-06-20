//
//  TeamRolesView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/20.
//

import SwiftUI

struct TeamRolesRow: View{
    @Binding var teamRoles: [(String, Int)]
    @Binding var myRole: String?
    @State var roles = ""
    @State private var Roles = [String]()
    @State private var Num_Assign = [Int]()
    @State private var myRole_selection = 0
    let selections = Array(1...10)
    var body: some View{
        VStack(alignment: .leading){
            Text("人数と役割")
            Group{
                ForEach(0..<teamRoles.count, id: \.self){num in
                    HStack{
                        TextField("役割", text: $Roles[num])
                        Picker("人数", selection: $Num_Assign[num]) {
                            ForEach(selections, id: \.self) { i in
                                Text("\(i)人")
                            }
                        }
                        .onChange(of: Num_Assign[num]){newValue in
                            teamRoles[num].1 = newValue
                        }
                        .onChange(of: Roles[num]){newValue in
                            teamRoles[num].0 = newValue
                        }
                    }
                }
                Button("+ 追加する"){
                    teamRoles.append(("", 1))
                    Roles.append("")
                    Num_Assign.append(1)
                }
                HStack{
                    Text("自分の役割")
                    Picker("役割", selection: $myRole_selection) {
                        ForEach(0..<teamRoles.count, id: \.self) { num in
                            Text(teamRoles[num].0)
                                .tag(num)
                        }
                    }
                    .onChange(of: myRole_selection){newValue in
                        myRole = teamRoles[newValue].0
                    }
                    .onChange(of: Roles){newValue in
                        myRole = newValue[myRole_selection]
                    }
                }
            }
            .padding(.leading, DEVICE_WIDTH*0.05)
        }
        .onAppear{
            Roles = [String]()
            Num_Assign = [Int]()
            myRole_selection = 0
        }
    }
}
