//
//  FormattedDescriptionVM.swift
//  Contextual Cards
//
//  Created by Ayush Narwal on 05/02/24.
//

import Foundation

extension FormattedDescriptionView {
    
    class ViewModel: ObservableObject {
        
        @Published var card: Card?
        @Published var editedEntities: [Entity] = []
        @Published var currentIndex: Int = 0
        
        init(card: Card?) {
            self.card = card
        }
        
        func splitStrings() {
            if let formattedText = card?.formattedDescription {
                let separatedStrings = formattedText.text.components(separatedBy: "\n")
                for i in separatedStrings.indices {
                    if separatedStrings[i] == "{}" || separatedStrings[i] == " " {
                        editedEntities.append(formattedText.entities[currentIndex])
                        currentIndex += 1
                    } else {
                        let tempEntity = Entity(text: separatedStrings[i], type: .genericText, color: nil, fontStyle: nil, fontFamily: nil, fontSize: nil)
                        editedEntities.append(tempEntity)
                    }
                }
            }
        }
        
    }
}
