//
//  RegisterUserNameButton.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/23.
//

import SwiftUI

struct RegisterUserNameField: View{
    @Binding var name: String
    var body: some View{
        TextField("名前を入力", text: $name)
            .textFieldStyle(.roundedBorder)
            .multilineTextAlignment(TextAlignment.center)
            .frame(width: DEVICE_WIDTH * 0.75)
            .padding(.bottom, DEVICE_HEIGHT * 0.08)
    }
}
