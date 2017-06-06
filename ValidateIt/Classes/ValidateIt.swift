
import UIKit

public class ValidateIt: NSObject {


    // MARK: - Properties

    public var errors = [String]()

    var borderColorBackup = [UITextField: CGColor]()

    // MARK: - Private methods

    public func email(_ textField: UITextField, msgError msg: String? = nil) {

        textField.delegate = self

        if let text = textField.text {

            let emailRegEx: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
            let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)

            if !emailTest.evaluate(with: text) {

                borderColorBackup[textField] = textField.layer.borderColor

                textField.layer.borderColor = UIColor.red.cgColor

                let m = msg ?? String(format: localizedStringFor(key: "validateit.invalid"), textField.placeholder ?? "")

                errors.append(m)

                addView2Right(textField)

            } else {

                reset(textField: textField)

            }

        }
    }

    public func required(_ textField: UITextField, msgError msg: String? = nil) {

        textField.delegate = self

        if textField.text!.isEmpty {

            borderColorBackup[textField] = textField.layer.borderColor

            textField.layer.borderColor = UIColor.red.cgColor

            let m = msg ?? String(format: localizedStringFor(key: "validateit.required"), textField.placeholder ?? "")

            errors.append(m)

            addView2Right(textField)

        } else {

            reset(textField: textField)

        }

    }

    public func textField(_ tfValue1: UITextField, equalTotextField tfValue2: UITextField, msgError msg: String? = nil) {

        tfValue1.delegate = self
        tfValue2.delegate = self

        if tfValue1.text != tfValue2.text {


            borderColorBackup[tfValue1] = tfValue1.layer.borderColor
            tfValue1.layer.borderColor = UIColor.red.cgColor

            borderColorBackup[tfValue2] = tfValue2.layer.borderColor
            tfValue2.layer.borderColor = UIColor.red.cgColor

            let m = msg ?? String(format: localizedStringFor(key: "validateit.notequal"), tfValue1.placeholder ?? "", tfValue2.placeholder ?? "")

            errors.append(m)

            addView2Right(tfValue1)
            addView2Right(tfValue2)
        } else {

            reset(textField: tfValue1)
            reset(textField: tfValue2)

        }
    }

    public func lettersSpaceOnly(_ textField: UITextField, msgError msg: String? = nil) {

        textField.delegate = self

        let lettersSpaceRegex: String = "[a-zA-z]+([ '-][a-zA-Z]+)*$"
        let lettersSpaceTest = NSPredicate(format: "SELF MATCHES %@", lettersSpaceRegex)

        if var text = textField.text {
            print("\(self.classForCoder) \(#function) \(#line)- text: \"\(text)\"")
            text = text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            print("\(self.classForCoder) \(#function) \(#line)- text: \"\(text)\"")

            if !lettersSpaceTest.evaluate(with: text) {

                borderColorBackup[textField] = textField.layer.borderColor

                textField.layer.borderColor = UIColor.red.cgColor

                let m = msg ?? String(format: localizedStringFor(key: "validateit.contain"), textField.placeholder ?? "")

                errors.append(m)

                addView2Right(textField)

            } else {

                textField.text = text

                reset(textField: textField)

            }
        }
    }

    public func minLength(_ length: Int, textField: UITextField, msgError msg: String? = nil) {

        textField.delegate = self

        if textField.text!.characters.count < length {

            borderColorBackup[textField] = textField.layer.borderColor

            textField.layer.borderColor = UIColor.red.cgColor

            let m = msg ?? String(format: localizedStringFor(key: "validateit.minimum"), textField.placeholder ?? "", length)

            errors.append(m)

            addView2Right(textField)

        } else {

            reset(textField: textField)

        }
    }

    public func maxLength(_ length: Int, textField: UITextField, msgError msg: String? = nil) {

        textField.delegate = self

        if textField.text!.characters.count > length {

            borderColorBackup[textField] = textField.layer.borderColor

            textField.layer.borderColor = UIColor.red.cgColor

            let m = msg ?? String(format: localizedStringFor(key: "validateit.maximum"), textField.placeholder ?? "", length)

            errors.append(m)

            addView2Right(textField)

        } else {

            reset(textField: textField)

        }
    }

    public func isValid() -> Bool {
        return errors.count == 0
    }

    // MARK: - Public methods

    func localizedStringFor(key: String) -> String {

        var bundle = Bundle(for: ValidateIt.self)

        if let resourcePath = bundle.path(forResource: "ValidateIt", ofType: "bundle") {
            if let resourcesBundle = Bundle(path: resourcePath) {
                bundle = resourcesBundle
            }
        }

        return bundle.localizedString(forKey: key, value: nil, table: nil)
    }

    func reset(textField: UITextField) {

        removeViewRight(textField)

        textField.layer.borderColor = borderColorBackup[textField]
    }

    func addView2Right(_ tf: UITextField) {

        // icon
        var bundle = Bundle(for: ValidateIt.self)

        if let resourcePath = bundle.path(forResource: "ValidateIt", ofType: "bundle") {
            if let resourcesBundle = Bundle(path: resourcePath) {
                bundle = resourcesBundle
            }
        }

        let icon = UIImage(named: "error", in: bundle, compatibleWith: nil)
        let image = UIImageView(image: icon)
        image.tintColor = .red
        image.contentMode = .scaleAspectFit

        tf.addSubview(image)

        image.translatesAutoresizingMaskIntoConstraints = false

        let imgTopConstraint = NSLayoutConstraint(item: image, attribute: .top, relatedBy: .equal, toItem: tf, attribute: .top, multiplier: 1.0, constant: 5)
        let imgTrailingConstraint = NSLayoutConstraint(item: image, attribute: .trailing, relatedBy: .equal, toItem: tf, attribute: .trailing, multiplier: 1.0, constant: -5)
        let imgBottomConstraint = NSLayoutConstraint(item: image, attribute: .bottom, relatedBy: .equal, toItem: tf, attribute: .bottom, multiplier: 1.0, constant: -5)

        tf.addConstraints([imgTopConstraint, imgTrailingConstraint, imgBottomConstraint])


    }

    func removeViewRight(_ tf: UITextField) {
        for v in tf.subviews {
            if v is UIImageView {
                v.removeFromSuperview()
            }
        }
    }
}

// MARK: - UITextFieldDelegate

extension ValidateIt: UITextFieldDelegate {

    public func textFieldDidBeginEditing(_ textField: UITextField) {

        reset(textField: textField)

    }

}
