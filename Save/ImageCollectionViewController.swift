//
//  ViewController.swift
//  Save
//
//  Created by Глеб Капустин on 14.09.2023.
//

import UIKit

final class ImageCollectionViewController: UIViewController {
    private var storage: StorageProtocol?
    
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var saveButton: UIButton!
    
    @IBOutlet weak var showButton: UIButton!
    @IBAction func showText(_ sender: Any) {
        textField.text = storage?.text
    }
    @IBAction private func onMadeBlackAndWhiteButton(_ sender: Any) {
        storage?.text = textField.text
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flag: Bool = true
        if flag
        {
            storage = KeychainStorage()
        } else {
            storage = UserDefaultsStorage()
        }
        createUI()
       // createConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textField.text = storage?.text
        
    }

}


private extension ImageCollectionViewController {
    func createUI(){
        view.backgroundColor = .lightGray
        
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.backgroundColor = .white
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.setTitleColor(.systemBlue, for: .highlighted)
        saveButton.layer.cornerRadius = 4
        
        showButton.setTitle("Показать", for: .normal)
        showButton.backgroundColor = .white
        showButton.setTitleColor(.black, for: .normal)
        showButton.setTitleColor(.systemBlue, for: .highlighted)
        showButton.layer.cornerRadius = 4
    }
    
    func createConstraints(){
        view.addSubview(textField)
        view.addSubview(saveButton)
    }
}
