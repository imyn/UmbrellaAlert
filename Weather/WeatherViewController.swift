

import UIKit
import CoreLocation



class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    var location : CLLocation?
    
    let locationManager = CLLocationManager()

    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var rainLabel: UILabel!
    @IBOutlet weak var rainLabel2: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var desLabel2: UILabel!
    
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
        
        
        if let city = jsonObject["city"]!!.objectForKey("name") as? String {
            cityLabel.text =  city
        }
        
        //Return precipitation volume mm per 3 hours
        if let rain = jsonObject["list"]!!.objectAtIndex(1).objectForKey("rain")?.objectForKey("3h") as? Double {
            rainLabel.text = "\(rain)"
        }
        else {
            rainLabel.text = "No rain found"
        }
        
        if let dtTime = jsonObject["list"]!!.objectAtIndex(1).objectForKey("dt_txt") as? String{
            desLabel.text = dtTime
            
        }
        
        if let rain2 = jsonObject["list"]!!.objectAtIndex(2).objectForKey("rain")?.objectForKey("3h") as? String {
            rainLabel2.text = "\(rain2)"
            
        }
        else {
            rainLabel2.text = "No rain found"
        }
        
        if let dtTime2 = jsonObject["list"]!!.objectAtIndex(2).objectForKey("dt_txt") as? String {
            desLabel2.text = dtTime2
        }
    

}
}