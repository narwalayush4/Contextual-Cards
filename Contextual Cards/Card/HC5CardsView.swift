//
//  HC5CardsView.swift
//  Contextual Cards
//
//  Created by Ayush Narwal on 05/02/24.
//

import SwiftUI

struct HC5CardsView: View {

    var imageCard: HcGroup?
    @State var image : [Int: UIImage] = [:]
    
    
    var body: some View {
        if let hc5group = imageCard
        {
            if hc5group.cards.count == 1 || !hc5group.isScrollable
            {
                HStack(spacing: 20) {
                    ForEach(hc5group.cards, id: \.self) { card in
                        Image(uiImage: image[card.id] ?? UIImage())
                            .resizable()
                            .aspectRatio(card.bgImage?.aspectRatio ?? 1, contentMode: .fit)
                            .task {
                                await image[card.id] = UIImage(urlString: card.bgImage?.imageURL)
                            }
                            .onTapGesture {
                                if let url = URL(string: card.url ?? "") {UIApplication.shared.open(url)}
                            }
                    }
                }
                .padding(.horizontal)
            }
            else
            {
                ScrollView(.horizontal){
                    HStack(spacing: 20) {
                        ForEach(hc5group.cards, id: \.self) { card in
                            Image(uiImage: image[card.id] ?? UIImage())
                                .resizable()
                                .aspectRatio(card.bgImage?.aspectRatio ?? 1, contentMode: .fit)
                                .task {
                                    await image[card.id] = UIImage(urlString: card.bgImage?.imageURL)
                                }
                                .onTapGesture {
                                    if let url = URL(string: card.url ?? "") {UIApplication.shared.open(url)}
                                }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    HC5CardsView(imageCard: ContextualCardsView().vm.imageCard)
}

    

