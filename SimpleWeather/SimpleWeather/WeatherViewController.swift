//
//  WeatherViewController.swift
//  SimpleWeather
//
//  Created by 장재훈 on 2022/05/04.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var weatherImageView: UIImageView!
    @IBOutlet var temperatureLabel: UILabel!

    let cities = ["Seoul", "Tokyo", "LA", "Seattle"]
    let weathers = ["cloud.fill", "sun.max.fill", "wind", "cloud.sun.rain.fill"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func changeButtonTapped(_ sender: Any) {
        cityLabel.text = cities.randomElement()

        let imageName = weathers.randomElement()!
        weatherImageView.image = UIImage(systemName: imageName)?.withRenderingMode(.alwaysOriginal)

        let randomTemp = Int.random(in: 10 ... 30)
        temperatureLabel.text = "\(randomTemp)°"
    }
}
