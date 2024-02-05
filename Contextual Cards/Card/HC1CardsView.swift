//
//  HC1CardsView.swift
//  Contextual Cards
//
//  Created by Ayush Narwal on 05/02/24.
//

import SwiftUI

struct HC1CardsView: View {
    
    var smallDisplayCard: HcGroup?
    @State var image : [Int: UIImage] = [:]
    
    
    var body: some View {
        if let hc1group = smallDisplayCard
        {
            if hc1group.cards.count == 1 || !hc1group.isScrollable
            {
                HStack(spacing: 20) {
                    ForEach(hc1group.cards, id: \.self) { card in
                        HStack(alignment: .center, spacing: 20){
                            Image(uiImage: image[card.id] ?? UIImage())
                                .resizable()
                                .frame(width: 30, height: 30)
                                .task {
                                    await image[card.id] = UIImage(urlString: card.icon?.imageURL)
                                }
                            VStack{
                                FormattedTitleView(vm: FormattedTitleView.ViewModel(card: card))
                                FormattedDescriptionView(vm: FormattedDescriptionView.ViewModel(card: card))
                            }
                            Spacer()
                                .padding()
                        }
                        .cornerRadius(15.0)
                        .foregroundColor(Color(uiColor: ColorHelper.shared.color(from: card.bgColor)))
                        .onTapGesture {
                            if let url = URL(string: card.url ?? "") {
                                UIApplication.shared.open(url)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            else
            {
                ScrollView(.horizontal){
                    HStack(spacing: 20) {
                        ForEach(hc1group.cards, id: \.self) { card in
                            HStack(alignment: .center, spacing: 20){
                                Image(uiImage: image[card.id] ?? UIImage())
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .task {
                                        await image[card.id] = UIImage(urlString: card.icon?.imageURL)
                                    }
                                VStack{
                                    FormattedTitleView(vm: FormattedTitleView.ViewModel(card: card))
                                    FormattedDescriptionView(vm: FormattedDescriptionView.ViewModel(card: card))
                                }
                                Spacer()
                            }
                            .padding(.horizontal)
                            .frame(height: 60)
                            .background(Color(uiColor: ColorHelper.shared.color(from: card.bgColor)))
                            .cornerRadius(15.0)
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
    
}

#Preview {
    HC1CardsView(smallDisplayCard: ContextualCardsView().vm.smallDisplayCard)
}


    

