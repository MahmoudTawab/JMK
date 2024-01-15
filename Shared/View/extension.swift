//
//  extension.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 23/07/2021.
//

import UIKit
import AVKit
import Foundation


extension String {
    func heightWithConstrainedWidth(_ width: CGFloat, font: UIFont, Spacing:CGFloat) -> CGFloat? {
    let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = Spacing
    let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font,NSAttributedString.Key.paragraphStyle:paragraphStyle], context: nil)
        
    return ceil(boundingBox.height)
    }
    
    func textSizeWithFont(_ font: UIFont) -> CGSize {
    return self.size(withAttributes: [.font: font])
    }
    
    func TextNull() -> Bool {
    if self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count > 0 {
    return true
    }
    return false
    }
    
    func Formatter() -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    let date = dateFormatter.date(from:self)
    let calendar = NSCalendar.current
    let components = calendar.dateComponents([.year, .month, .day, .hour ,.minute ,.second], from: date ?? Date())
    let finalDate = calendar.date(from:components) ?? Date()
    return finalDate
    }
}

extension UILabel {
    var spasing:CGFloat {
    get {return 0}
    set {
    let textAlignment = self.textAlignment
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = newValue
    let attributedString = NSAttributedString(string: self.text ?? "", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    self.attributedText = attributedString
    self.textAlignment = textAlignment
    }
    }
    
    func decideTextDirection() {
    let tagScheme = [NSLinguisticTagScheme.language]
    let tagger    = NSLinguisticTagger(tagSchemes: tagScheme, options: 0)
    tagger.string = self.text
    let lang      = tagger.tag(at: 0, scheme: NSLinguisticTagScheme.language,
                                              tokenRange: nil, sentenceRange: nil)

    if lang?.rawValue.range(of:"ar") != nil {
    self.textAlignment = NSTextAlignment.right
    } else {
    self.textAlignment = NSTextAlignment.left
    }
    }
}

extension UITextView {
    var spasing:CGFloat {
    get {return 0}
    set {
    let Color = self.textColor
    let textAlignment = self.textAlignment
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = newValue
    let attributedString = NSAttributedString(string: self.text ?? "", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle, .font: self.font ?? UIFont.italicSystemFont(ofSize: 16)])
    self.attributedText = attributedString
    self.textAlignment = textAlignment
    self.textColor = Color
    }
    }
}

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
    DispatchQueue.main.async {
    let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    self.layer.mask = mask
    }
    }
    
    func MotionEffect(_ Relative: CGFloat = 20) {
    let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
    horizontalMotionEffect.minimumRelativeValue = -Relative
    horizontalMotionEffect.maximumRelativeValue = Relative

    let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
    verticalMotionEffect.minimumRelativeValue = -Relative
    verticalMotionEffect.maximumRelativeValue = Relative

    let motionEffectGroup = UIMotionEffectGroup()
    motionEffectGroup.motionEffects = [horizontalMotionEffect, verticalMotionEffect]

    self.addMotionEffect(motionEffectGroup)
    }
    
    func Shake() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.05
        shake.repeatCount = 2
        shake.autoreverses = true
                    
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)

        shake.fromValue = fromValue
        shake.toValue = toValue
                
        layer.add(shake, forKey: "position")
    }
    
    func shadow(_ Offset:Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        layer.shadowOpacity = 0.6
        layer.shadowRadius = 6
        layer.shadowOffset = Offset == true ? CGSize(width: 0, height: 5):CGSize(width: 5, height: 0)
    }
}

    extension Date {
    func timeAgoDisplay() -> String {
    let secondsAgo = Int(Date().timeIntervalSince(self))
    let minute = 60
    let hour = 60 * minute
    let day = 24 * hour
    let week = 7 * day
    let month = 4 * week
    let Year = 12 * month
        
    let quotient:Int
    let unit:String
    if secondsAgo < minute {
     quotient = secondsAgo
     unit = "second"
    }else if secondsAgo < hour {
     quotient = secondsAgo / minute
     unit = "min"
    }else if secondsAgo < day {
     quotient = secondsAgo / hour
     unit = "hour"
    }else if secondsAgo < week {
     quotient = secondsAgo / day
     unit = "day"
    }else if secondsAgo < month {
     quotient = secondsAgo / week
     unit = "week"
    }else if secondsAgo < Year {
    quotient = secondsAgo / month
    unit = "month"
    }else{
    quotient = secondsAgo / Year
    unit = "Year"
    }
    return "\(quotient) \(unit)\(quotient == 1 ? "" : "s") ago"
    }
        
    func dayDifference() -> String {
    let calendar = NSCalendar.current
    if calendar.isDateInYesterday(self) { return "Yesterday" }
    else if calendar.isDateInToday(self) { return "Today" }
    else {
    return "Earlier"
    }
    }
        
    func Formatter(_ dateFormat: String = "yyyy-MM-dd") -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en")
    dateFormatter.dateFormat = dateFormat
    let calendar = NSCalendar.current
    let components = calendar.dateComponents([.year, .month, .day, .hour ,.minute ,.second], from: self)
    let finalDate = calendar.date(from:components) ?? Date()
    return dateFormatter.string(from: finalDate)
    }
    
    }

    extension TimeInterval {
    func Difference(from interval : TimeInterval) -> String {
    let calendar = NSCalendar.current
    let date = Date(timeIntervalSince1970: interval)
    if calendar.isDateInYesterday(date) { return "Yesterday" }
    else if calendar.isDateInToday(date) { return "Today" }
    else {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "d MMMM,yyyy"
    return dateFormatter.string(from: date)
    }
    }
    }



