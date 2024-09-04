//
//  WidgetExLiveActivity.swift
//  WidgetEx
//
//  Created by BH on 9/4/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct WidgetExAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct WidgetExLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: WidgetExAttributes.self) { context in
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

extension WidgetExAttributes {
    fileprivate static var preview: WidgetExAttributes {
        WidgetExAttributes(name: "World")
    }
}

extension WidgetExAttributes.ContentState {
    fileprivate static var smiley: WidgetExAttributes.ContentState {
        WidgetExAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: WidgetExAttributes.ContentState {
         WidgetExAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: WidgetExAttributes.preview) {
   WidgetExLiveActivity()
} contentStates: {
    WidgetExAttributes.ContentState.smiley
    WidgetExAttributes.ContentState.starEyes
}
