

import UIKit
import CoreLocation



class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    var location : CLLocation?
    var rainArray: [Double]!

    
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
    {
        //var rainArray: [Double]!
        var error: NSError?
        let jsonObject : AnyObject! = NSJSONSerialization.JSONObjectWithData(weatherData, options: nil, error: &error) as! NSDictionary
        
        
        //Return precipitation volume mm per 3 hours
        if let rain0 = jsonObject["list"]!!.objectAtIndex(0).objectForKey("rain")?.objectForKey("3h") as? Double {
            println(rain0)
//            rainArray.append(rain0)
//            println(rainArray)
        }
        
        else {
            println("no rain")
            
        }
        
        if let dtTime0 = jsonObject["list"]!!.objectAtIndex(0).objectForKey("dt_txt") as? String{
            println(dtTime0)
            
        }
        
        if let rain1 = jsonObject["list"]!!.objectAtIndex(1).objectForKey("rain")?.objectForKey("3h") as? Double {
            println(rain1)
//            rainArray.append(rain1)
//            println(rainArray)
        }
        else
        {
            println("no rain")
        }
        
        if let dtTime = jsonObject["list"]!!.objectAtIndex(1).objectForKey("dt_txt") as? String{
            println(dtTime)
            
        }
        
        if let rain2 = jsonObject["list"]!!.objectAtIndex(2).objectForKey("rain")?.objectForKey("3h") as? Double {
            println(rain2)
            //rainArray.append(rain2)
            //println(rainArray)
            
        }
        else {
            println("no rain")
        }
        
        if let dtTime2 = jsonObject["list"]!!.objectAtIndex(2).objectForKey("dt_txt") as? String {
            println(dtTime2)
        }
        
        if let rain3 = jsonObject["list"]!!.objectAtIndex(3).objectForKey("rain")?.objectForKey("3h") as? Double { println(rain3)
//            rainArray.append(rain3)
//            println(rainArray)
        
        }
        
        else {
           println("no rain")
        }
        
        if let dtTime3 = jsonObject["list"]!!.objectAtIndex(3).objectForKey("dt_txt") as? String {
            println(dtTime3)

        }
        
        if let rain4 = jsonObject["list"]!!.objectAtIndex(4).objectForKey("rain")?.objectForKey("3h") as? Double { println(rain4)
//            rainArray.append(rain4)
//            println(rainArray)
        
        }
        
        else {
            println("no rain")
        }
        
        if let dtTime4 = jsonObject["list"]!!.objectAtIndex(4).objectForKey("dt_txt") as? String {
            println(dtTime4)
        }
        
        if let rain5 = jsonObject["list"]!!.objectAtIndex(5).objectForKey("rain")?.objectForKey("3h") as? Double { println(rain5)
//            rainArray.append(rain5)
//            println(rainArray)
        
        }
        
        else{
            println("no rain")
        }
        
        if let dtTime5 = jsonObject["list"]!!.objectAtIndex(5).objectForKey("dt_txt") as? String {
            println(dtTime5)
        }
        
//        if let rain6 = jsonObject["list"]!!.objectAtIndex(6).objectForKey("rain")?.objectForKey("3h") as? Double { println("\(rain6)")
//            rainArray.append(rain6)
//            println(rainArray)
        
//        
//        }
//        
//        else{
//            println("no rain")
//        }
//        
//        if let dtTime6 = jsonObject["list"]!!.objectAtIndex(6).objectForKey("dt_txt") as? String {
//            println(dtTime6)
//        }
//        
//        if let rain7 = jsonObject["list"]!!.objectAtIndex(7).objectForKey("rain")?.objectForKey("3h") as? Double { println(rain7)
//            rainArray.append(rain7)
//            println(rainArray)
        
//        }
//        
//        else{
//            println("no rain")
//        }
//        
//        if let dtTime7 = jsonObject["list"]!!.objectAtIndex(7).objectForKey("dt_txt") as? String {
//            println(dtTime7)
//        }
//        
//        if let rain8 = jsonObject["list"]!!.objectAtIndex(8).objectForKey("rain")?.objectForKey("3h") as? Double { println(rain8)
//            rainArray.append(rain8)
//            println(rainArray)
        
//        }
//        
//        else{
//            println("no rain")
//        }
//        
//        if let dtTime8 = jsonObject["list"]!!.objectAtIndex(8).objectForKey("dt_txt") as? String {
//            println(dtTime8)
//        }
//        
//    }
    
//    func compareWeather() {
//        var _basic: Double = 0.0
//        var basic: Double {
//            get{
//                return _basic
//            }
//            set(new) {
//                if new >=
//            }
//            
//        }
//       
//    }
   
}
    

}