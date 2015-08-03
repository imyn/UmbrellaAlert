
import UIKit
import CoreLocation
import Parse

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var cityLabel: UILabel!
//    @IBOutlet weak var stateLabel: UILabel!
//    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var rainLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getWeather("http://api.openweathermap.org/data/2.5/forecast?lat=35&lon=139")
        
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.distanceFilter  = 3000 // Must move at least 3km
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer // Accurate within a kilometer
        self.locationManager.startUpdatingLocation()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
   
    func getLocationInfo (location : CLLocation)
    {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            if error != nil
            {
                println("Error: " + error.localizedDescription)
            }
            else
            {
                let placemark = placemarks.last as! CLPlacemark
                
                                let userInfo = [
                                    "city":     placemark.locality,
//                                    "state":    placemark.administrativeArea,
//                                    "country":  placemark.country
                                ]
                
                println("Location:  \(userInfo)")
                self.updateUIWithLocation(placemark)
               
                
            }
        })
    }
    

    func updateUIWithLocation (location: CLPlacemark)
    {
        updateLabel(location.locality, label: cityName)
//        updateLabel(location.administrativeArea, label: stateLabel)
//        updateLabel(location.country, label: countryLabel)
        
    }
    
    

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
            let location = locations.last as! CLLocation
        

        
        
        var latNLng = "Lat & Lng:  \(location.coordinate.latitude), \(location.coordinate.longitude)"
        
        
       
        
        println(latNLng)
        
        updateLabel(latNLng, label: textLabel)

        getLocationInfo(location)
    }
    
    func updateLabel(stringLabel: String, label: UILabel)
    {
        
        label.text = stringLabel
    }
    
    func getWeather(urlPath: String){
        let url = NSURL(string: urlPath)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: {(data, response, error) -> Void in
            println("Task completed")
            
            if(error != nil) {
                // If there is an error in the web request, print it to the console
                println(error.localizedDescription)
            }
            
            self.displayWeather(data)
            
        })
        
        task.resume()
    }
    
    func displayWeather(weatherData: NSData)
        
    {    var error: NSError?
        let jsonObject : AnyObject! = NSJSONSerialization.JSONObjectWithData(weatherData, options: nil, error: &error) as! NSDictionary
        
        
        if let country = jsonObject["city"]!!.objectForKey("name") as? String {
            cityLabel.text =  country
        }
        
        if let rain = jsonObject["list"]!!.objectAtIndex(1).objectForKey("rain")?.objectForKey("3h") as? Double {
            rainLabel.text = "\(rain)"
        }
        else {
            println("No rain found")
        }
        
        
    }
}
