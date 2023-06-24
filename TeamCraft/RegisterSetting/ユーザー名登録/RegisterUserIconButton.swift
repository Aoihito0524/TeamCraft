//
//  RegisterUserIconButton.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/23.
//

import SwiftUI

struct RegisterUserIconButton: View{
    @ObservedObject var icon: ImageManager
    @State var isSelectingImage = false
    var body: some View{
        Button(action: {isSelectingImage = true}){
            UserIcon(size: DEVICE_WIDTH*0.5, IconImage: icon)
        }
        .sheet(isPresented: $isSelectingImage){
            ImagePicker(image: $icon.image)
        }
    }
}
