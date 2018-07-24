//
//  ILineChartDataSet.swift
//  Charts
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/Charts
//

import Foundation
import CoreGraphics


@objc
public protocol ILineChartDataSet: ILineRadarChartDataSet
{
    // MARK: - Data functions and accessors
    
    // MARK: - Styling functions and accessors
    
    /// The drawing mode for this line dataset
    ///
    /// **default**: Linear
    var mode: LineChartDataSet.Mode { get set }
    
    /// Intensity for cubic lines (min = 0.05, max = 1)
    ///
    /// **default**: 0.2
    var cubicIntensity: CGFloat { get set }
    
    /// The radius array of the drawn circles.
    var circlesRadius: [CGFloat]  { get set }
    
    /// - returns: The radius at the given index of the DataSet's circlesRadius array.
    /// Performs a IndexOutOfBounds check by modulus.
    func getCirclesRadius(atIndex index: Int) -> CGFloat
    
    /// The holes radius array of the drawn circles
    var circlesHoleRadius: [CGFloat] { get set }
    
    /// - returns: The radius at the given index of the DataSet's circlesHoleRadius array.
    /// Performs a IndexOutOfBounds check by modulus.
    func getCirclesHoleRadius(atIndex index: Int) -> CGFloat
    
    var circleColors: [NSUIColor] { get set }
    
    /// - returns: The color at the given index of the DataSet's circle-color array.
    /// Performs a IndexOutOfBounds check by modulus.
    func getCircleColor(atIndex: Int) -> NSUIColor?
    
    /// Sets the one and ONLY color that should be used for this DataSet.
    /// Internally, this recreates the colors array and adds the specified color.
    func setCircleColor(_ color: NSUIColor)
    
    /// Resets the circle-colors array and creates a new one
    func resetCircleColors(_ index: Int)
    
    var circleHoleColors: [NSUIColor] { get set }
    
    /// - returns: The color at the given index of the DataSet's circleHole-color array.
    /// Performs a IndexOutOfBounds check by modulus.
    func getCircleHoleColor(atIndex: Int) -> NSUIColor?
    
    /// Sets the one and ONLY holeColor that should be used for this DataSet.
    /// Internally, this recreates the holecolors array and adds the specified color.
    func setCircleHoleColor(_ color: NSUIColor)
    
    /// Resets the circleHole-colors array and creates a new one
    func resetCircleHoleColors(_ index: Int)
    
    /// If true, drawing circles is enabled
    var drawCirclesEnabled: Bool { get set }
    
    /// - returns: `true` if drawing circles for this DataSet is enabled, `false` ifnot
    var isDrawCirclesEnabled: Bool { get }
    
    /// `true` if drawing circles for this DataSet is enabled, `false` ifnot
    var drawCircleHoleEnabled: Bool { get set }
    
    /// - returns: `true` if drawing the circle-holes is enabled, `false` ifnot.
    var isDrawCircleHoleEnabled: Bool { get }
    
    /// This is how much (in pixels) into the dash pattern are we starting from.
    var lineDashPhase: CGFloat { get }
    
    /// This is the actual dash pattern.
    /// I.e. [2, 3] will paint [--   --   ]
    /// [1, 3, 4, 2] will paint [-   ----  -   ----  ]
    var lineDashLengths: [CGFloat]? { get set }
    
    /// Line cap type, default is CGLineCap.Butt
    var lineCapType: CGLineCap { get set }
    
    /// Sets a custom IFillFormatter to the chart that handles the position of the filled-line for each DataSet. Set this to null to use the default logic.
    var fillFormatter: IFillFormatter? { get set }
}
