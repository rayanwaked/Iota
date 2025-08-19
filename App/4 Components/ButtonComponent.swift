//
//  ButtonComponent.swift
//  Skyliner
//
//  Created by Rayan Waked on 6/22/25.
//

import SwiftUI

// MARK: - CONFIGURATION
struct ButtonConfig {
    // MARK: - VARIATION
    enum Variation {
        case primary, secondary, tertiary, quaternary
        
        var backgroundColor: Color {
            switch self {
            case .primary: .orange.opacity(0.8)
            case .secondary: .orange.opacity(Opacity.standard)
            case .tertiary: .clear
            case .quaternary: .standardBackground
            }
        }
        
        var foregroundColor: Color {
            self == .primary ? .white : .orange
        }
        
        var borderWidth: CGFloat {
            self == .tertiary ? 2 : 0
        }
    }
    
    // MARK: - SIZE
    enum Size {
        case compact, inline, standard, tabBar, header, compose, profile
        
        var font: Font {
            switch self {
            case .compact, .standard, .profile: .smaller(.subheadline)
            case .inline: .smaller(.caption)
            case .tabBar, .header: .smaller(.title3)
            case .compose: .smaller(.footnote)
            }
        }
        
        var padding: CGFloat {
            switch self {
            case .compact: Padding.standard * 0.9
            case .inline: Padding.standard * 0.70
            case .standard: Padding.standard
            case .tabBar: Padding.standard * 0.95
            case .header: Padding.standard * 0.50
            case .compose: Padding.standard * 1.10
            case .profile: Padding.standard * 0.90
            }
        }
    }
}

// MARK: - COMPONENT
struct ButtonComponent<Label: View>: View {
    let content: Label
    let variation: ButtonConfig.Variation
    let size: ButtonConfig.Size
    let haptic: HapticType
    let action: () -> Void
    
    // MARK: - BODY
    var body: some View {
        Button {
            action()
            hapticFeedback(haptic)
        } label: {
            content
                .font(size.font)
                .fontWeight(.semibold)
                .foregroundStyle(variation.foregroundColor)
                .padding(size.padding)
                .padding(.vertical, size == .profile ? -Padding.tiny : 0)
                .frame(maxWidth: size == .standard ? .infinity : nil)
                .frame(maxHeight: size == .standard ? Screen.height * 0.055 : nil)
                .background {
                    RoundedRectangle(cornerRadius: 100)
                        .fill(variation.backgroundColor)
                        .overlay {
                            if variation.borderWidth > 0 {
                                RoundedRectangle(cornerRadius: 100)
                                    .strokeBorder(Color.orange, lineWidth: variation.borderWidth)
                            }
                        }
                }
        }
        .backport.glassEffect(.interactive(isEnabled: true))
        .fixedSize(horizontal: size != .standard, vertical: false)
    }
}

// MARK: - CONVENIENCE EXTENSIONS
extension ButtonComponent where Label == Text {
    init(
        _ text: String,
        variation: ButtonConfig.Variation = .primary,
        size: ButtonConfig.Size = .standard,
        haptic: HapticType = .medium,
        action: @escaping () -> Void
    ) {
        self.content = Text(text)
        self.variation = variation
        self.size = size
        self.haptic = haptic
        self.action = action
    }
}

extension ButtonComponent where Label == Image {
    init(
        systemName: String,
        variation: ButtonConfig.Variation = .primary,
        size: ButtonConfig.Size = .compact,
        haptic: HapticType = .medium,
        action: @escaping () -> Void
    ) {
        self.content = Image(systemName: systemName)
        self.variation = variation
        self.size = size
        self.haptic = haptic
        self.action = action
    }
}

// MARK: - PREVIEW
#Preview {
    ScrollView {
        VStack(spacing: 20) {
            // MARK: - VARIATIONS
            Group {
                Text("Variations")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: 12) {
                    ButtonComponent("Primary", action: {})
                    ButtonComponent("Secondary", variation: .secondary, action: {})
                    ButtonComponent("Tertiary", variation: .tertiary, action: {})
                    ButtonComponent("Quaternary", variation: .quaternary, action: {})
                }
            }
            
            // MARK: - SIZES
            Group {
                Text("Sizes")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: 12) {
                    ButtonComponent("Standard", size: .standard, action: {})
                    
                    HStack(spacing: 12) {
                        ButtonComponent("Compact", size: .compact, action: {})
                        ButtonComponent("Inline", size: .inline, action: {})
                        ButtonComponent("Tab Bar", size: .tabBar, action: {})
                        Spacer()
                    }
                    
                    HStack(spacing: 12) {
                        ButtonComponent("Header", size: .header, action: {})
                        ButtonComponent("Compose", size: .compose, action: {})
                        ButtonComponent("Profile", size: .profile, action: {})
                        Spacer()
                    }
                }
            }
            
            // MARK: - ICONS
            Group {
                Text("Icons")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(spacing: 12) {
                    ButtonComponent(systemName: "star.fill", action: {})
                    ButtonComponent(systemName: "heart.fill", variation: .secondary, action: {})
                    ButtonComponent(systemName: "plus", variation: .tertiary, action: {})
                    ButtonComponent(systemName: "gear", variation: .quaternary, action: {})
                    Spacer()
                }
            }
        }
        .padding(Padding.standard)
    }
}

