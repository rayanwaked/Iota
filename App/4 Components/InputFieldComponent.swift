//
//  InputFieldComponent.swift
//  Skyliner
//
//  Created by Rayan Waked on 6/23/25.
//

import SwiftUI

// MARK: - VIEW
struct InputFieldComponent: View {
    // MARK: - PROPERTIES
    var searchBar: Bool = false
    var secure: Bool = false
    var icon: Image
    var title: String
    @Binding var text: String
    @FocusState private var isFocused: Bool
    
    private var inputOpacity: Color {
        if #available(iOS 26.0, *) {
            return .gray.opacity(Opacity.dark * 1.15)
        } else {
            return .gray.opacity(Opacity.standard)
        }
    }
    
    // MARK: - BODY
    var body: some View {
        Button(action: {
            isFocused = true
            hapticFeedback(.soft)
        }) {
            inputField
        }
        .buttonStyle(.plain)
    }
}

// MARK: - TEXT FIELD
extension InputFieldComponent {
    var inputField: some View {
        HStack {
            icon
                .foregroundStyle(.secondary)
                .frame(width: 24, height: 24)
            if secure {
                SecureField(title, text: $text)
                    .focused($isFocused)
            } else {
                TextField(title, text: $text)
                    .focused($isFocused)
            }
        }
        .padding()
        .frame(maxHeight: searchBar ? Screen.height * 0.06 : Screen.height * 0.06)
        .backport.glassEffect(
            .tintedAndInteractive(color: .clear, isEnabled: true),
            fallbackBackground: .thickMaterial
        )
        .background(searchBar ? .clear : inputOpacity)
        .clipShape(RoundedRectangle(cornerRadius: 100))
    }
}

// MARK: - PREVIEW
#Preview {
    ScrollView {
        VStack(spacing: 20) {
            // MARK: - STANDARD FIELDS
            VStack(spacing: 12) {
                Text("Standard Fields")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: 12) {
                    InputFieldComponent(
                        icon: Image(systemName: "at"),
                        title: "Email",
                        text: .constant("")
                    )
                    
                    InputFieldComponent(
                        icon: Image(systemName: "person"),
                        title: "Username",
                        text: .constant("")
                    )
                    
                    InputFieldComponent(
                        icon: Image(systemName: "phone"),
                        title: "Phone Number",
                        text: .constant("")
                    )
                }
            }
            
            // MARK: - SECURE FIELDS
            VStack(spacing: 12) {
                Text("Secure Fields")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: 12) {
                    InputFieldComponent(
                        secure: true,
                        icon: Image(systemName: "lock"),
                        title: "Password",
                        text: .constant("")
                    )
                    
                    InputFieldComponent(
                        secure: true,
                        icon: Image(systemName: "lock.fill"),
                        title: "Confirm Password",
                        text: .constant("")
                    )
                    
                    InputFieldComponent(
                        secure: true,
                        icon: Image(systemName: "key"),
                        title: "PIN",
                        text: .constant("")
                    )
                }
            }
            
            // MARK: - SEARCH BARS
            VStack(spacing: 12) {
                Text("Search Bars")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: 12) {
                    InputFieldComponent(
                        searchBar: true,
                        icon: Image(systemName: "magnifyingglass"),
                        title: "Search",
                        text: .constant("")
                    )
                    
                    InputFieldComponent(
                        searchBar: true,
                        icon: Image(systemName: "location"),
                        title: "Search Location",
                        text: .constant("")
                    )
                    
                    InputFieldComponent(
                        searchBar: true,
                        icon: Image(systemName: "doc.text.magnifyingglass"),
                        title: "Search Documents",
                        text: .constant("")
                    )
                }
            }
            
            // MARK: - VARIOUS ICONS
            VStack(spacing: 12) {
                Text("Various Icons")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: 12) {
                    InputFieldComponent(
                        icon: Image(systemName: "globe"),
                        title: "Website",
                        text: .constant("")
                    )
                    
                    InputFieldComponent(
                        icon: Image(systemName: "building.2"),
                        title: "Company",
                        text: .constant("")
                    )
                    
                    InputFieldComponent(
                        icon: Image(systemName: "location.circle"),
                        title: "Address",
                        text: .constant("")
                    )
                    
                    InputFieldComponent(
                        icon: Image(systemName: "calendar"),
                        title: "Date",
                        text: .constant("")
                    )
                    
                    InputFieldComponent(
                        icon: Image(systemName: "note.text"),
                        title: "Notes",
                        text: .constant("")
                    )
                }
            }
            
            // MARK: - WITH SAMPLE DATA
            VStack(spacing: 12) {
                Text("With Sample Data")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: 12) {
                    InputFieldComponent(
                        icon: Image(systemName: "person.fill"),
                        title: "Full Name",
                        text: .constant("John Doe")
                    )
                    
                    InputFieldComponent(
                        icon: Image(systemName: "envelope.fill"),
                        title: "Email Address",
                        text: .constant("john.doe@example.com")
                    )
                    
                    InputFieldComponent(
                        searchBar: true,
                        icon: Image(systemName: "magnifyingglass"),
                        title: "Search",
                        text: .constant("SwiftUI components")
                    )
                }
            }
        }
        .padding()
    }
}
