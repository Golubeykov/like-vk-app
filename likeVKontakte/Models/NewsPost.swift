//
//  NewsPost.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 14.07.2022.
//

import Foundation

struct NewsPost: Equatable {
    var titlePhoto: String
    var titleName: String
    
    var bodyText: String
    var bodyPhoto: String
    
    var numberOfLikes: Int
}

extension NewsPost {
    static let testPosts = [NewsPost(titlePhoto: "thinkingCat", titleName: "Группа задумчивых котов", bodyText: "Это какой-то текст, чтобы проверить, что всё рабоает и текст отображается. Далее посмотрим, что будет.", bodyPhoto: "thinkingCat", numberOfLikes: 5), NewsPost(titlePhoto: "matilda", titleName: "Группа милых котов", bodyText: "Цикл while будет выполняться до тех пор, пока поток не получит команду cancel и его флаг не станет истинным. А внутри этого цикла запускается петля ровно на одну секунду. Затем она останавливается, и цикл проверяет, не было ли команды остановить поток. Если нет, петля будет запущена вновь.", bodyPhoto: "Lelik", numberOfLikes: 123), NewsPost(titlePhoto: "Misa", titleName: "Нет фотографии", bodyText: "Код выше создает RunLoop, если его нет, и запускает его. После этого петля событий оживит поток, и он никогда не закроется. ", bodyPhoto: "", numberOfLikes: 65)]
}
