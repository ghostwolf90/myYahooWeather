# myYahooWeather
![screenshot](https://github.com/ghostwolf90/myYahooWeather/blob/master/image/%E8%9E%A2%E5%B9%95%E5%BF%AB%E7%85%A7%202016-01-19%2018.53.30.png)

##功能說明：
#####1.擷取Yahoo Weather JSON 的台中天氣資料
#####2.提供更新功能
#####3.可以刪除TableView欄位

##參考資料：
#####1. hsiaoplay的GitHub https://github.com/hsiaoplay/YahooWeather
#####2. jianyaoang的GitHub https://github.com/jianyaoang/Yahoo-Weather-Replica

## 使用技術部份
* [擷取JSON（get JSON）](#get JSON)

### 索引字串（get JSON）
函式為hsiaoplay的擷取Json部分
```swift
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

                                let low = result.objectForKey("low") as! String
                                let lowtoint = Int(low)

                                lowArray.append((lowtoint!-32)*5/9)
                                let high = result.objectForKey("high") as! String
                                let hightoint = Int(high)

                                highArray.append((hightoint!-32)*5/9)
                                let text = result.objectForKey("text") as! String

                                textArray.append(text)
                                let day = result.objectForKey("day") as! String

                                dayArray.append(daytoCht(day))
                                let date = result.objectForKey("date") as! String
                                dateArray.append(date)
                            }
                        }
                    }
                }
            }
        }
        
    }
```
