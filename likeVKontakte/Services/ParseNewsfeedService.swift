//
//  ParseNewsfeedService.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 07.08.2022.
//

import Foundation

//MARK: - Создает экземпляр новости
private func createNewsPost(items: [NewsPostItem], groups: [NewsPostGroup], profiles: [NewsPostProfile]) {
    var titlePhoto: String = ""
    var titleName: String = ""
    
    var bodyText: String = ""
    var bodyPhoto: String = ""
    
    var numberOfLikes: Int = 0
    
    for item in items {
        bodyText = item.text
        if item.source_id > 0 {
            for profile in profiles {
                if profile.id == item.source_id {
                    titleName = profile.firstName + profile.lastName
                    titlePhoto = profile.photo100
                }
            }
        } else {
            for group in groups {
                if group.id == abs(item.source_id) {
                    titleName = group.name
                    titlePhoto = group.photo100
                }
            }
        }
        if let attachment = item.attachments?[0].photo?.sizes[3].url {
            bodyPhoto = attachment
        }
        numberOfLikes = item.likes.count
        
        let newsPost = NewsPost(titlePhoto: titlePhoto, titleName: titleName, bodyText: bodyText, bodyPhoto: bodyPhoto, numberOfLikes: numberOfLikes)
        MyNewsPosts.shared.addNewsPost(newsPost: newsPost)
        titlePhoto = ""
        titleName = ""
        bodyText = ""
        bodyPhoto = ""
        numberOfLikes = 0
    }
}
// MARK: - Парсит декодированный из интернета JSON
func parseNewsfeed(token: String, user_id: String) {
    let service = VKService(token: token, user_id: user_id)
    service.getNewsPosts { result in
        switch result {
        case .success((let items, let groups, let profiles)):
            createNewsPost(items: items, groups: groups, profiles: profiles)
            print("Успешно загруженные новости")
        case .failure:
            print("Случилась ошибка в отгрузке новостей")
        }
    }
}

