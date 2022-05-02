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
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var label: UILabel!
    @IBOutlet var button: UIButton!

    // 화면이 보여지기 전에 준비를 하는 시간
    override func viewDidLoad() {
        super.viewDidLoad()

        reload()
    }

    // 화면이 보여질 준비가 되었을때
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // 화면이 보여지고 나서
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // DRY ?
    // Do not Repeat Yourself -> 중복된 코드 X
    func reload() {
        // TO-DO:
        // - symbol 리스트에서 임의로 하나를 추출해서
        // - 이미지와 텍스트를 설정한다

        // return 값은 optional
        let symbol = symbols.randomElement()!
        imageView.image = UIImage(systemName: symbol)
        label.text = symbol
    }

    // 이벤트를 연결
    @IBAction func buttonTapped(_ sender: UIButton) {
        reload()
    }
}
