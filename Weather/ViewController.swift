
import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
   
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    
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
        // Dispose of any resources that can be recreated.
    }
    
    
    

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
            let location = locations.last as! CLLocation
        
        var latNLng = "Lat & Lng:  \(location.coordinate.latitude), \(location.coordinate.longitude)"
        
        println(latNLng)
        
        updateLabel(latNLng, label: textLabel, cityLabel: cityLabel, stateLabel: stateLabel, countryLabel: countryLabel)

        
    }
    
    func updateLabel(stringLabel: String, label: UILabel, cityLabel: UILabel, stateLabel: UILabel, countryLabel: UILabel)
    {
        
        label.text = stringLabel
        
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
                    "state":    placemark.administrativeArea,
                    "country":  placemark.country
                ]
                
                
                println("Location:  \(userInfo)")
                //NSNotificationCenter.defaultCenter().postNotificationName("LOCATION_AVAILABLE", object: nil, userInfo: userInfo)
                
                
            }
            
        })
        
    }
   

}

