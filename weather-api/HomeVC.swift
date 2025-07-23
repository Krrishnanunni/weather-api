//
//  HomeVC.swift
//  weather-api
//
//  Created by iroid on 22/07/25.
//

import UIKit

class HomeVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var myTableView: UITableView!
    var jsondata = NSDictionary()
    struct City {
        var name:String
        var lat:String
        var long:String
        var img:UIImage?
        var weatherDes:String!
        var Humidity:Double!
        var pressure:Double!
        var windSpeed:Double!
    }
    
    var cities:[City] = [
        City(name: "Kochi",             lat: "9.9312",  long: "76.2673"),
        City(name: "Thiruvananthapuram",lat: "8.5241",  long: "76.9366"),
        City(name: "Kozhikode",         lat: "11.2488", long: "75.7839"),
        City(name: "Japan",             lat: "35.6764", long: "139.6500"),
        City(name: "Dubai",             lat: "25.2048", long: "55.2708"),
        City(name: "New York",          lat: "40.7128", long: "-74.0060"),
        City(name: "London",            lat: "51.5074", long: "-0.1278"),
        City(name: "Sydney",            lat: "-33.8688",long: "151.2093"),
        City(name: "Paris",             lat: "48.8566", long: "2.3522"),
        City(name: "Mumbai",            lat: "19.0760", long: "72.8777"),
        City(name: "Bangalore",         lat: "12.9716", long: "77.5946"),
        City(name: "Singapore",         lat: "1.3521",  long: "103.8198"),
        City(name: "Hong Kong",         lat: "22.3193", long: "114.1694"),
        City(name: "Toronto",           lat: "43.6532", long: "-79.3832"),
        City(name: "Cape Town",         lat: "-33.9249",long: "18.4241"),
        City(name: "Rio de Janeiro",    lat: "-22.9068",long: "-43.1729"),
        City(name: "Moscow",            lat: "55.7558", long: "37.6173"),
        City(name: "Beijing",           lat: "39.9042", long: "116.4074"),
        City(name: "Cairo",             lat: "30.0444", long: "31.2357"),
        City(name: "Mexico City",       lat: "19.4326", long: "-99.1332"),
        City(name: "Amsterdam",         lat: "52.3676", long: "4.9041"),
        City(name: "Seoul",             lat: "37.5665", long: "126.9780"),
        City(name: "Bangkok",           lat: "13.7563", long: "100.5018"),
        City(name: "Istanbul",          lat: "41.0082", long: "28.9784"),
        City(name: "Rome",              lat: "41.9028", long: "12.4964"),
        City(name: "San Francisco",     lat: "37.7749", long: "-122.4194"),
        City(name: "Nairobi",           lat: "-1.2921", long: "36.8219"),
        City(name: "Vancouver",         lat: "49.2827", long: "-123.1207"),
        City(name: "Jakarta",           lat: "-6.2088", long: "106.8456"),
        City(name: "Auckland",          lat: "-36.8485",long: "174.7633")
    ]
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tcell = tableView.dequeueReusableCell(withIdentifier: "WeatherTVC") as! WeatherTVC
        tcell.cityName.text = self.cities[indexPath.row].name
        tcell.descriptionC.text = self.cities[indexPath.row].weatherDes

        
        return tcell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 71
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let DetailedVC = sb.instantiateViewController(withIdentifier: "DetailedVC") as! DetailedVC
        
        DetailedVC.Stringwind           = cities[indexPath.row].windSpeed
        DetailedVC.Stringpresure        = cities[indexPath.row].pressure
        DetailedVC.Stringhumidity       = cities[indexPath.row].Humidity
        DetailedVC.StringdescriptionW   = cities[indexPath.row].weatherDes
        DetailedVC.cityname             = cities[indexPath.row].name
        
        
        
        navigationController?.pushViewController(DetailedVC, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Weather App"
        navigationItem.largeTitleDisplayMode = .automatic
        GetData()
        
        print("------------------------>",cities)
        // Do any additional setup after loading the view.
    }
    
    
    func GetData(){
        var count = self.cities.count
        for (index,city) in cities.enumerated() {
            
            let urlstring = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(cities[index].lat)&lon=\(cities[index].long)&appid=277fcbcc4af79c0b86c5b09137843fd6")
            let req = URLRequest(url: urlstring!)
            let task = URLSession.shared.dataTask(with: req){
                (data,request,error) in
                if let mydata = data {
                    do{
                        print("data---------->",mydata)
                        
                        do{
                            try self.jsondata = JSONSerialization.jsonObject(with: mydata,options: []) as! NSDictionary
                            
                            DispatchQueue.main.async {
                                print("jsondata---------------->",self.jsondata)
                                let weatherdata     = self.jsondata["weather"] as! NSArray
                                let maindata        = self.jsondata["main"] as! NSDictionary
                                let winddata        = self.jsondata["wind"] as! NSDictionary
                                
                                let weather         = weatherdata[0] as! NSDictionary
                                
                                let description     = weather["description"] as! String
                                let humidity        = maindata["humidity"] as! Double
                                let pressure        = maindata["pressure"] as! Double
                                let wind            = winddata["speed"] as! Double
                                let name            = self.jsondata["name"] as! String
                                
                                
                                self.cities[index].Humidity     = humidity
                                self.cities[index].weatherDes   = description
                                self.cities[index].pressure     = pressure
                                self.cities[index].windSpeed    = wind
                                
                                
                               
                                
                                self.myTableView.reloadData()
                                
                               //the variable struct have values in humdity,weatherdes,pressure,windspeed

                            }

                            
                        }
                    }catch{
                        print("eror-----",error.localizedDescription)
                    }
                }
            }
            task.resume()
            
            
            
   //but the values are empty here
        }
        
        
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
