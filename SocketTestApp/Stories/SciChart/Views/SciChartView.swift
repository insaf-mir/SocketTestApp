//
//  SciChartView.swift
//  SocketTestApp
//
//  Created by Insaf Mukhametshin on 23/11/2018.
//  Copyright © 2018 HOME. All rights reserved.
//

import UIKit
import SciChart

class SciChartView: UIView {
    lazy var chartView: SCIChartSurface = {
        let view = SCIChartSurface()
        view.xAxes.add(SCINumericAxis())
        view.yAxes.add(SCINumericAxis())
        let groupModifier = SCIChartModifierCollection(childModifiers: [SCIPinchZoomModifier(), SCIZoomExtentsModifier(), SCIZoomPanModifier()])
        view.chartModifiers = groupModifier
        return view
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
    
    func updateVisiblePart(_ range: NSRange) {
        guard
            let visibleRangeX = chartView.xAxes.item(at: 0)?.visibleRange as? SCIDoubleRange,
            let minX = chartView.renderableSeries.firstObject()?.dataSeries.xValues().value(at: Int32(range.location)),
            let maxX = chartView.renderableSeries.firstObject()?.dataSeries.xValues().value(at: Int32(range.upperBound)),
            let visibleRangeY = chartView.xAxes.item(at: 0)?.visibleRange as? SCIDoubleRange,
            let minY = chartView.renderableSeries.firstObject()?.dataSeries.xValues().value(at: Int32(range.location)),
            let maxY = chartView.renderableSeries.firstObject()?.dataSeries.xValues().value(at: Int32(range.upperBound))
        else {
            return
        }
        visibleRangeX.min = minX
        visibleRangeX.max = maxX
        visibleRangeY.min = minY
        visibleRangeY.max = maxY
        chartView.invalidateElement()
    }
    
}
