//
//  SearchView.swift
//  GitHubSearcherSwiftUI
//
//  Created by Artem Karmaz on 08.06.2019.
//  Copyright © 2019 Artem Karmaz. All rights reserved.
//

import SwiftUI

struct SearchView : View {
    
    // Здесь у нас есть поле запроса, которое помечено как @State . Это означает, что это представление является производным от этого состояния, и как только состояние изменяется, SwiftUI перестраивает представление. SwiftUI использует алгоритм сравнения , чтобы понимать изменения и обновлять только соответствующие представления. SwiftUI сохраняет все поля, помеченные как @State, в специальной разделенной памяти, где только соответствующий вид может получить к ним доступ и обновить их. @State - это новая функция Swift, которая называется Property Wrapper
    
    @State private var query: String = "Swift"
    
    // Еще один интересный факт - @EnvironmentObject . Это часть функции под названием Окружающая среда . Вы можете заполнить свою среду всеми необходимыми классами обслуживания, а затем получить к ним доступ из любого представления в этой среде . Среда является правильным способом Dependency Injection с SwiftUI .
    @EnvironmentObject var repoStore: ReposStore
    
    // Основное различие между @State и @EnvironmentObject заключается в том, что @State доступен только для определенного представления, в противоположность @EnvironmentObject, доступному для каждого представления в среде. Но оба они используются SwiftUI для отслеживания изменений и восстановления представлений, как только они появляются.
    
    var body: some View {
        
        NavigationView {
            List {
                //Интересным аспектом является использование $ query. Это значит получить ссылку на оболочку свойства, а не само значение. Мы используем его для подключенияTextField и переменная запроса в двухстороннем связывании.
                TextField($query, placeholder: Text("type something..."), onCommit: fetch)
                ForEach(repoStore.repos) { repo in
                    RepoRow(repo: repo)
                }
                }.navigationBarTitle(Text("Search"))
            }.onAppear(perform: fetch)
    }
    
    private func fetch() {
        repoStore.fetch(matching: query)
    }
}

#if DEBUG
struct SearchView_Previews : PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
#endif
