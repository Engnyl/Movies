//
//  File.swift
//  Movies
//
//  Created by Engin Yildiz on 8.04.2021.
//

import UIKit
import Toast_Swift

func isDeviceiPad() -> Bool {
    if (UIDevice.current.userInterfaceIdiom == .pad) {
        return true
    }
    
    return false
}

func getFontDifference() -> CGFloat {
    if (isDeviceiPad()) {
        return 4
    }
    else {
        if UIScreen.main.bounds.size.height == 896 { // iPhone XR/XS Max
            return 2
        }
        else if UIScreen.main.bounds.size.height == 812 { // iPhone X/XS
            return 1
        }
        else if UIScreen.main.bounds.size.height == 736 { // iPhone Plus Kind
            return 2
        }
        else if UIScreen.main.bounds.size.height == 667 { // iPhone 6 Kind
            return 1
        }
        else if UIScreen.main.bounds.size.height == 480 { // iPhone 4 or 4S
            return -1
        }
        else { // iPhone 5 Kind
            return 0
        }
    }
}

func getRegularFont(punto: CGFloat) -> UIFont {
    UIFont.systemFont(ofSize: punto, weight: UIFont.Weight.regular)
}

func getLightFont(punto: CGFloat) -> UIFont {
    UIFont.systemFont(ofSize: punto, weight: UIFont.Weight.light)
}

func getBoldFont(punto: CGFloat) -> UIFont {
    UIFont.boldSystemFont(ofSize: punto)
}

func getSemiboldFont(punto: CGFloat) -> UIFont {
    UIFont.boldSystemFont(ofSize: punto)
}

func configureToastView() {
    var style = ToastStyle()
    style.backgroundColor = darkBlueColor
    style.messageColor = UIColor.white.withAlphaComponent(0.5)
    style.titleAlignment = NSTextAlignment.center
    style.messageAlignment = NSTextAlignment.center
    style.titleFont = getRegularFont(punto: 16 + getFontDifference())
    style.messageFont = getRegularFont(punto: 16 + getFontDifference())
    
    ToastManager.shared.style = style
    ToastManager.shared.isQueueEnabled = false
    ToastManager.shared.isTapToDismissEnabled = true
}

func showToastOnTop(message: String, title: String?, duration: TimeInterval) {
    UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.makeToast(message, duration: duration, position: .top, title: title, style: ToastManager.shared.style)
}

func showToastOnCenter(message: String, title: String?, duration: TimeInterval) {
    UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.makeToast(message, duration: duration, position: .center, title: title, style: ToastManager.shared.style)
}

func showToastOnBottom(message: String, title: String?, duration: TimeInterval) {
    UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.makeToast(message, duration: duration, position: .bottom, title: title, style: ToastManager.shared.style)
}
