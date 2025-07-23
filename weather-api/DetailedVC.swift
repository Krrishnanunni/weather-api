//
//  DetailedVC.swift
//  weather-api
//
//  Created by Krishnanunni K A on 22/07/2025.
//

import UIKit

class DetailedVC: UIViewController {

    @IBOutlet weak var wind         : UILabel!
    @IBOutlet weak var presure      : UILabel!
    @IBOutlet weak var humidity     : UILabel!
    @IBOutlet weak var descriptionW : UILabel!
    @IBOutlet weak var img          : UIImageView!
    
    var Stringwind          = 0.00
    var Stringpresure       = 0.00
    var Stringhumidity      = 0.00
    var StringdescriptionW  = ""
    var cityname            = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title  = cityname
        navigationItem.largeTitleDisplayMode = .automatic
        wind.text           = String(Stringwind)
        presure.text        = String(Stringpresure)
        humidity.text       = String(Stringhumidity)
        descriptionW.text   = StringdescriptionW
//        img.text = Stringimg
        
        
        switch StringdescriptionW {
        case "clear sky":
            img.image = UIImage(systemName: "sun.max.fill") // ☀️

        case "overcast clouds":
            img.image = UIImage(systemName: "cloud.fill") // ☁️

        case "scattered clouds":
            img.image = UIImage(systemName: "cloud") // Slightly lighter cloud

        case "broken clouds":
            img.image = UIImage(systemName: "cloud.bolt.fill") // Broken clouds (iOS 17+)

        case "light rain":
            img.image = UIImage(systemName: "cloud.drizzle.fill")// 🌧

        case "few clouds":
            img.image = UIImage(systemName: "cloud.sun.fill") // 🌤

        default:
            img.image = UIImage(systemName: "cloud")
        }
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
