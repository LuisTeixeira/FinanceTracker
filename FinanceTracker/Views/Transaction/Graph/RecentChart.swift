//
//  RecentChart.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 15.02.23.
//

import SwiftUI
import Charts

struct RecentChart: View {
    var entries: [GraphEntry]
    
    var body: some View {
        Chart {
            ForEach(entries, id: \.date) { entry in
                BarMark(
                    x: .value("Date", entry.date.formatted(.dateTime.day().month(.twoDigits).year())),
                    y: .value("Value", entry.value)
                ).foregroundStyle(entry.value < 0 ? Color.expense : Color.income)
            }
        }
        .chartYAxis(.hidden)
        .chartOverlay { proxy in
            GeometryReader { geometry in
                Rectangle().fill(.clear).contentShape(Rectangle())
                    .gesture(
                        DragGesture()
                            .onChanged{value in
                                let origin = geometry[proxy.plotAreaFrame].origin
                                let location = CGPoint(
                                    x: value.location.x - origin.x,
                                    y: value.location.y - origin.y
                                )
                                let (date, total) = proxy.value(at: location, as: (String, Double).self) ?? ("", 0.0)
                                print("Location \(date) \(total)")
                            }
                    )
            }
        }
    }
}

struct GraphEntry {
    var date: Date
    var value: Double
}

