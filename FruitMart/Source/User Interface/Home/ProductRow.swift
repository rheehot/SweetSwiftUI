//
//  ProductRow.swift
//  FruitMart
//
//  Created by Joshua on 2020/05/09.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import SwiftUI

struct ProductRow: View {
    let product: Product

    var body: some View {
        HStack {
            productImage
            productDescription
        }
        .frame(height: 150)
        .background(Color.primary.colorInvert())
        .cornerRadius(6)
        .shadow(color: .primaryShadow, radius: 1, x: 2, y: 2)
        .padding(.vertical, 8)
    }
}


struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductRow(product: productSample[0])
    }
}

extension ProductRow {
    var productImage: some View {
        Image(self.product.imageName)
            .resizable()
            .scaledToFill()
            .frame(width: 140)
            .clipped()
    }

    var productDescription: some View {
        VStack {
            Text(self.product.name)
                .font(.headline)
                .fontWeight(.medium)
                .padding(.bottom, 6)

            Text(self.product.description)
                .font(.footnote)
                .foregroundColor(.secondaryText)

            Spacer()

            footerView
        }
    }

    var footerView: some View {
        HStack(spacing: 0) {
            Text("\(self.product.price)").font(.headline) + Text("원").font(.footnote)

            Spacer()

            Image(systemName: "heart")
                .imageScale(.large)
                .foregroundColor(.peach)
                .frame(width: 32, height: 32)
            Image(systemName: "cart")
                .foregroundColor(.peach)
                .frame(width: 32, height: 32)
        }
    }
}
