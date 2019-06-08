//
//  ReposStore.swift
//  GitHubSearcherSwiftUI
//
//  Created by Artem Karmaz on 08.06.2019.
//  Copyright © 2019 Artem Karmaz. All rights reserved.
//

import SwiftUI
import Combine

// Класс ReposStore должен соответствовать протоколу BindableObject , для которого требуется свойство didChange . Это позволяет использовать его в среде и перестроить представление, как только оно изменится. Свойство didChange должно быть Publisher , которое является частью новой инфраструктуры Apple Reactive, называемой Combine . Основная цель Publisher - уведомлять всех подписчиков, когда что-то меняется. Вот почему в didSet нашего массива репо мы сообщаем нашим подписчикам, что данные изменились. Как только появятся новые значения, SwiftUI перестроит ReposView .

class ReposStore: BindableObject {
    
    var repos: [Repo] = [] {
        didSet {
            didChange.send(self)
        }
    }
    
    var didChange = PassthroughSubject<ReposStore, Never>()
    
    let service: GithubService
    init(service: GithubService) {
        self.service = service
    }
    
    func fetch(matching query: String) {
        service.search(matching: query) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let repos): self?.repos = repos
                case .failure: self?.repos = []
                }
            }
        }
    }
}

//#if DEBUG
//struct ReposStore_Previews : PreviewProvider {
//    static var previews: some View {
//        ReposStore()
//    }
//}
//#endif
