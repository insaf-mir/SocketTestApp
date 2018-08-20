//
//  ChartView.swift
//  SocketTestApp
//
//  Created by Инсаф Мухаметшин on 20.08.2018.
//  Copyright © 2018 HOME. All rights reserved.
//

import UIKit
import Charts
import SnapKit

class ChartView: UIView {
    private lazy var chartView: LineChartView = {
        let chartView = LineChartView()
        chartView.dragEnabled = true
        chartView.chartDescription?.enabled = false
        chartView.highlightPerTapEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = true
        chartView.drawGridBackgroundEnabled = true
        chartView.legend.enabled = true
        return chartView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(chartView)
        makeConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        chartView.snp.makeConstraints { make in
            make.leading.centerY.trailing.equalToSuperview()
            make.height.equalToSuperview().dividedBy(2)
        }
    }
    
    func update(_ data: LineChartData) {
        chartView.data = data
    }
    
}
