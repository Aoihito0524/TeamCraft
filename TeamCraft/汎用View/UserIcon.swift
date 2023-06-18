//
//  UserIcon.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/18.
//

import SwiftUI

struct UserIcon: View{
    let size: CGFloat
    var body: some View{
        Image(systemName: "circle.fill")
            .resizable()
            .frame(width: size, height: size)
    }
}
