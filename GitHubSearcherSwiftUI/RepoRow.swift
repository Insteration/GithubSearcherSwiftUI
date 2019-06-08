//
//  RepoRow.swift
//  GitHubSearcherSwiftUI
//
//  Created by Artem Karmaz on 08.06.2019.
//  Copyright © 2019 Artem Karmaz. All rights reserved.
//

import SwiftUI

struct RepoRow : View {
    
    let repo: Repo
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(repo.name)
                .font(.headline)
            Text(repo.description)
                .font(.subheadline)
        }
    }
}

//#if DEBUG
//struct RepoRow_Previews : PreviewProvider {
//    static var previews: some View {
//        RepoRow()
//    }
//}
//#endif
