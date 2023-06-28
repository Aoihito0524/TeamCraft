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
            FindView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
            TeamView()
                .tabItem {
                    Image(systemName: "rectangle.3.group.bubble.left")
                }
            MyAccountView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                }
            MailView()
                .tabItem {
                    Image(systemName: "envelope")
                }
        }
    }
}
