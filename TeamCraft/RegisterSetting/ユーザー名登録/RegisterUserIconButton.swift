//
//  RegisterUserIconButton.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/23.
//

import SwiftUI

struct RegisterUserIconButton: View{
    @ObservedObject var userIcon: ImageManager
    @State var isSelectingImage = false
    var body: some View{
        Button(action: {isSelectingImage = true}){
            UserIcon(size: DEVICE_WIDTH*0.5)
        }
        .sheet(isPresented: $isSelectingImage){
            ImagePicker(image: $userIcon.image)
        }
    }
}
