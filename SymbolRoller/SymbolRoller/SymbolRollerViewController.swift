//
//  SymbolRollerViewController.swift
//  SymbolRoller
//
//  Created by 장재훈 on 2022/05/02.
//

import UIKit

class SymbolRollerViewController: UIViewController {
    
    // 이미지 system names
    let symbols: [String] = ["sun.min", "moon", "cloud", "wind", "snowflake"]

    // interface builder 에 있는 UIComponent 와 코드를 연결
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    // 화면이 보여지기 전에 준비를 하는 시간
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(systemName: "cloud")
        print("view did load")
        // Do any additional setup after loading the view.
    }
    
    // 화면이 보여질 준비가 되었을때
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
    }
    
    // 화면이 보여지고 나서
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }
    
    // 이벤트를 연결
    @IBAction func buttonTapped(_ sender: UIButton) {
        print("button tapped!")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
