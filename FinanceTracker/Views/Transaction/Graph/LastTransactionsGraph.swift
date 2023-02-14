//
//  LastTransactionsGraph.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 06.02.23.
//

import SwiftUI
import SwiftUICharts

struct LastTransactionsGraph: View {
    @ObservedObject var viewModel: TransactionGraphViewModel
    
    var body: some View {
        if !viewModel.graphData.isEmpty {
            let total = viewModel.graphData.reduce(0) { $0 + $1.1}
            BarChartView(
                data: ChartData(values: viewModel.graphData),
                title: total.formatted(.currency(code: Locale.current.currency?.identifier ?? "EUR")),
                style: ChartStyle(
                    backgroundColor: Color.background, //3B5147, 313D34
                    accentColor: Color.side,
                    secondGradientColor: Color.nav,
                    textColor: Color.side,
                    legendTextColor: Color.side,
                    dropShadowColor: Color.gray),
                form: ChartForm.extraLarge,
                valueSpecifier: "%.2f \(Locale.current.currencySymbol ?? "€")"
            )
            .frame(height: 400)
        }
    }

}

