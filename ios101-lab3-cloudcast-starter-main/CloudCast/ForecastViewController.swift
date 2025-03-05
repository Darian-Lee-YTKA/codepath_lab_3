//
//  ForecastViewController.swift
//  CloudCast
//
//  Created by Darian Lee on 3/5/25.
//

import UIKit

class ForecastViewController: UIViewController {

    @IBOutlet var place_image: UIImageView!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var forwardButton: UIButton!
    @IBOutlet var temp_label: UILabel!
    @IBOutlet var forecast_label: UILabel!
    @IBOutlet var date_label: UILabel!
    @IBOutlet var location_label: UILabel!
    @IBOutlet var forecast_image: UIImageView!
    private var forecasts = [WeatherForecast]() // tracks all the possible forecasts
        private var selectedForecastIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forecasts = createMockData()
                configure(with: forecasts[selectedForecastIndex]) // configure the UI to show the first mock data
            }
            private func createMockData() -> [WeatherForecast] {
            // This is just using the Calendar API to get a few random dates
            let today = Date()
            var dateComponents = DateComponents()
            dateComponents.day = 1
            let tomorrow = Calendar.current.date(byAdding: dateComponents, to: today)!
            let dayAfterTomorrow = Calendar.current.date(byAdding: dateComponents, to: tomorrow)!
            // Create a few mock data to show
                let mockData1 = WeatherForecast(location:"Москва",
                                            weatherCode: .violentRainShowers,
                                            temperature: 59.5,
                                                date:today, image:"москва")
            let mockData2 = WeatherForecast(location:"Воронеж",
                                            weatherCode: .fog,
                                            temperature: 65.5,
                                            date: tomorrow, image:"воронеж")
            let mockData3 = WeatherForecast(location:"Казань",
                                            weatherCode: .partlyCloudy,
                                            temperature: 49.5,
                                            date: dayAfterTomorrow, image:"казань")
            return [mockData1, mockData2, mockData3]
        }
    
        
          private func configure(with forecast: WeatherForecast) {
              location_label.text = forecast.location
              forecast_image.image = forecast.weatherCode.image
            forecast_label.text = forecast.weatherCode.description
            temp_label.text = "\(forecast.temperature)°F"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM d, yyyy"
            date_label.text = dateFormatter.string(from: forecast.date)
              place_image.image = UIImage(named: forecast.image)
             
              
          }
    
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        selectedForecastIndex = max(0, selectedForecastIndex - 1) // don't go lower than 0 index
        print("tapped back!")
        configure(with: forecasts[selectedForecastIndex]) // change the forecast shown in the UI
    }

    
    @IBAction func didTapForwardButton(_ sender: UIButton) {
        selectedForecastIndex = min(forecasts.count - 1, selectedForecastIndex + 1) // don't go higher than the number of forecasts
        print("tapped front!")
        configure(with: forecasts[selectedForecastIndex]) // change the forecast shown in the UI
    }
    
        }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



struct WeatherForecast {
    let location: String
    let weatherCode: WeatherCode
  let temperature: Double
  let date: Date
    let image: String
}

enum WeatherCode {
  case clearSky
  case mainlyClear
  case partlyCloudy
  case overcast
  case fog
  case lightDrizzle
  case moderateDrizzle
  case denseDrizzle
  case slightRainShowers
  case moderateRainShowers
  case violentRainShowers

    var description: String {
        switch self {
        case .clearSky:
          return "Ясное небо"
        case .mainlyClear:
          return "Преимущественно ясно"
        case .partlyCloudy:
          return "Переменная облачность"
        case .overcast:
          return "Пасмурно"
        case .fog:
          return "Туман"
        case .lightDrizzle:
          return "Лёгкая морось"
        case .moderateDrizzle:
          return "Умеренная морось"
        case .denseDrizzle:
          return "Сильная морось"
        case .slightRainShowers:
          return "Небольшие ливни"
        case .moderateRainShowers:
          return "Умеренные ливни"
        case .violentRainShowers:
          return "Сильные ливни"
        }
      }

  var image: UIImage? {
    switch self {
    case .clearSky, .mainlyClear:
      return UIImage(named: "sun")
    case .partlyCloudy:
      return UIImage(named: "cloud-sun")
    case .overcast:
      return UIImage(named: "cloud")
    case .fog:
      return UIImage(named: "fog")
    case .lightDrizzle, .moderateDrizzle, .denseDrizzle:
      return UIImage(named: "drizzle")
    case .slightRainShowers, .moderateRainShowers, .violentRainShowers:
      return UIImage(named: "cloud-drizzle")
    }
  }
}
