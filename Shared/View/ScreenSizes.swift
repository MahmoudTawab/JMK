//
//  ScreenSizes.swift
//  ScreenSizes
//
//  Created by Emoji Technology on 07/09/2021.
//

import UIKit

func ControlWidth(_ ControlW:CGFloat) -> CGFloat {
let width = 375.0
let widthRat:CGFloat = UIScreen.main.bounds.width / CGFloat(width)
let W = ControlW * widthRat
return W
}

func ControlHeight(_ ControlH:CGFloat) -> CGFloat {
let height = 667.0
let heightRat:CGFloat = UIScreen.main.bounds.height/CGFloat(height)
let H = ControlH * heightRat
return H
}

func ControlX(_ ControlX:CGFloat) -> CGFloat {
let width = 375.0
let widthRat:CGFloat = UIScreen.main.bounds.maxX / CGFloat(width)
let X = ControlX * widthRat
return X
}

func ControlY(_ ControlY:CGFloat) -> CGFloat {
let height = 667.0
let heightRat:CGFloat = UIScreen.main.bounds.maxY / CGFloat(height)
let Y = ControlY * heightRat
return Y
}
