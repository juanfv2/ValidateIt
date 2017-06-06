# ValidateIt

[![CI Status](http://img.shields.io/travis/juanfv2@gmail.com/ValidateIt.svg?style=flat)](https://travis-ci.org/juanfv2@gmail.com/ValidateIt)
[![Version](https://img.shields.io/cocoapods/v/ValidateIt.svg?style=flat)](http://cocoapods.org/pods/ValidateIt)
[![License](https://img.shields.io/cocoapods/l/ValidateIt.svg?style=flat)](http://cocoapods.org/pods/ValidateIt)
[![Platform](https://img.shields.io/cocoapods/p/ValidateIt.svg?style=flat)](http://cocoapods.org/pods/ValidateIt)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

##Use

![](/screen-1.png)

```swift
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
```
## Requirements

## Installation

ValidateIt is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ValidateIt"
```

## Author

Juan Villalta, juanfv2@gmail.com

## License

ValidateIt is available under the MIT license. See the LICENSE file for more info.
