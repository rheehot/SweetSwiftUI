//
//  ProductRow.swift
//  FruitMart
//
//  Created by Joshua on 2020/05/09.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import SwiftUI

struct ProductRow: View {
    @EnvironmentObject var store: Store
    let product: Product
    @Binding var quickOrder: Product?
    @State private var willAppear: Bool = false

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
        .opacity(willAppear ? 1 : 0)
        .animation(.easeInOut(duration: 0.4))
        .onAppear { self.willAppear = true }
        .contextMenu { contextMenu }
    }
}


struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(productSample) {
                ProductRow(product: $0, quickOrder: .constant(nil))
            }
            ProductRow(product: productSample[0], quickOrder: .constant(nil))
            .preferredColorScheme(.dark)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}

extension ProductRow {
    var productImage: some View {
        ResizedImage(imageName: self.product.imageName)
            .frame(width: 140)
            .clipped()
    }

    var productDescription: some View {
        VStack(alignment: .leading) {
            Text(self.product.name)
                .font(.headline)
                .fontWeight(.medium)
                .padding(.bottom, 6)

            Text(self.product.description)
                .font(.footnote)
                .foregroundColor(.secondaryText)

            Spacer()

            footerView
            }.padding()
        .frame(height: 150)
    }

    var footerView: some View {
        HStack(spacing: 0) {
            Text("\(self.product.price)").font(.headline) + Text("원").font(.footnote)

            Spacer()

            FavoriteButton(product: product)
            Symbol("cart", color: .peach)
                .frame(width: 32, height: 32)
                .onTapGesture { self.orderProduct() }
        }
    }

    var contextMenu: some View {
        VStack {
            Button(action: { self.toggleFavorite() }) {
                Text("Toggle Favorite")
                Symbol(self.product.isFavorite ? "heart.fill" : "heart")
            }
            Button(action: { self.orderProduct() }) {
                Text("Order Product")
                Symbol("cart")
            }
        }
    }

    func orderProduct() {
        quickOrder = product
        store.placeOrder(product: product, quantity: 1)
    }

    func toggleFavorite() {
        store.toggleFavorite(of: product)
    }
}
