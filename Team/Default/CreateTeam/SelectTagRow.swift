//
//  SelectTagRow.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/20.
//

import SwiftUI

struct SelectTagRow: View{
    @Binding var tagGroup: TagGroup
    var body: some View{
        HStack{
            Text("タグ")
            ForEach(tagGroup.tags){ tag in
                HStack{
                    TagLabel(tag: tag)
                }
            }
            NavigationLink{
                SelectTagView(selectedTagsGroup: $tagGroup)
            } label: {
                Text("+タグを選ぶ")
            }
            Spacer()
        }
    }
}
