//
//  ViewController.swift
//  ValidateIt
//
//  Created by juanfv2@gmail.com on 06/05/2017.
//  Copyright (c) 2017 juanfv2@gmail.com. All rights reserved.
//

import UIKit
import ValidateIt

class ViewController: UIViewController {


    // MARK: - IBOutlets
    @IBOutlet weak var lblErrors: UILabel!

    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtPhone: UITextField!

    // MARK: - Properties

    var validation: ValidateIt!

    // MARK: - Initializers methods

    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()

        validation = ValidateIt()
        
        textFieldBorder(txtFirstName)
        textFieldBorder(txtLastName)
        textFieldBorder(txtEmail)
        textFieldBorder(txtPassword)
        textFieldBorder(txtConfirmPassword)
        textFieldBorder(txtPhone)
    }

    // MARK: - Private methods

    // MARK: - Public methods

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        view.endEditing(true)

    }

    // MARK: - IBActions

    @IBAction func actValidate(_ sender: UIButton) {

        view.endEditing(true)

        validation.errors.removeAll()

        validation.required(txtFirstName)
        validation.required(txtLastName)
        
        if !txtLastName.text!.isEmpty {
            validation.lettersSpaceOnly(txtLastName)
        }
        
        validation.required(txtEmail)
        
        
        if !txtEmail.text!.isEmpty {
            validation.email(txtEmail)
        }

        validation.required(txtPassword)

        if !txtPassword.text!.isEmpty {
            validation.minLength(6, textField: txtPassword)
        }
        
        validation.required(txtConfirmPassword, msgError: "Confirm the password")
        
        if !txtPassword.text!.isEmpty && !txtConfirmPassword.text!.isEmpty {
            validation.textField(txtPassword, equalTotextField: txtConfirmPassword, msgError: "Passwords no match.")
        }

        print("\(self.classForCoder) \(#function) \(#line)- validation: \(validation.errors)")

        if validation.isValid() {

            lblErrors.text = " Validated "
            lblErrors.backgroundColor = .blue

        } else {

            lblErrors.text = validation.errors.joined(separator: "\n")
            lblErrors.backgroundColor = .red

        }
    }

    func textFieldBorder(_ textField: UITextField) {
        textField.layer.cornerRadius = 8.0
        textField.layer.masksToBounds = true
        textField.layer.borderColor = UIColor.blue.cgColor
        textField.layer.borderWidth = 1.0
    }

    // MARK: - Target-Action methods

    // MARK: - Notification handler methods

    // MARK: - Navigation


}

