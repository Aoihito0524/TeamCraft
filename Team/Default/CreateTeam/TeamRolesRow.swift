//
//  TeamRolesView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/20.
//

import SwiftUI

struct TeamRolesRow: View{
    @Binding var teamRoles: [(String, Int?)]
    @State var roles = ""
    let selections = Array(1...10)
    var body: some View{
        VStack(alignment: .leading){
            Text("人数と役割")
            Group{
                ForEach(0..<teamRoles.count, id: \.self){num in
                    HStack{
                        TextField("役割", text: $teamRoles[num].0)
                        Picker("人数", selection: $teamRoles[num].1) {
                            ForEach(selections, id: \.self) { i in
                                Text("\(i)人")
                            }
                        }
                    }
                }
                Button("+ 追加する"){
                    teamRoles.append(("", nil))
                }
            }
            .padding(.leading, DEVICE_WIDTH*0.05)
        }
    }
}
