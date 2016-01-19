# myYahooWeather
參考資料：
1. https://github.com/hsiaoplay/YahooWeather
2. https://github.com/jianyaoang/Yahoo-Weather-Replica

## 使用技術部份
* [擷取JSON（get JSON）](#get JSON)
* [修改標題視圖高度&文字及顏色（Set Height & Font and Color）](#Set Height & Font and Color)
* [參考資料來源（Origin）](#Origin)

### 索引字串（get JSON）
參考hsiaoplay的擷取Json部分
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

```
