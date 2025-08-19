//
//  ArrayButtonComponent.swift
//  Skyliner
//
//  Created by Rayan Waked on 7/4/25.
//

import SwiftUI

// MARK: - VIEW
struct ArrayButtonComponent<T: Hashable, Content: View>: View {
    // MARK: - PROPERTIES
    let items: [T]
    let content: (T) -> Content
    let action: ((T) -> Void)?
    
    private var itemBackground: Color {
        if #available(iOS 26.0, *) {
            return .clear
        } else {
            return Color.orange.opacity(Opacity.light)
        }
    }
    
    // MARK: - BODY
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(items, id: \.self) { item in
                    content(item)
                        .padding(Padding.small)
                        .backport.glassEffect(
                            .tintedAndInteractive(
                                color: .orange.opacity(Opacity.light),
                                isEnabled: true
                            )
                        )
                        .background(itemBackground)
                        .clipShape(
                            RoundedRectangle(cornerRadius: Radius.standard)
                        )
                        .padding(.vertical, Padding.tiny / 1.3)
                        .hapticAction(.light) { action?(item) }
                }
            }
            .font(.smaller(.callout))
            .fontWeight(.semibold)
            .foregroundStyle(.primary)
            .padding(.horizontal, Padding.standard)
        }
        .padding(.top, Padding.tiny)
        .scrollIndicators(.hidden)
    }
}

// MARK: - PREVIEW
#Preview {
    ScrollView {
        VStack(spacing: 20) {
            // MARK: - STRING ARRAY
            VStack(spacing: 12) {
                Text("String Array")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ArrayButtonComponent(
                    items: ["Technology", "Design", "Science", "Art", "Music", "Sports"],
                    content: { Text($0) },
                    action: { print("Selected: \($0)") }
                )
            }
                 
            // MARK: - NUMBERS
            VStack(spacing: 12) {
                Text("Numbers")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ArrayButtonComponent(
                    items: Array(1...10),
                    content: { Text("\($0)") },
                    action: { print("Selected number: \($0)") }
                )
            }
            
            // MARK: - CUSTOM CONTENT
            VStack(spacing: 12) {
                Text("Custom Content")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ArrayButtonComponent(
                    items: ["star", "heart", "bookmark", "share", "message"],
                    content: { systemName in
                        HStack(spacing: 4) {
                            Image(systemName: "\(systemName).fill")
                            Text(systemName.capitalized)
                        }
                    },
                    action: { print("Selected icon: \($0)") }
                )
            }
            
            // MARK: - NO ACTION
            VStack(spacing: 12) {
                Text("Display Only (No Action)")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ArrayButtonComponent(
                    items: ["Read Only", "Display", "Info", "Status"],
                    content: { Text($0) },
                    action: nil
                )
            }
            
            // MARK: - LONG CONTENT
            VStack(spacing: 12) {
                Text("Long Content")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ArrayButtonComponent(
                    items: [
                        "Short",
                        "Medium Length",
                        "This is a longer item",
                        "Very long content that might wrap",
                        "Brief"
                    ],
                    content: { Text($0) },
                    action: { print("Selected: \($0)") }
                )
            }
        }
        .padding()
    }
}
