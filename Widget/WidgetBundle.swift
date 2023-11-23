//
//  WidgetBundle.swift
//  Widget
//
//  Created by Tatiana Simmer on 23/11/2023.
//

import WidgetKit
import SwiftUI

@main
struct DailyWidgetBundle: WidgetBundle {
    var body: some Widget {
        DailyWidget()
        DailyWidgetLiveActivity()
    }
}
