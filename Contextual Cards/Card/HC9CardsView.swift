//
//  HC9CardsView.swift
//  Contextual Cards
//
//  Created by Ayush Narwal on 05/02/24.
//

import SwiftUI

struct HC9CardsView: View {
    
    var dynamicWidthCard: HcGroup?
    @State var image: UIImage?
    
    var body: some View {
        
        if let hc9group = dynamicWidthCard
        {
            ScrollView(.horizontal){
                HStack(spacing: 20) {
                    ForEach(hc9group.cards, id: \.self) { card in
                        ZStack{
//                            Image(uiImage: UIImage(urlString: card.bgImage?.imageURL) ?? UIImage())
                            Image(uiImage: image ?? UIImage())
                                .task {
                                    await image = UIImage(urlString: card.bgImage?.imageURL)
                                }
                            RoundedRectangle(cornerRadius: 15.0)
                                .frame(height: CGFloat(integerLiteral: hc9group.height ?? 195))
                                .aspectRatio(CGFloat(card.bgImage?.aspectRatio ?? 0.7), contentMode: .fit)
                                .foregroundStyle(LinearGradient(colors: [Color(uiColor: ColorHelper.shared.color(from: card.bgGradient?.colors[0])),
                                                                         Color(uiColor: ColorHelper.shared.color(from: card.bgGradient?.colors[1]))],
                                                                startPoint: .bottomTrailing, endPoint: .topLeading))
                        }
                        .onTapGesture {
                            if let url = URL(string: card.url ?? "") {
                                UIApplication.shared.open(url)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    HC9CardsView(dynamicWidthCard: ContextualCardsView().vm.dynamicWidthCard)
}
