//
//  AdManager.swift
//  betterWallpapers
//
//  Created by Artem on 09/02/2023.
//

import SwiftUI
import GoogleMobileAds
import UIKit



final class OpenAd: NSObject, GADFullScreenContentDelegate {
   var appOpenAd: GADAppOpenAd?
   var loadTime = Date()
   
   func requestAppOpenAd() {
       let request = GADRequest()
       let adKey: String = "ca-app-pub-5858983234630622/8145487242"
       GADAppOpenAd.load(withAdUnitID: adKey,
                         request: request,
                         orientation: UIInterfaceOrientation.portrait,
                         completionHandler: { (appOpenAdIn, _) in
                           self.appOpenAd = appOpenAdIn
                           self.appOpenAd?.fullScreenContentDelegate = self
                           self.loadTime = Date()
                           print("[OPEN AD] Ad is ready")
                         })
   }
   
   func tryToPresentAd() {
       let scenes = UIApplication.shared.connectedScenes
       let windowScene = scenes.first as? UIWindowScene
       let window = windowScene?.windows.first
       
       if let gOpenAd = self.appOpenAd, wasLoadTimeLessThanNHoursAgo(thresholdN: 4) {
           gOpenAd.present(fromRootViewController: (window?.rootViewController)!)
       } else {
           self.requestAppOpenAd()
       }
   }
   
   func wasLoadTimeLessThanNHoursAgo(thresholdN: Int) -> Bool {
       let now = Date()
       let timeIntervalBetweenNowAndLoadTime = now.timeIntervalSince(self.loadTime)
       let secondsPerHour = 3600.0
       let intervalInHours = timeIntervalBetweenNowAndLoadTime / secondsPerHour
       return intervalInHours < Double(thresholdN)
   }
   
   func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
       print("[OPEN AD] Failed: \(error)")
       requestAppOpenAd()
   }
   
   func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
       requestAppOpenAd()
       print("[OPEN AD] Ad dismissed")
   }
   
//   func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
//       print("[OPEN AD] Ad did present")
//   }
}
