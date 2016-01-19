//
//  ViewController.swift
//  MyYahooWeather
//
//  Created by Laibit on 2016/1/19.
//  Copyright © 2016年 Laibit. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    let url = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22Taichung%20City%2C%20Taiwan%20(R.O.C.)%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
    var codetoday = String()
    var datetoday = String()
    var temptoday = String()
    var texttoday = String()
    var locationCity = String()
    var codeArray = Array<String>()
    var highArray = Array<Int>()
    var lowArray = Array<Int>()
    var textArray = Array<String>()
    var dayArray = Array<String>()
    var dateArray = Array<String>()
    @IBOutlet var tableView:UITableView!

    @IBAction func refreshButtn(sender: AnyObject) {
        initArray()
        YahooWeather(url)
        self.tableView.reloadData()
    }
    
    func initArray(){
        codeArray = []
        highArray = []
        lowArray = []
        textArray = []
        dayArray = []
        dateArray = []
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        YahooWeather(url)
        //configureWeatherTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureWeatherTableView() {
        tableView.backgroundColor = UIColor.clearColor()
        tableView.tableHeaderView?.backgroundColor = UIColor.clearColor()
        
        //tableView = self.tableView.tableHeaderView
        var rect: CGRect = tableView.frame
        rect.size.height = self.view.frame.size.height
        tableView.tableHeaderView?.frame = rect
        tableView.tableHeaderView = nil
        tableView.tableHeaderView = tableView
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 110
        }
        return 80
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return codeArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.row{
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("titleCell") as! titleDataTableViewCell
            cell.weatherStatus.text = locationCity
            cell.temperatureLabel.text = temptoday + " °C"
            //cell.todayTextLabel.text = codetoday
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("forecastCell") as! weekForecastTableViewCell
            cell.dayLabel.text = "Monday"
            cell.highTemperatureLabel.text = String(highArray[indexPath.row]) + " °C"
            cell.lowTemperatureLabel.text = String(lowArray[indexPath.row]) + " °C"
            return cell
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("forecastCell") as! weekForecastTableViewCell
            cell.dayLabel.text = "Tuesday"
            cell.highTemperatureLabel.text = String(highArray[indexPath.row]) + " °C"
            cell.lowTemperatureLabel.text = String(lowArray[indexPath.row]) + " °C"
            return cell
        case 3:
            let cell = tableView.dequeueReusableCellWithIdentifier("forecastCell") as! weekForecastTableViewCell
            cell.dayLabel.text = "Wednesday"
            cell.highTemperatureLabel.text = String(highArray[indexPath.row]) + " °C"
            cell.lowTemperatureLabel.text = String(lowArray[indexPath.row]) + " °C"
            return cell
        case 4:
            let cell = tableView.dequeueReusableCellWithIdentifier("forecastCell") as! weekForecastTableViewCell
            cell.dayLabel.text = "Thursday"
            cell.highTemperatureLabel.text = String(highArray[indexPath.row]) + " °C"
            cell.lowTemperatureLabel.text = String(lowArray[indexPath.row]) + " °C"
            return cell
        case 5:
            let cell = tableView.dequeueReusableCellWithIdentifier("forecastCell") as! weekForecastTableViewCell
            cell.dayLabel.text = "Friday"
            cell.highTemperatureLabel.text = String(highArray[indexPath.row]) + " °C"
            cell.lowTemperatureLabel.text = String(lowArray[indexPath.row]) + " °C"
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("forecastCell") as! weekForecastTableViewCell
            cell.dayLabel.text = "Hello"
            return cell
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            codeArray.removeAtIndex(indexPath.row)
            highArray.removeAtIndex(indexPath.row)
            lowArray.removeAtIndex(indexPath.row)
            textArray.removeAtIndex(indexPath.row)
            dayArray.removeAtIndex(indexPath.row)
            dateArray.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        //tableView.reloadData()
        
    }
    
    func YahooWeather(url: String ){
        let url = NSURL(string: url)
        let data = try? NSData(contentsOfURL: url!, options: NSDataReadingOptions.DataReadingUncached)
        let json: AnyObject? = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
        
        if let query = json?.objectForKey("query"){
            
            if let results = query.objectForKey("results"){
                
                if let channel = results.objectForKey("channel"){
                    
                    if let locaton = channel.objectForKey("location"){
                        
                        locationCity = locaton.objectForKey("city") as! String
                    }
                    
                    if let item = channel.objectForKey("item"){
                        
                        if let today = item.objectForKey("condition"){
                            
                            codetoday = weathertoCht(today.objectForKey("code") as! String)
                            //print(codetoday)
                            datetoday = today.objectForKey("date") as! String
                            //print(datetoday)
                            temptoday = String((Int(today.objectForKey("temp") as! String)!-32)*5/9)
                            //print(temptoday)
                            texttoday = today.objectForKey("text") as! String
                            //print(texttoday)
                        }
                        
                        
                        if let forecast = item.objectForKey("forecast"){
                            for result in forecast as! NSArray
                            {
                                let code = result.objectForKey("code") as! String
                                codeArray.append(weathertoCht(code))
                                //                                print(codetoint!)
                                let low = result.objectForKey("low") as! String
                                let lowtoint = Int(low)
                                //                                print(lowtoint)
                                lowArray.append((lowtoint!-32)*5/9)
                                let high = result.objectForKey("high") as! String
                                let hightoint = Int(high)
                                //                                print(hightoint)
                                highArray.append((hightoint!-32)*5/9)
                                let text = result.objectForKey("text") as! String
                                //                                print(text)
                                textArray.append(text)
                                let day = result.objectForKey("day") as! String
                                //                                print(day)
                                dayArray.append(daytoCht(day))
                                let date = result.objectForKey("date") as! String
                                //                                print(date)
                                dateArray.append(date)
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    func daytoCht(day: String) -> String{
        
        switch day {
        case "Sun":
            return "星期日"
        case "Mon":
            return "星期一"
        case "Tue":
            return "星期二"
        case "Wed":
            return "星期三"
        case "Thu":
            return "星期四"
        case "Fri":
            return "星期五"
        case "Sat":
            return "星期六"
        default:
            return day
            
        }
        
    }
    
    func getWeek(day: Int) -> String{
        
        switch day {
        case 0:
            return "星期日"
        case 1:
            return "星期一"
        case 2:
            return "星期二"
        case 3:
            return "星期三"
        case 4:
            return "星期四"
        case 5:
            return "星期五"
        case 6:
            return "星期六"
        default:
            return "0"
            
        }
        
    }
    
    
    func weathertoCht(code:String) -> String{
        switch code{
        case "0":
            return "龍捲風"
        case "1":
            return "熱帶風暴"
        case "2":
            return "颶風"
        case "3":
            return "強雷陣雨"
        case "4":
            return "雷陣雨"
        case "5":
            return "混合雨雪"
        case "6":
            return "混合雨雪"
        case "7":
            return "混合雨雪"
        case "8":
            return "冰凍小雨"
        case "9":
            return "細雨"
        case "10":
            return "凍雨"
        case "11":
            return "陣雨"
        case "12":
            return "陣雨"
        case "13":
            return "飄雪"
        case "14":
            return "陣雪"
        case "15":
            return "吹雪"
        case "16":
            return "下雪"
        case "17":
            return "冰雹"
        case "18":
            return "雨雪"
        case "19":
            return "多塵"
        case "20":
            return "多霧"
        case "21":
            return "陰霾"
        case "22":
            return "多煙"
        case "23":
            return "狂風大作"
        case "24":
            return "有風"
        case "25":
            return "冷"
        case "26":
            return "多雲"
        case "27":
            return "晴間多雲（夜）"
        case "28":
            return "晴間多雲（日）"
        case "29":
            return "晴間多雲（夜）"
        case "30":
            return "晴間多雲（日）"
        case "31":
            return "清晰的（夜）"
        case "32":
            return "晴朗"
        case "33":
            return "晴朗（夜）"
        case "34":
            return "晴朗（日）"
        case "35":
            return "雨和冰雹"
        case "36":
            return "炎熱"
        case "37":
            return "雷陣雨"
        case "38":
            return "零星雷陣雨"
        case "39":
            return "零星雷陣雨"
        case "40":
            return "零星雷陣雨"
        case "41":
            return "大雪"
        case "42":
            return "零星陣雪"
        case "43":
            return "大雪"
        case "44":
            return "多雲"
        case "45":
            return "雷陣雨"
        case "46":
            return "陣雪"
        case "47":
            return "雷陣雨"
        case "3200":
            return "資料錯誤"
        default:
            return code
        }
    }

}

