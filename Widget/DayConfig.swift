//
//  DayConfig.swift
//  WidgetApp
//
//  Created by Tatiana Simmer on 23/11/2023.
//

import Foundation

import SwiftUI

struct DayConfig {
    let backgroundColor: Color
    let quote: String
    let author: String

    static func determineConfig(from date: Date) -> DayConfig {
        let dayInt = Calendar.current.component(.weekday, from: date)

        switch dayInt {
        case 1:
            return DayConfig(
                backgroundColor: .orange,
                quote: "Happiness is a thing to be practiced, like the violin.",
                author: "John Lubbock"
            )
        case 2:
            return DayConfig(
                backgroundColor: .pink,
                quote: "Curiosity is one of the great secrets of happiness.",
                author: "Bryant H. McGill"
            )
        case 3:
            return DayConfig(
                backgroundColor: .purple,
                quote: "Don't let the fear of striking out hold you back.",
                author: "Babe Ruth"
            )
        case 4:
            return DayConfig(
                backgroundColor: .blue,
                quote: "The crown of life is neither happiness nor annihilation it is understanding.",
                author: "Winifred Holtby"
            )
        case 5:
            return DayConfig(
                backgroundColor: .mint,
                quote: "Happiness seems made to be shared.",
                author: "Pierre Corneille"
            )
        case 6:
            return DayConfig(
                backgroundColor: .green,
                quote: "Belief creates the actual fact.",
                author: "William James"
            )
        case 7:
            return DayConfig(
                backgroundColor: .teal,
                quote: "It is always the simple that produces the marvelous.",
                author: "Amelia Barr"
            )
        default:
            return DayConfig(
                backgroundColor: .gray,
                quote: "It not supposed to happen.",
                author: "Unknown"
            )
        }
    }
}
