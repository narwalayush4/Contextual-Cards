//
//  CtaView.swift
//  Contextual Cards
//
//  Created by Ayush Narwal on 04/02/24.
//

import SwiftUI

struct CtaView: View {
    
    @StateObject var vm: ViewModel
    
    var body: some View {
        Button {
            if let url = URL(string: (vm.card.cta?[0].url) ?? "") {
                UIApplication.shared.open(url)
            }
        } label: {
            Text(vm.card.cta?[0].text ?? "title")
                .foregroundStyle(Color(uiColor: ColorHelper.shared.color(from: vm.card.cta?[0].textColor)))
                .padding(10)
                .background(Color(uiColor: ColorHelper.shared.color(from: vm.card.cta?[0].bgColor)))
                .cornerRadius(10)
        }

    }
    
}

#Preview {
    CtaView(vm: CtaView.ViewModel(card: Card.shared))
}

extension CtaView {
    
    class ViewModel: ObservableObject {
        let card: Card
        
        init(card: Card) {
            self.card = card
        }
    }
}
