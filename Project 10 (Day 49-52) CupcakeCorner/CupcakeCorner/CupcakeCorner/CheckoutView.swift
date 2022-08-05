//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Max Shu on 03.08.2022.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    @State private var conformationMessage = ""
    @State private var showingConfirmation = false
    
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("You total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                ZStack() {
                    VStack(alignment: .leading) {
                        Text("Order details:")
                            .font(.headline)
                            .frame(alignment: .topLeading)
                            Divider()
                        
                        Text("\(order.quantity) x \(Order.types[order.type]) cakes").bold()
                        if order.extraFrosting {
                            Text("*Add extra fosting").font(.subheadline)
                        }
                        if order.addSprinkles {
                            Text("*Add sprinkles").font(.subheadline)
                        }
                        Spacer()
                        Text("Delivery for: \(order.name)")
                        Text("Delivery address: \(order.streetAddress), \(order.city)")
                        
                    }
                }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.thickMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding()
                
                Button("Place order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle(("Check out"))
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank you", isPresented: $showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(conformationMessage)
        }
    }
    
    func placeOrder() async {
        // prepare data to send
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Fail to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            conformationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            print("Checkout failed.")
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
