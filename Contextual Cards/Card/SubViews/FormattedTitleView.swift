//
//  FormattedTextView.swift
//  Contextual Cards
//
//  Created by Ayush Narwal on 04/02/24.
//

import SwiftUI

struct FormattedTitleView: View {
    
    @StateObject var vm: ViewModel

    
    var body: some View {
        if vm.card?.formattedTitle != nil {
            VStack(alignment: .leading, spacing: 10){
                ForEach(vm.editedEntities.indices, id: \.self){ i in
                    Text(vm.editedEntities[i].text ?? "")
                        .underline(vm.editedEntities[i].fontStyle == "underline", color: Color(uiColor: ColorHelper.shared.color(from: vm.editedEntities[i].color)))
                        .strikethrough(vm.editedEntities[i].fontStyle == "strikethrough", color: Color(uiColor: ColorHelper.shared.color(from: vm.editedEntities[i].color)))
                        .font(.custom(vm.editedEntities[i].fontFamily ?? "met_semi_bold", size: CGFloat(vm.editedEntities[i].fontSize ?? 15)))
                        .foregroundStyle(Color(uiColor: ColorHelper.shared.color(from: vm.editedEntities[i].color)))
                }
            }
            .background(.clear)
            .task {
                vm.splitStrings()
            }
        } else {
            Text(vm.card?.title ?? "")
        }
    }
}

#Preview {
    return FormattedTitleView(vm: FormattedTitleView.ViewModel(card: Card.shared)).background(.black)
}


