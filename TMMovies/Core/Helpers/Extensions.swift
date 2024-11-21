//
//  File.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/9/24.
//

import Foundation
import SwiftUI

extension Color {
    var toUIColor: UIColor {
        let env = EnvironmentValues()
        return  UIColor(
            cgColor: self.resolve(
                in: env
            ).cgColor
        )
    }
}

extension View {
    func customFont(
        _ font: Poppins = .semiBold,
        size: CGFloat = 18
    ) -> some View {
        self.font(
                .custom(font.rawValue, size: size)
            )
    }

    func customFont(
        _ font: Montserrat = .normal,
        size: CGFloat = 18
    ) -> some View {
        self.font(
                .custom(font.rawValue, size: size)
            )
    }
}

enum Poppins: String {
    case semiBold = "Poppins-SemiBold"
    case medium = "Poppins-Medium"
    case regular = "Poppins-Regular"
}

enum Montserrat: String {
    case normal = "Montserrat-VariableFont_wght"
}
