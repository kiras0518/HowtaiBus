//
//  BannerVC.swift
//  HowtaiBus
//
//  Created by yukun on 2022/6/24.
//

import SwiftUI
import UIKit
import GoogleMobileAds

final private class BannerAD: UIViewControllerRepresentable  {
    
    let testID = "ca-app-pub-3940256099942544/2934735716"
    let unitID = "ca-app-pub-5457826559746010/5547973367"
    
    func makeUIViewController(context: Context) -> UIViewController {
        let view = GADBannerView(adSize: GADAdSizeBanner)
        
        let viewController = UIViewController()
        view.adUnitID = unitID
        view.rootViewController = viewController
        viewController.view.addSubview(view)
        viewController.view.frame = CGRect(origin: .zero, size: GADAdSizeBanner.size)
        view.load(GADRequest())
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct BannerVC: View {
    
    var body: some View {
        
        HStack{
            Spacer()
            BannerAD().frame(width: 320, height: 50, alignment: .center)
            Spacer()
        }
    }
}

struct BannerVC_Previews: PreviewProvider {
    static var previews: some View {
        BannerVC()
    }
}
