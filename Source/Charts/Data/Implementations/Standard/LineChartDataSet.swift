//
//  LineChartDataSet.swift
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


open class LineChartDataSet: LineRadarChartDataSet, ILineChartDataSet
{
    @objc(LineChartMode)
    public enum Mode: Int
    {
        case linear
        case stepped
        case cubicBezier
        case horizontalBezier
    }
    
    private func initialize()
    {
        // default color
        circleColors.append(NSUIColor(red: 140.0/255.0, green: 234.0/255.0, blue: 255.0/255.0, alpha: 1.0))
    }
    
    public required init()
    {
        super.init()
        initialize()
    }
    
    public override init(values: [ChartDataEntry]?, label: String?)
    {
        super.init(values: values, label: label)
        initialize()
    }
    
    // MARK: - Data functions and accessors
    
    // MARK: - Styling functions and accessors
    
    /// The drawing mode for this line dataset
    ///
    /// **default**: Linear
    open var mode: Mode = Mode.linear
    
    private var _cubicIntensity = CGFloat(0.2)
    
    /// Intensity for cubic lines (min = 0.05, max = 1)
    ///
    /// **default**: 0.2
    open var cubicIntensity: CGFloat
    {
        get
        {
            return _cubicIntensity
        }
        set
        {
            _cubicIntensity = newValue
            if _cubicIntensity > 1.0
            {
                _cubicIntensity = 1.0
            }
            if _cubicIntensity < 0.05
            {
                _cubicIntensity = 0.05
            }
        }
    }
        
    /// The radius array of the drawn circles.
    open var circlesRadius = [CGFloat]()
    
    /// - returns: The radius at the given index of the DataSet's circlesRadius array.
    /// Performs a IndexOutOfBounds check by modulus.
    open func getCirclesRadius(atIndex index: Int) -> CGFloat
    {
        let size = circlesRadius.count
        let index = index % size
        if index >= size
        {
            return 0
        }
        return circlesRadius[index]
    }
    
    /// The holes radius array of the drawn circles
    open var circlesHoleRadius = [CGFloat]()
    
    /// - returns: The radius at the given index of the DataSet's circlesHoleRadius array.
    /// Performs a IndexOutOfBounds check by modulus.
    open func getCirclesHoleRadius(atIndex index: Int) -> CGFloat
    {
        let size = circlesHoleRadius.count
        let index = index % size
        if index >= size
        {
            return 0
        }
        return circlesHoleRadius[index]
    }
    
    open var circleColors = [NSUIColor]()
    
    /// - returns: The color at the given index of the DataSet's circle-color array.
    /// Performs a IndexOutOfBounds check by modulus.
    open func getCircleColor(atIndex index: Int) -> NSUIColor?
    {
        let size = circleColors.count
        let index = index % size
        if index >= size
        {
            return nil
        }
        return circleColors[index]
    }
    
    /// Sets the one and ONLY color that should be used for this DataSet.
    /// Internally, this recreates the colors array and adds the specified color.
    open func setCircleColor(_ color: NSUIColor)
    {
        circleColors.removeAll(keepingCapacity: false)
        circleColors.append(color)
    }
    
    open func setCircleColors(_ colors: NSUIColor...)
    {
        circleColors.removeAll(keepingCapacity: false)
        circleColors.append(contentsOf: colors)
    }
    
    /// Resets the circle-colors array and creates a new one
    open func resetCircleColors(_ index: Int)
    {
        circleColors.removeAll(keepingCapacity: false)
    }
    
    open var circleHoleColors = [NSUIColor]()
    
    /// - returns: The color at the given index of the DataSet's circleHole-color array.
    /// Performs a IndexOutOfBounds check by modulus.
    open func getCircleHoleColor(atIndex index: Int) -> NSUIColor?
    {
        let size = circleColors.count
        let index = index % size
        if index >= size
        {
            return nil
        }
        return circleHoleColors[index]
    }
    
    /// Sets the one and ONLY holeColor that should be used for this DataSet.
    /// Internally, this recreates the holeColors array and adds the specified color.
    open func setCircleHoleColor(_ color: NSUIColor)
    {
        circleHoleColors.removeAll(keepingCapacity: false)
        circleHoleColors.append(color)
    }
    
    open func setCircleHoleColors(_ colors: NSUIColor...)
    {
        circleHoleColors.removeAll(keepingCapacity: false)
        circleHoleColors.append(contentsOf: colors)
    }
    
    /// Resets the circleHole-colors array and creates a new one
    open func resetCircleHoleColors(_ index: Int)
    {
        circleHoleColors.removeAll(keepingCapacity: false)
    }
    
    /// If true, drawing circles is enabled
    open var drawCirclesEnabled = true
    
    /// - returns: `true` if drawing circles for this DataSet is enabled, `false` ifnot
    open var isDrawCirclesEnabled: Bool { return drawCirclesEnabled }
    
    /// `true` if drawing circles for this DataSet is enabled, `false` ifnot
    open var drawCircleHoleEnabled = true
    
    /// - returns: `true` if drawing the circle-holes is enabled, `false` ifnot.
    open var isDrawCircleHoleEnabled: Bool { return drawCircleHoleEnabled }
    
    /// This is how much (in pixels) into the dash pattern are we starting from.
    open var lineDashPhase = CGFloat(0.0)
    
    /// This is the actual dash pattern.
    /// I.e. [2, 3] will paint [--   --   ]
    /// [1, 3, 4, 2] will paint [-   ----  -   ----  ]
    open var lineDashLengths: [CGFloat]?
    
    /// Line cap type, default is CGLineCap.Butt
    open var lineCapType = CGLineCap.butt
    
    /// formatter for customizing the position of the fill-line
    private var _fillFormatter: IFillFormatter = DefaultFillFormatter()
    
    /// Sets a custom IFillFormatter to the chart that handles the position of the filled-line for each DataSet. Set this to null to use the default logic.
    open var fillFormatter: IFillFormatter?
    {
        get
        {
            return _fillFormatter
        }
        set
        {
            _fillFormatter = newValue ?? DefaultFillFormatter()
        }
    }
    
    // MARK: NSCopying
    
    open override func copyWithZone(_ zone: NSZone?) -> AnyObject
    {
        let copy = super.copyWithZone(zone) as! LineChartDataSet
        copy.circleColors = circleColors
        copy.circlesRadius = circlesRadius
        copy.cubicIntensity = cubicIntensity
        copy.lineDashPhase = lineDashPhase
        copy.lineDashLengths = lineDashLengths
        copy.lineCapType = lineCapType
        copy.drawCirclesEnabled = drawCirclesEnabled
        copy.drawCircleHoleEnabled = drawCircleHoleEnabled
        copy.mode = mode
        return copy
    }
}
