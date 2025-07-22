//
//  HomeVC.swift
//  weather-api
//
//  Created by iroid on 22/07/25.
//

import UIKit

class HomeVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    var jsondata = NSDictionary()
    struct City {
        var name:String
        var lat:String
        var long:String
        var img:UIImage?
        var weatherDes:String!
    }
    
    var cities:[City] = [
        City(name: "Kochi", lat: "9.9312", long: "76.2673"),
        City(name: "Thiruvananthapuram", lat: "8.5241", long: "76.9366"),
        City(name: "Kozhikode", lat: "11.2488", long: "75.7839"),
        City(name: "Japan", lat: "35.6764", long: "139.6500"),
        City(name: "Dubai", lat: "25.2048", long: "55.2708")
    ]
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tcell = tableView.dequeueReusableCell(withIdentifier: "WeatherTVC") as! WeatherTVC
        tcell.cityName.text = self.cities[indexPath.row].name
        
        let urlstring = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(cities[indexPath.row].lat)&lon=\(cities[indexPath.row].long)&appid=277fcbcc4af79c0b86c5b09137843fd6")
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
                            let weatherdata = self.jsondata["weather"] as! NSArray
                            let weather = weatherdata[0] as! NSDictionary
                            let description = weather["description"] as! String
                            let name = self.jsondata["name"] as! String
                            
                            
                            tcell.descriptionC.text = description

                        }
                        
                        
                        
                    }
                }catch{
                    print("eror-----",error.localizedDescription)
                }
            }
        }
        task.resume()
        
        
        
        
        
        
        return tcell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 71
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Weather App"
        
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
