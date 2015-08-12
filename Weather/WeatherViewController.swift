
import UIKit
import CoreLocation



class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var umbrellaStatus: UIImageView!
    
    var location : CLLocation?
    var rainArray: [Double] = []
    var arrayStartPosition : Int = 0
    var todayArray: [Double] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    var dayRecommendation: Int = 0
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad(){ //Start the location manager
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.distanceFilter  = 3000 // Must move at least 3km
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer // Accurate within a kilometer
        self.locationManager.startUpdatingLocation()
        
}
    
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
    }
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) { //Get user's current latitude and longtitude
        location = locations.last as? CLLocation
        println("\(location!.coordinate.latitude), \(location!.coordinate.longitude)")
        
        searchWeather()
    }
    
    func searchWeather(){ //Call weather API
        let urlPath = "http://api.openweathermap.org/data/2.5/forecast?lat=\(location!.coordinate.latitude)&lon=\(location!.coordinate.longitude)"
        let url = NSURL(string: urlPath)
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!){(data, response, error) in
            dispatch_async(dispatch_get_main_queue(), {
                self.resetArrays()
                self.organizeData(data)
                self.updateTodayArray()
                self.interpretData()
                self.displayResult()
                
            })
        }
        task.resume()
    }
    
    func resetArrays(){
        rainArray = []
        todayArray = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
        }
    
    
    func organizeData(weatherData: NSData){ //organize obtained data
        
        var error: NSError?
        let jsonObject : AnyObject! = NSJSONSerialization.JSONObjectWithData(weatherData, options: nil, error: &error) as! NSDictionary
        
        if let name = jsonObject["city"]!!.objectForKey("name") as? String { //Display city name on viewcontroller
            cityLabel.text =  name
            // TODO: save to property instead and update display elsewhere
        }

        
        for j in 0...7 { //grab first 8 entries of 3-hour rain forecast and put them in an array
            if let rain = jsonObject["list"]!!.objectAtIndex(j).objectForKey("rain")?.objectForKey("3h") as? Double {
                rainArray.append(rain)
            }   // check if rain0...7 == "rain"
                // if yes, append Double value
                // else, append 0.0 as Double
                
            else {
                rainArray.append(0.0)
            }
        }
        print("RainArray: ")
        println(rainArray)
    
        //Get first dt from dtArray
        if  let var firstDt = jsonObject["list"]!!.objectAtIndex(0).objectForKey("dt") as? Double {

        //Take first dt in dtArray
        let date = NSDate(timeIntervalSince1970: firstDt)
        
        //Convert dt to 24hour string format
        let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "h" //A 1-12 based hour with at least 1 digit
            dateFormatter.timeZone = NSTimeZone.localTimeZone() //Use current timezone
            let localDate = dateFormatter.stringFromDate(date)
           
            println(localDate)
            

            //save to a property
            var bucket = localDate.toInt()! / 3
            
            //Set obtained "bucket" as the new starting point
            arrayStartPosition = bucket
        
            }
}
    
    
    func updateTodayArray(){ //Use "bucket" as the starting point of todayArray
        var startPosition = arrayStartPosition // use property value
        var endPosition = 7 - startPosition
    
        for i in 0...endPosition {
            let rainInt = rainArray[i]
            todayArray[startPosition] = rainInt
            startPosition += 1
            
            }
       
        print("todayArray: ")
        println(todayArray)
        
}
        
    
    func interpretData() {
    
        
        for i in 0...7 {
            var rain: Double = todayArray[i]
            var localRecommendation: Int = 0
            
            if rain <= 2.00 {
                
                localRecommendation = 0
                
            }
            
            else if rain > 2.00 && rain <= 5.00 {
                
                localRecommendation = 1
                            }
            
            else
            {
               
                localRecommendation = 2
                
            }
            
            if localRecommendation > dayRecommendation {
                dayRecommendation = localRecommendation
            }
            
        }
}

    
    func displayResult(){
        
        switch dayRecommendation {
                    
        case 0:
                println("No Umbrella")
                self.umbrellaStatus.image = UIImage(named: "noUmbrella")

        case 1:
                println("Maybe Umbrella")
              
                self.umbrellaStatus.image = UIImage(named: "moderateRain")
            
        case 2:
                println("Umbrella Alert!")

                self.umbrellaStatus.image = UIImage(named: "heavyRain")
            
        default:
                print(self.dayRecommendation)
            

        
}
}
}