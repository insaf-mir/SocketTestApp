//
//  ChartViewModel.swift
//  SocketTestApp
//
//  Created by Инсаф Мухаметшин on 20.08.2018.
//  Copyright © 2018 HOME. All rights reserved.
//

import RxSwift
import RxCocoa
import Charts

class ChartViewModel {
    let disposeBag = DisposeBag()
    let chartDataVariable = BehaviorRelay<LineChartData>(value: LineChartData())
    let provider = ChartDataProvider()
    private var tickersVariable = BehaviorRelay<[Ticker]>(value: [])

    init() {
        bind()
    }
    
    func bind() {
        provider.tickerSubject
            .subscribe(onNext: { [weak self] ticker in
                print(ticker)
                guard var tickers = self?.tickersVariable.value else {
                    return
                }
                tickers.append(ticker)
                self?.tickersVariable.accept(tickers)
            })
            .disposed(by: disposeBag)
        tickersVariable.subscribe(onNext: { [weak self] tickers in
            guard let firstTicker = tickers.first else {
                return
            }
            
            let dataEntry = tickers.compactMap {
                return ChartDataEntry(x: $0.date.timeIntervalSince(firstTicker.date), y: $0.lastPrice)
            }
            let dataSet = LineChartDataSet(values: dataEntry, label: "Last price")
            let data = LineChartData(dataSet: dataSet)
            self?.chartDataVariable.accept(data)
        }).disposed(by: disposeBag)
    }
    
    private func configureChartDataSet(with chartData: [ChartDataEntry]) -> LineChartDataSet {
        let chartDataSet = LineChartDataSet(values: chartData, label: nil)
        chartDataSet.lineWidth = 1
        chartDataSet.circleRadius = 4
        chartDataSet.setColor(.red)
        chartDataSet.drawFilledEnabled = true
        chartDataSet.highlightEnabled = true
        chartDataSet.circleColors = chartData.map { _ in return .red }
        return chartDataSet
    }

}
