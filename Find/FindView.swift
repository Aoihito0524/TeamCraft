//
//  FindView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/10.
//

import SwiftUI
import FirebaseFirestore

struct FindView: View{
    @ObservedObject var findVM = FindViewModel()
    var body: some View{
        ZStack{
            Rectangle()
                .fill(BACKGROUND_COLOR)
                .ignoresSafeArea()
            VStack{
                HStack{
                    TextField("検索", text: $findVM.searchText)
                    Button("検索"){
                        findVM.Search()
                    }
                }
                ScrollView{
                    LazyVStack{
                        ForEach(findVM.searchResults){ teamInfo in
                            teamInformationUI(teamInfo: teamInfo, clickedTeamInfo: $findVM.clickedTeamInfo)
                        }
                        Divider()
                    }
                    .background(Color.white)
                }
            }
            if let clickedTeamInfo = findVM.clickedTeamInfo{
                JoinPopupView(teamInfo: clickedTeamInfo)
            }
        }
    }
}

struct teamInformationUI: View{
    let teamInfo: TeamInformation
    @Binding var clickedTeamInfo: TeamInformation?
    var body: some View{
        VStack{
            HStack{
                //タグ名横並び
                ForEach(teamInfo.tags.tags){tag in
                    TagLabel(tag: tag)
                }
                //その横にタイトル
                Text(teamInfo.title)
            }
            Text(teamInfo.description)
                .lineLimit(5)
        }
        .frame(width: DEVICE_WIDTH * 0.869, height: DEVICE_HEIGHT * 0.3)
        .onTapGesture{
            clickedTeamInfo = teamInfo
        }
    }
}

class FindViewModel: ObservableObject{
    @Published var searchText = ""
    @Published var searchResults = [TeamInformation]()
    @Published var clickedTeamInfo: TeamInformation?
    func Search(){
        let keywords = GetKeywords(input: searchText)
        if keywords == []{return;}
        SearchByKeywards(keywords: keywords)
    }
    private func GetKeywords(input: String) -> [String]{
        let pattern = "([^\\s　]+)"
        let regex = try? NSRegularExpression(pattern: pattern)
        let results = regex?.matches(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count)) ?? []
        var keywordsArray = [String]()
        for result in results{
            if let range = Range(result.range, in: input) {
                keywordsArray.append(String(input[range]))
            }
        }
        print("キーワード: \(keywordsArray)")
        return keywordsArray
    }
    private func SearchByKeywards(keywords: [String]){
        var keywords_2character = [String]()
        for keyword in keywords {
            for num in 0..<keyword.count-1{
                let fromIdx = keyword.index(keyword.startIndex, offsetBy: num)
                let toIdx = keyword.index(keyword.startIndex, offsetBy: num+1)
                let str = String(keyword[fromIdx...toIdx])
                keywords_2character.append(str)
            }
        }
        searchResults = []
        let db = Firestore.firestore()
        var query = db.collection("teamInformation").whereField("keywords", arrayContainsAny: keywords_2character)
        query = query.limit(to: 100) //100件まで
        query.getDocuments {(snapshot, error) in
            if let documents = snapshot?.documents{
                print("\(documents.count)件ヒットしました")
                for document in documents {
                    self.searchResults.append(TeamInformation(document: document))
                }
            }
            else{
                print("documentsがnilです")
            }
        }
    }
}
