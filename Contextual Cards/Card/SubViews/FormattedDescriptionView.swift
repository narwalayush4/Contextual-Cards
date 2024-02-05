//
//  FormattedDescriptionView.swift
//  Contextual Cards
//
//  Created by Ayush Narwal on 05/02/24.
//

import SwiftUI

struct FormattedDescriptionView: View {
    
    @StateObject var vm: ViewModel
    
    var body: some View {
        if vm.card?.formattedDescription != nil {
            VStack(alignment: .leading, spacing: 10){
                ForEach(vm.editedEntities.indices, id: \.self){ i in
                    Text(vm.editedEntities[i].text ?? "")
                        .foregroundStyle(Color(uiColor: ColorHelper.shared.color(from: vm.editedEntities[i].color)))
                        .font(.custom(vm.editedEntities[i].fontFamily ?? "met_semi_bold", size: CGFloat(vm.editedEntities[i].fontSize ?? 15)))
                        // TODO: ADD URL StrikeThrough AND UNDERLINE only available ios 16 onwards
                }
            }
            .background(.clear)
            .task {
                vm.splitStrings()
            }
        } else {
            Text(vm.card?.description ?? "")
        }
    }
}

#Preview {
    FormattedDescriptionView(vm: FormattedDescriptionView.ViewModel(card: Card.shared))
}


