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
    
}
