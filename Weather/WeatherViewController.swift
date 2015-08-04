

import UIKit
import CoreLocation



class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    var location : CLLocation?
    
    let locationManager = CLLocationManager()

//    
//    @IBOutlet weak var cityLabel: UILabel!
//    @IBOutlet weak var rainLabel: UILabel!
//    @IBOutlet weak var rainLabel2: UILabel!
//    @IBOutlet weak var desLabel: UILabel!
//    @IBOutlet weak var desLabel2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.distanceFilter  = 3000 // Must move at least 3km
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer // Accurate within a kilometer
        self.locationManager.startUpdatingLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        location = locations.last as? CLLocation
        println("\(location!.coordinate.latitude), \(location!.coordinate.longitude)")
        
        searchWeather()
    }
    
    func searchWeather() {
        let urlPath = "http://api.openweathermap.org/data/2.5/forecast?lat=\(location!.coordinate.latitude)&lon=\(location!.coordinate.longitude)"
        let url = NSURL(string: urlPath)
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!){(data, response, error) in
            dispatch_async(dispatch_get_main_queue(), {
                self.displayWeather(data)
                
            })
        }
        task.resume()
    }
    func displayWeather(weatherData: NSData)
        
    {    var error: NSError?
        let jsonObject : AnyObject! = NSJSONSerialization.JSONObjectWithData(weatherData, options: nil, error: &error) as! NSDictionary
        
        
        //Return precipitation volume mm per 3 hours
        if let rain0 = jsonObject["list"]!!.objectAtIndex(0).objectForKey("rain")?.objectForKey("3h") as? Double {
            println(rain0)
        }
        
        else {println("No rain found 0")
            
        }
        
        if let dtTime0 = jsonObject["list"]!!.objectAtIndex(0).objectForKey("dt_txt") as? String{
            println(dtTime0)
            
        }
        
        if let rain = jsonObject["list"]!!.objectAtIndex(1).objectForKey("rain")?.objectForKey("3h") as? Double {
            println("\(rain)")
        }
        else {
            println("No rain found")
        }
        
        if let dtTime = jsonObject["list"]!!.objectAtIndex(1).objectForKey("dt_txt") as? String{
            println(dtTime)
            
        }
        
        if let rain2 = jsonObject["list"]!!.objectAtIndex(2).objectForKey("rain")?.objectForKey("3h") as? String {
            println("\(rain2)")
            
        }
        else {
            println("No rain found2")
        }
        
        if let dtTime2 = jsonObject["list"]!!.objectAtIndex(2).objectForKey("dt_txt") as? String {
            println(dtTime2)
        }
        
        if let rain3 = jsonObject["list"]!!.objectAtIndex(3).objectForKey("rain")?.objectForKey("3h") as? Double { println(rain3)}
        else{println("No rain found3")}
        
        if let dtTime3 = jsonObject["list"]!!.objectAtIndex(3).objectForKey("dt_txt") as? String {
            println(dtTime3)
        }
        
        if let rain4 = jsonObject["list"]!!.objectAtIndex(4).objectForKey("rain")?.objectForKey("3h") as? Double { println(rain4)}
        else{println("No rain found4")}
        
        if let dtTime4 = jsonObject["list"]!!.objectAtIndex(4).objectForKey("dt_txt") as? String {
            println(dtTime4)
        }
        
        if let rain5 = jsonObject["list"]!!.objectAtIndex(5).objectForKey("rain")?.objectForKey("3h") as? Double { println(rain5)}
        else{println("No rain found5")}
        
        if let dtTime5 = jsonObject["list"]!!.objectAtIndex(5).objectForKey("dt_txt") as? String {
            println(dtTime5)
        }
        
        if let rain6 = jsonObject["list"]!!.objectAtIndex(6).objectForKey("rain")?.objectForKey("3h") as? Double { println(rain6)}
        else{println("No rain found6")}
        
        if let dtTime6 = jsonObject["list"]!!.objectAtIndex(6).objectForKey("dt_txt") as? String {
            println(dtTime6)
        }
        
        if let rain7 = jsonObject["list"]!!.objectAtIndex(7).objectForKey("rain")?.objectForKey("3h") as? Double { println(rain7)}
        else{println("No rain found7")}
        
        if let dtTime7 = jsonObject["list"]!!.objectAtIndex(7).objectForKey("dt_txt") as? String {
            println(dtTime7)
        }
        
        if let rain8 = jsonObject["list"]!!.objectAtIndex(8).objectForKey("rain")?.objectForKey("3h") as? Double { println(rain8)}
        else{println("No rain found8")}
        
        if let dtTime8 = jsonObject["list"]!!.objectAtIndex(8).objectForKey("dt_txt") as? String {
            println(dtTime8)
        }
        
        
        
        
    }
}