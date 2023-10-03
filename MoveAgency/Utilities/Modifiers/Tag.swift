//
//  Tag.swift
//  MoveAgency
//
//  Created by Max Versteeg on 29/09/2023.
//

import SwiftUI


struct TagModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(5)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.primary.opacity(0.1))
            }
    }
}
