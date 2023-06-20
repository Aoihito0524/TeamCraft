//
//  SearchField.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/20.
//

import SwiftUI

struct SearchField: View{
    @Binding var searchText: String
    let DoSearch: () -> ()
    var body: some View{
        HStack{
            Image(systemName: "magnifyingglass")
            TextField("検索", text: $searchText)
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidHideNotification)) { _ in
                    DoSearch()
                }
        }
        .background(Color(red: 0.9, green: 0.9, blue: 0.9))
        .cornerRadius(10)
    }
}
