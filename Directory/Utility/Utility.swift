//
//  Utility.swift
//  Directory
//
//  Created by Sandeep on 18/07/2021.
//

import Foundation
import CoreLocation
import UIKit


extension UIInterfaceOrientationMask {
  func supports(_ orientation: UIInterfaceOrientation) -> Bool {
    return (orientation.isLandscape && self.contains(.landscape))
        || (orientation.isPortrait && self.contains(.portrait))
  }

  func misses(_ orientation: UIInterfaceOrientation) -> Bool {
    return !supports(orientation)
  }
}

extension UIColor
{
    var isDarkColor: Bool {
        var r, g, b, a: CGFloat
        (r, g, b, a) = (0, 0, 0, 0)
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        let lum = 0.2126 * r + 0.7152 * g + 0.0722 * b
        return  lum < 0.50
    }
}

extension Double {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}

extension UIImageView {
    fileprivate func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleToFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

class Utility{
    
    //TODO as the Geocoder is not reliable to use as its not returning correct data all the time i am not using this method and simpy displayinh the lat/long on the UI
    static func getLocation(pdblLatitude: Double, withLongitude pdblLongitude: Double) -> String {
        var addressString : String = ""
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = pdblLatitude
        center.longitude = pdblLongitude
        let semaphore = DispatchSemaphore(value: 0)

        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        ceo.reverseGeocodeLocation(loc, completionHandler:{(placemarks, error) in
            
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                    return
                }
                
                guard let placemarks = placemarks else {
                    return
                }
                
                let pm = placemarks as [CLPlacemark]

                if pm.count > 0 {
                    let pm = placemarks[0]
                    //print(pm.country!)
                    //print(pm.locality!)
                    //print(pm.subLocality!)
                    //print(pm.thoroughfare!)
                    //print(pm.postalCode!)
                    //print(pm.subThoroughfare!)
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    //if pm.thoroughfare != nil {
                    //    addressString = addressString + pm.thoroughfare! + ", "
                    //}
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    semaphore.signal()
              }
        })
        semaphore.wait()
        return addressString
    }
    
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    static func formatDate(input:String)->String{
        let formatter = DateFormatter()
                                //"2020-12-14T11:24:20.999Z"
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.locale=Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(identifier: "GMT")

        if let date = formatter.date(from: input){
            let format = DateFormatter()
            format.dateFormat = "yyyy-MM-dd"
            return format.string(from: date)
        }
        return ""
    }
}



