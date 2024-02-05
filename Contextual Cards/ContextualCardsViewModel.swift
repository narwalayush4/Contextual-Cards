//
//  ContextualCardsViewModel.swift
//  Contextual Cards
//
//  Created by Ayush Narwal on 03/02/24.
//

import Foundation
import UIKit
import Combine
import SwiftUI

extension ContextualCardsView {
    
    class ViewModel: ObservableObject {
        
        @Published var networkManager = NetworkManager()
        @Published var hcGroup : [HcGroup] = []
        @Published var smallDisplayCard : HcGroup?
        @Published var bigDisplayCard : HcGroup?
        @Published var imageCard : HcGroup?
        @Published var smallCardWithArrow : HcGroup?
        @Published var dynamicWidthCard : HcGroup?
        @Published var showHC3CardsView = true
        
        @Environment(\.refresh) private var refresh
        @Published var isCurrentlyRefreshing = false
        let amountToPullBeforeRefreshing: CGFloat = 180
        
        
        func fetchData() async {
            do {
                try await networkManager.fetchData {
                    self.initializeValues()
                    debugPrint("completion handler run")
                }
                
            } catch {
                print("Error fetching data: \(error)")
            }
        }
        
        func initializeValues() {
            self.hcGroup = networkManager.wcElement?.hcGroups ?? []
            self.smallDisplayCard = hcGroup.first(where: { $0.designType == DesignType.smallDisplayCard})
            self.bigDisplayCard = hcGroup.first(where: { $0.designType == DesignType.bigDisplayCard})
            self.imageCard = hcGroup.first(where: { $0.designType == DesignType.imageCard})
            self.smallCardWithArrow = hcGroup.first(where: { $0.designType == DesignType.smallCardWithArrow})
            self.dynamicWidthCard = hcGroup.first(where: { $0.designType == DesignType.dynamicWidthCard})
        }
        
        func refreshAction() async {
            await fetchData()
            debugPrint("refresh action run")
        }
    }
}
