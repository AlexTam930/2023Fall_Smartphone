//
//  ViewController.swift
//  NamePhoneNumber
//
//  Created by Alex.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var nameTxtField : UITextField?
    var phoneTxtField : UITextField?
    
    
    var names: [String] = [String]()
    var phoneNumbers: [String] = [String]()

    
    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func addNameAndPhoneNumber(_ sender: Any) {
        let myAlertController = UIAlertController(title: "Add Name and Phone number", 
                                                message: "", preferredStyle: .alert)
                let saveButton = UIAlertAction(title: "Save", style:.default) { action in
                    guard let name = self.nameTxtField?.text else {return }
                    guard let phoneNumber = self.phoneTxtField?.text else {return }
                    
                    // if content is empty, then return and give a hint.
                    if(name.count == 0 || phoneNumber.count == 0) {
                        let alarmAlertController = UIAlertController(title: "Content is empty, please type in valid content.",message: nil, preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alarmAlertController.addAction(okAction)
                        self.present(alarmAlertController, animated: true, completion: nil)
                        return
                    }

                    self.names.append(name)
                    self.phoneNumbers.append(phoneNumber)
                    self.tblView.reloadData()

                }
                let cancelButton = UIAlertAction(title: "Cancel", style:.cancel) { action in
                    print("You click a cancel button.")
                }
                myAlertController.addAction(saveButton)
                myAlertController.addAction(cancelButton)

                
                myAlertController.addTextField{ txtField in
                    txtField.placeholder = "Please type in the name"
                    self.nameTxtField = txtField
                }
                
                myAlertController.addTextField{ txtField in
                    txtField.placeholder = "Please type in the phoneNumber"
                    self.phoneTxtField = txtField
                }
                self.present(myAlertController, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Name: \(names[indexPath.row]) Phone: \(phoneNumbers[indexPath.row])"
        return cell
    }
    
}

