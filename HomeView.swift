//
//  HomeView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/10.
//

import SwiftUI

struct HomeView: View{
    var body: some View{
        TabView{
            FindView() //1枚目の子ビュー
                .tabItem {
                    Image(systemName: "magnifyingglass") //タブバーの①
                }
            TeamView() //2枚目の子ビュー
                .tabItem {
                    Image(systemName: "rectangle.3.group.bubble.left") //タブバーの②
                }
            MyAccountView() //2枚目の子ビュー
                .tabItem {
                    Image(systemName: "person.crop.circle") //タブバーの②
                }
            MailView() //2枚目の子ビュー
                .tabItem {
                    Image(systemName: "envelope") //タブバーの②
                }
        }
    }
}
