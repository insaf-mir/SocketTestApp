//******************************************************************************
// SCICHART® Copyright SciChart Ltd. 2011-2018. All rights reserved.
//
// Web: http://www.scichart.com
// Support: support@scichart.com
// Sales:   sales@scichart.com
//
// SCIFastLineRenderableSeries.h is part of SCICHART®, High Performance Scientific Charts
// For full terms and conditions of the license, see http://www.scichart.com/scichart-eula/
//
// This source code is protected by international copyright law. Unauthorized
// reproduction, reverse-engineering, or distribution of all or any portion of
// this source code is strictly prohibited.
//
// This source code contains confidential and proprietary trade secrets of
// SciChart Ltd., and should at no time be copied, transferred, sold,
// distributed or made available without express written permission.
//******************************************************************************

/** \addtogroup RenderableSeries
 *  @{
 */

#import <Foundation/Foundation.h>
#import "SCIRenderableSeriesBase.h"
#import "SCIThemeableProtocol.h"
#import "SCIRenderableSeriesAnimationProtocol.h"

@class SCILineSeriesStyle;

/**
 * @brief The SCIFastLineRenderableSeries class.
 * @discussion This renderable series displays line connecting all data points and as option point markers at data points coordinates
 * @remark Designed to work with SCIXyDataSeries as data container
 * @remark For styling provide or customize SCILineSeriesStyle
 * @see SCIRenderableSeriesProtocol
 * @see SCIRenderableSeriesBase
 * @see SCIXyDataSeries
 * @see SCILineSeriesStyle
 */
@interface SCIFastLineRenderableSeries : SCIRenderableSeriesBase <SCIThemeableProtocol>

/**
 * @brief Get or set style for visual customization
 * @see SCILineSeriesStyle
 */
@property(nonatomic, copy) SCILineSeriesStyle *style;

/**
 * @brief Gets or sets selected series style
 * @discussion If set to nil selected style is default series style
 */
@property(nonatomic, copy) SCILineSeriesStyle *selectedStyle;

@property(nonatomic) BOOL isDigitalLine;

@end

/** @}*/
