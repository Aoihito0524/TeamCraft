//
//  CreateTitleTextField.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/20.
//

import SwiftUI

struct CreateTitleTextField: View{
    @Binding var titleText: String
    var body: some View{
        HStack{
            Text("タイトル")
            TextField("タイトルを入力", text: $titleText)
        }
    }
}
