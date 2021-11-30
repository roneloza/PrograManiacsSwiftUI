//
//  SearchBar.swift
//  BeerSearch
//
//  Created by Rone Shender on 18/11/21.
//

import SwiftUI

@available(iOS 14.0, *)
public struct SearchBar: View {
    
    @Binding public var text: String
    @State private var isEditing = false
    
    public var body: some View {
        HStack {
            TextField("Search", text: $text)
                .accessibilityIdentifier("searchTextField")
                .accessibilityLabel("searchTextField")
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        if isEditing {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                            .accessibilityLabel("searchClearButton")
                            .accessibilityIdentifier("searchClearButton")
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    Text("Cancel")
                }
                .accessibilityLabel("searchCancelButton")
                .accessibilityIdentifier("searchCancelButton")
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
    }
    
    public init(text: Binding<String>) {
        self._text = text
    }
    
}
