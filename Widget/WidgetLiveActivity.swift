//
//  WidgetLiveActivity.swift
//  Widget
//
//  Created by Tatiana Simmer on 23/11/2023.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct DailyWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct DailyWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DailyWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension DailyWidgetAttributes {
    fileprivate static var preview: DailyWidgetAttributes {
        DailyWidgetAttributes(name: "World")
    }
}

extension DailyWidgetAttributes.ContentState {
    fileprivate static var smiley: DailyWidgetAttributes.ContentState {
        DailyWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: DailyWidgetAttributes.ContentState {
         DailyWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: DailyWidgetAttributes.preview) {
   DailyWidgetLiveActivity()
} contentStates: {
    DailyWidgetAttributes.ContentState.smiley
    DailyWidgetAttributes.ContentState.starEyes
}
