//
//  Widget.swift
//  Widget
//
//  Created by Tatiana Simmer on 23/11/2023.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    // Dummy widget
    func placeholder(in context: Context) -> DayEntry {
        DayEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> DayEntry {
        DayEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<DayEntry> {
        var entries: [DayEntry] = []

        // Generate a timeline consisting of 7 entries 1 day apart, starting from the current date at midnight.
        let currentDate = Date()
        for dayOffset in 0 ..< 7 {
            let entryDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: currentDate)!
            let startOfDate = Calendar.current.startOfDay(for: entryDate)
            let entry = DayEntry(date: startOfDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd) // Update after 24 hours
//        return Timeline(entries: entries, policy: .after) // Update after midnight
    }
}

struct DayEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent

}

struct DailyWidgetEntryView : View {
    var entry: DayEntry
    var config: DayConfig

    init(entry: DayEntry) {
        self.entry = entry
        self.config = DayConfig.determineConfig(from: entry.date)
    }

    var body: some View {
        ZStack {
            ContainerRelativeShape()
                .fill(config.backgroundColor.gradient)
                .padding(.horizontal, -16)
                .padding(.vertical, -8)

            VStack(spacing: 0) {
                Text(entry.date.weekdayDisplayFormat)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.black.opacity(0.7))
                        .minimumScaleFactor(0.7) // Reduce the text length if too long so that it fits in one line

                Image(systemName: "quote.opening")
                    .foregroundColor(.white)
                    .padding(.top, 4)
                    .padding(.bottom, -8)

                ZStack {
                    Text(entry.date.dayDisplayFormat)
                        .font(.system(size: 70, weight: .heavy))
                        .fontWeight(.bold)
                        .foregroundColor(.black.opacity(0.1))

                    Text(config.quote)
                        .font(.system(size: 10))
                        .foregroundColor(.white)
                        .padding(-18)
                }
                Text("-\(config.author)")
                .font(.system(size: 10))
                .foregroundColor(.white)
                .padding(.top, -4)
            }
            .padding()
        }
    }
}

struct DailyWidget: Widget {
    let kind: String = "DailyWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            DailyWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Daily Quote Widget")
        .description("The widget provides a different quote and colour every day of the week.")
        .supportedFamilies([.systemSmall])
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

extension Date {
    var weekdayDisplayFormat: String {
        self.formatted(.dateTime.weekday(.wide))
    }
    var dayDisplayFormat: String {
        self.formatted(.dateTime.day())
    }
}

#Preview(as: .systemSmall) {
    DailyWidget()
} timeline: {
    DayEntry(date: .now, configuration: .smiley)
    DayEntry(date: .distantPast, configuration: .starEyes)
}


extension Color {
    static let orange = Color(.orange)
    static let pink = Color(.pink)
    static let purple = Color(.purple)
    static let blue = Color(.blue)
    static let mint = Color(.mint)
    static let green = Color(.green)
    static let teal = Color(.teal)
}
