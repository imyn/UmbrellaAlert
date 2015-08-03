

import UIKit


class RainViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var rainLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchWeather("http://api.openweathermap.org/data/2.5/forecast?lat=35&lon=139")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func searchWeather(urlPath: String) {
        //let urlPath = "http://api.openweathermap.org/data/2.5/forecast?lat={lat}&lon={lon}" + latNLng
        let url = NSURL(string:urlPath)
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
        
        if let rain = jsonObject["list"]!!.objectAtIndex(1).objectForKey("rain")?.objectForKey("3h") as? Double {
            rainLabel.text = "\(rain)"
        }
        else {
            println("No rain found")
        }
        
       
    }
}