extension UIImage {
    func withInset(_ insets: UIEdgeInsets) -> UIImage? {
        let cgSize = CGSize(width: self.size.width + insets.left * self.scale + insets.right * self.scale,
                            height: self.size.height + insets.top * self.scale + insets.bottom * self.scale)

        UIGraphicsBeginImageContextWithOptions(cgSize, false, self.scale)
        defer { UIGraphicsEndImageContext() }

        let origin = CGPoint(x: insets.left * self.scale, y: insets.top * self.scale)
        self.draw(at: origin)

        return UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(self.renderingMode)
    }
}

 func FirstController(_ Controller: UIViewController?) {
     if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
     appDelegate.window?.rootViewController?.self.navigationController?.popViewController(animated: true)
     appDelegate.window?.makeKeyAndVisible()
     appDelegate.window?.rootViewController = Controller
     appDelegate.window?.rootViewController?.modalTransitionStyle = .flipHorizontal
     appDelegate.window?.rootViewController?.modalPresentationStyle = .fullScreen
     }
 }

extension UILabel {
func didTapAttributedTextInLabel(gesture: UITapGestureRecognizer, inRange targetRange: NSRange) -> Bool {

        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        guard let strAttributedText = self.attributedText else {
            return false
        }

        let textStorage = NSTextStorage(attributedString: strAttributedText)

        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = self.lineBreakMode
        textContainer.maximumNumberOfLines = self.numberOfLines
        let labelSize = self.bounds.size
        textContainer.size = CGSize(width: labelSize.width, height: CGFloat.greatestFiniteMagnitude)

        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = gesture.location(in: self)

        let xCordLocationOfTouchInTextContainer = locationOfTouchInLabel.x
        let yCordLocationOfTouchInTextContainer = locationOfTouchInLabel.y
        let locOfTouch = CGPoint(x: xCordLocationOfTouchInTextContainer ,
                                 y: yCordLocationOfTouchInTextContainer)

        let indexOfCharacter = layoutManager.characterIndex(for: locOfTouch, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)

        guard let strLabel = text else {
            return false
        }

        let charCountOfLabel = strLabel.count

        if indexOfCharacter < (charCountOfLabel - 1) {
            return NSLocationInRange(indexOfCharacter, targetRange)
        } else {
            return false
        }
    }
}




extension UIDatePicker {
    func SetMinAndMaxDate(_ min:Int) {
    let calendar = NSCalendar.current
    var minDateComponent = calendar.dateComponents([.day,.month,.year], from: Date())
    minDateComponent.day = min

    let minDate = calendar.date(from: minDateComponent)
    self.minimumDate = minDate! as Date
        
//    var maxDateComponent = calendar.dateComponents([.day,.month,.year], from: Date())
//    maxDateComponent.day = max[0]
//    maxDateComponent.month = max[1]
//    maxDateComponent.year = max[2]
//
//    let maxDate = calendar.date(from: maxDateComponent)
        
//    self.maximumDate =  maxDate! as Date
    }
}

extension UIScrollView {
    func updateContentViewSize(_ spasing:CGFloat) {
        DispatchQueue.main.async {
        var newHeight: CGFloat = 0
            for view in self.subviews {
            let ref = view.frame.origin.y + view.frame.height
            if ref > newHeight {
                newHeight = ref
            }
        }
        let oldSize = self.contentSize
        let newSize = CGSize(width: oldSize.width, height: newHeight + spasing)
        self.contentSize = newSize
        }
    }
}

extension BidirectionalCollection {
    subscript(safe offset: Int) -> Element? {
        guard !isEmpty, let i = index(startIndex, offsetBy: offset, limitedBy: index(before: endIndex)) else { return nil }
        return self[i]
    }
}


public extension Array where Element: Hashable {
    func uniqued() -> [Element] {
        var seen = Set<Element>()
        return filter{ seen.insert($0).inserted }
    }
}

extension Encodable {
    /// Encode into JSON and return `Data`
    func jsonData() throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .iso8601
        return try encoder.encode(self)
    }
}

func jsonToDictionary(_ Object: Encodable) -> [[String : Any]] {
    do {
    let jsonData = try Object.jsonData()
    let json = try JSONSerialization.jsonObject(with: jsonData, options: [])
    guard let dictionary = json as? [[String : Any]] else {return [[String : Any]()]}
    return dictionary
    }catch{
    print(error.localizedDescription)
    }
    return [[String : Any]()]
}



extension UIControl {
    
    /// Typealias for UIControl closure.
    public typealias UIControlTargetClosure = (UIControl) -> ()
    
    private class UIControlClosureWrapper: NSObject {
        let closure: UIControlTargetClosure
        init(_ closure: @escaping UIControlTargetClosure) {
            self.closure = closure
        }
    }
    
    private struct AssociatedKeys {
        static var targetClosure = "targetClosure"
    }
    
    private var targetClosure: UIControlTargetClosure? {
        get {
            guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? UIControlClosureWrapper else { return nil }
            return closureWrapper.closure
        }
        set(newValue) {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self, &AssociatedKeys.targetClosure, UIControlClosureWrapper(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc func closureAction() {
        guard let targetClosure = targetClosure else { return }
        targetClosure(self)
    }
    
    public func addAction(for event: UIControl.Event, closure: @escaping UIControlTargetClosure) {
        targetClosure = closure
        addTarget(self, action: #selector(UIControl.closureAction), for: event)
    }
    
}
