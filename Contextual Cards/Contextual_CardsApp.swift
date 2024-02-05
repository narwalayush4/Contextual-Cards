//
//  Contextual_CardsApp.swift
//  Contextual Cards
//
//  Created by Ayush Narwal on 02/02/24.
//

import SwiftUI

@main
struct Contextual_CardsApp: App {
    var body: some Scene {
        WindowGroup {
            ContextualCardsView()
                .onAppear(perform: {
                    if UserDefaults.standard.object(forKey: "showHC3CardsView") == nil {
                        UserDefaults.standard.setValue(true, forKey: "showHC3CardsView")
                    }
                })
        }
    }
}
