//
//  ContentView.swift
//  Contextual Cards
//
//  Created by Ayush Narwal on 02/02/24.
//

import SwiftUI

struct ViewOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

struct ContextualCardsView: View {
    
    @StateObject var vm = ViewModel()
    
    
    var body: some View {
        ScrollView{
            VStack(spacing: 20){
                if vm.isCurrentlyRefreshing {
                    ProgressView()
                        .scaleEffect(1.5, anchor: .center)
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .padding(.bottom, 20)
                }
                if vm.showHC3CardsView && UserDefaults.standard.bool(forKey: "showHC3CardsView"){
                    HC3CardsView(bigDisplayCard: vm.bigDisplayCard, showHC3CardsView: $vm.showHC3CardsView)
                }
                HC6CardsView(smallCardWithArrow: vm.smallCardWithArrow)
                HC5CardsView(imageCard: vm.imageCard)
                HC9CardsView(dynamicWidthCard: vm.dynamicWidthCard)
                HC1CardsView(smallDisplayCard: vm.smallDisplayCard)
            }
            .overlay(GeometryReader { geo in
                let currentScrollViewPosition = -geo.frame(in: .global).origin.y
                
                if currentScrollViewPosition < -vm.amountToPullBeforeRefreshing && !vm.isCurrentlyRefreshing {
                    Color.clear.preference(key: ViewOffsetKey.self, value: -geo.frame(in: .global).origin.y)
                }
            })
        }
        .onPreferenceChange(ViewOffsetKey.self) { scrollPosition in
            if scrollPosition < -vm.amountToPullBeforeRefreshing && !vm.isCurrentlyRefreshing {
                vm.isCurrentlyRefreshing = true
                Task {
                    await vm.refreshAction()
                    await MainActor.run {
                        vm.isCurrentlyRefreshing = false
                    }
                }
            }
        }
        .task {
            await vm.fetchData()
        }
        .padding(.vertical)
        .background(Color.background.ignoresSafeArea())
    }
}

#Preview {
    ContextualCardsView()
}
