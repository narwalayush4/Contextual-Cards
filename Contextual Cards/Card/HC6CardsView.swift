//
//  HC6CardsView.swift
//  Contextual Cards
//
//  Created by Ayush Narwal on 05/02/24.
//

import SwiftUI

struct HC6CardsView: View {
    
    var smallCardWithArrow: HcGroup?
    @State var image : [Int: UIImage] = [:]
    
    var body: some View {
        if let hc6group = smallCardWithArrow 
        {
            if hc6group.cards.count == 1 || !hc6group.isScrollable
            {
                HStack(spacing: 20) {
                    ForEach(hc6group.cards, id: \.self) { card in
                        HStack(alignment: .center, spacing: 20){
                            Image(uiImage: image[card.id] ?? UIImage())
                                .resizable()
                                .frame(width: 30, height: 30)
                                .task {
                                    await image[card.id] = UIImage(urlString: card.icon?.imageURL)
                                }
                            Text("Small card with an arrow")
                                .font(.custom("met_semi_bold", size: 20))
                            Spacer()
                            Image(systemName: "chevron.right")
                                .resizable()
                                .frame(width: 10, height: 16)
                        }
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 15.0)
                                .foregroundColor(Color(uiColor: ColorHelper.shared.color(from: card.bgColor)))
                        }
                        .onTapGesture {
                            if let url = URL(string: card.url ?? "") { UIApplication.shared.open(url) }
                        }
                    }
                }
                .padding(.horizontal)
            }
            else
            {
                ScrollView(.horizontal){
                    HStack(spacing: 20) {
                        ForEach(hc6group.cards, id: \.self) { card in
                            HStack(alignment: .center, spacing: 20){
                                Image(uiImage: image[card.id] ?? UIImage())
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .task {
                                        await image[card.id] = UIImage(urlString: card.icon?.imageURL)
                                    }
                                Text("Small card with an arrow")
                                    .fontWeight(.semibold)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .frame(width: 10, height: 16)
                            }
                            .padding()
                            .frame(width: .infinity, height: 60)
                            .background {
                                RoundedRectangle(cornerRadius: 15.0)
                                    .foregroundColor(Color(uiColor: ColorHelper.shared.color(from: card.bgColor)))
                            }
                            .onTapGesture {
                                if let url = URL(string: card.url ?? "") { UIApplication.shared.open(url) }
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
    HC6CardsView(smallCardWithArrow: ContextualCardsView().vm.smallCardWithArrow)
}
