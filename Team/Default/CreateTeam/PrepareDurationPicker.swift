//
//  PrepareDurationPicker.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/20.
//

import SwiftUI

struct PrepareDurationPicker: View{
    @Binding var prepareDays: Int
    let selections = Array(1...30)
    var body: some View{
        HStack{
            Text("準備期間")
            Picker("人数", selection: $prepareDays) {
                ForEach(selections, id: \.self) { i in
                    Text("\(i)日")
                }
            }
        }
    }
}
