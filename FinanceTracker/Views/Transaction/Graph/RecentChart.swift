//
//  RecentChart.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 15.02.23.
//

import SwiftUI
import Charts

struct RecentChart: View {
    @ObservedObject var viewModel: RecentChartViewModel
    @State var selectedValue: Double = .zero

    var body: some View {
        
        if !viewModel.graphEntries.isEmpty {
            
            VStack(alignment: .leading, spacing: 12) {
                let value = selectedValue == 0 ? viewModel.total : selectedValue
                Text("\(value.asCurrency)")
                    .font(.largeTitle.bold())
                    .foregroundColor(value < 0 ? Color.expense : Color.income)
            
                Chart {
                    ForEach(viewModel.graphEntries, id: \.date) { entry in
                        BarMark(
                            x: .value("Date", entry.date.formatted(.dateTime.day().month(.twoDigits).year())),
                            y: .value("Value", entry.animate ? entry.value : 0)
                        )
                        .foregroundStyle(entry.value < 0 ? Color.expense : Color.income)
                    }
                }
                .chartYAxis(.hidden)
                .chartXAxis(.hidden)
                .chartOverlay { proxy in
                    GeometryReader { geometry in
                        Rectangle().fill(.clear).contentShape(Rectangle())
                            .gesture(
                                DragGesture()
                                    .onChanged{value in
                                        let origin = geometry[proxy.plotAreaFrame].origin
                                        let location = CGPoint(
                                            x: value.location.x -  origin.x,
                                            y: value.location.y - origin.y
                                        )
                                        let (date, _) = proxy.value(at: location, as: (String, Double).self) ?? ("", 0.0)
                                        let total = viewModel.graphEntries.first{ entry in entry.date.formatted(.dateTime.day().month(.twoDigits).year()) == date}
                                        self.selectedValue = total?.value ?? 0.0
                                    }
                                    .onEnded{ _ in
                                        self.selectedValue = .zero
                                    }
                            )
                    }
                }
                .onAppear {
                    for(index, _) in viewModel.graphEntries.enumerated() {
                        withAnimation(.easeOut(duration: 1.0).delay(Double(index) * 0.05)){
                            viewModel.graphEntries[index].animate = true
                        }
                    }
                }
            }
            .padding()
            .background(.background)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 5)
        }
    }
}
