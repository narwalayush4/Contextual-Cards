//
//  HC3CardsView.swift
//  Contextual Cards
//
//  Created by Ayush Narwal on 04/02/24.
//

import SwiftUI

struct HC3CardsView: View {
    
    var bigDisplayCard: HcGroup?
    @State private var showActionCard = false
    @Binding var showHC3CardsView: Bool
    @State var image : [Int: UIImage] = [:]
    
    var body: some View {
        
        if let hc3group = bigDisplayCard {
            if hc3group.cards.count == 1 || !hc3group.isScrollable {
                ZStack{
                    HC3ActionView(showHC3CardsView: $showHC3CardsView)
                    HC3MainCardView(hc3group: hc3group, image: $image[bigDisplayCard?.cards[0].id ?? 1])
                        .offset(x: showActionCard ? (UIScreen.main.bounds.width * 0.45) : 0)
                        .task {
                            await image[bigDisplayCard?.cards[0].id ?? 1] = UIImage(urlString: bigDisplayCard?.cards[0].bgImage?.imageURL)
                        }
                        .gesture(longPressGesture)
                }
            }
            else {
                ScrollView(.horizontal){
                    HStack(spacing: 20) {
                        ForEach(hc3group.cards, id: \.self) { card in
                            RoundedRectangle(cornerRadius: 34)
                                .foregroundStyle(.purple)
                                .overlay {
                                    Text(card.title ?? "title")
                                        .foregroundStyle(.white)
                                }
                                .onTapGesture {
                                    if let url = URL(string: card.url ?? "") { UIApplication.shared.open(url) }
                                }
                        }
                    }
                }
            }
        }
    }
    
    var longPressGesture: some Gesture {
        LongPressGesture(minimumDuration: 0.5)
            .onEnded { _ in
                withAnimation {
                    showActionCard.toggle()
                }
            }
    }
}

#Preview {
    HC3CardsView(bigDisplayCard: ContextualCardsView().vm.bigDisplayCard, showHC3CardsView: .constant(true))
}

extension HC3CardsView {
    
    struct HC3MainCardView: View {
        
        var hc3group: HcGroup
        @Binding var image: UIImage?
        
        
        var body: some View {
            HStack(spacing: 20) {
                ForEach(hc3group.cards, id: \.self) { card in
                    ZStack{
                        Image(uiImage: image ?? UIImage())
                            .resizable()
                            .aspectRatio(hc3group.cards[0].bgImage?.aspectRatio ?? 0.9142857, contentMode: .fill)
                            .frame(height: 350)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        VStack(alignment: .leading){
                            if (card.formattedTitle?.entities) != nil {
                                Spacer().frame(height: 110)
                                FormattedTitleView(vm: FormattedTitleView.ViewModel(card: card))
                                Spacer().frame(height: 20)
                                CtaView(vm: CtaView.ViewModel(card: card))
                            }
                        }
                        .padding(.horizontal, 33)
                    }
                    .onTapGesture {
                        if let url = URL(string: card.url ?? "") { UIApplication.shared.open(url) }
                    }
                }
            }
            .padding(.horizontal, 20)
            
        }
    }
}
extension HC3CardsView {
    
    struct HC3ActionView: View {
        
        @Binding var showHC3CardsView: Bool
        
        var body: some View {
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.white)
                    .frame(height: 350)
                HStack{
                    VStack(alignment: .leading, spacing: 40){
                        Button(action: {
                            showHC3CardsView = false
                        }, label: {
                            VStack{
                                Image(.subtract)
                                    .resizable()
                                    .frame(width: 17.51 ,height: 20.24)
                                Text("remind\nlater")
                            }
                            .frame(width: 110 , height: 90)
                            .background(Color.background)
                            .cornerRadius(10)
                        })
                        Button(action: {
                            UserDefaults.standard.setValue(false, forKey: "showHC3CardsView")
                            showHC3CardsView = false
                        }, label: {
                            VStack{
                                Image(systemName: "x.circle.fill")
                                    .resizable()
                                    .frame(width: 18.15, height: 18.15)
                                    .foregroundStyle(.accent)
                                Text("dismiss\nnow")
                            }
                            .frame(width: 110 , height: 90)
                            .background(Color.background)
                            .cornerRadius(10)
                        })
                    }
                    .padding(.horizontal, 20)
                    .frame(width: UIScreen.main.bounds.width * 0.45)
                    Spacer()
                }
            }
            .padding(.horizontal, 20)
        }
    }
    
}
