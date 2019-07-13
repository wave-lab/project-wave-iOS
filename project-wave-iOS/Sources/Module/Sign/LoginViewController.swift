//
//  LoginViewController.swift
//  project-wave-iOS
//
//  Created by yejin on 11/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import UIKit

class LoginViewController: ViewController {
  
  @IBOutlet weak var idLabel: UILabel!
  @IBOutlet weak var passwordLabel: UILabel!
  @IBOutlet weak var idTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  @IBOutlet weak var loginBtn: UIButton!
  @IBOutlet weak var loginBottomConstraint: NSLayoutConstraint!
  
  var check: Bool = true
  var identityConstant: CGFloat!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    identityConstant = loginBottomConstraint.constant
    initGestureRecognizer()
    idTextField.addTarget(self, action: #selector(handleTextDidChange(_:)), for: .editingChanged)
    passwordTextField.addTarget(self, action: #selector(handleTextDidChange(_:)), for: .editingChanged)
    idTextField.keyboardAppearance = .dark
    passwordTextField.keyboardAppearance = .dark
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.registerForKeyboardNotifications()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    view.endEditing(true)
    self.unregisterForKeyboardNotifications()
  }
  
  @IBAction func dismissButton(_ sender: Any) {
    self.dismiss(animated: true)
  }
  
  
}

extension LoginViewController {
  
  @objc func handleTextDidChange(_ sender: UITextField) {
    if sender.text == "" {
      UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
        if sender == self.idTextField {
          self.idLabel.transform = .identity
          self.idLabel.alpha = 1
        } else {
          self.passwordLabel.transform = .identity
          self.passwordLabel.alpha = 1
        }
      })
    } else {
      UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
        if sender == self.idTextField {
          self.idLabel.transform = CGAffineTransform(scaleX: 12 / 16, y: 12 / 16).translatedBy(x: -10, y: -28)
          self.idLabel.alpha = 0.7
        } else {
          self.passwordLabel.transform = CGAffineTransform(scaleX: 12 / 16, y: 12 / 16).translatedBy(x: -10, y: -28)
          self.passwordLabel.alpha = 0.7
        }
      })
    }
  }
}

extension LoginViewController: UIGestureRecognizerDelegate {
  func initGestureRecognizer() {
    let mainTap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
    mainTap.delegate = self
    view.addGestureRecognizer(mainTap)
  }
  
  @objc func handleTap(_ sender: UITapGestureRecognizer) {
    view.endEditing(true)
  }
  
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
    if (touch.view?.isDescendant(of: idTextField))! || (touch.view?.isDescendant(of: passwordTextField))! {
      return false
    }
    return true
  }
  
  func registerForKeyboardNotifications() {
    NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  func unregisterForKeyboardNotifications() {
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  @objc func keyboardWillShow(notification: NSNotification) {
    if check {
      if let info = notification.userInfo {
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let duration = info[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        UIView.animate(withDuration: duration) {
          self.loginBottomConstraint.constant = keyboardFrame.height + 20
          self.view.layoutIfNeeded()
        }
      }
      check = false
    }
  }
  
  @objc func keyboardWillHide(notification: NSNotification) {
    if let info = notification.userInfo {
      let duration = info[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
      UIView.animate(withDuration: duration) {
        self.loginBottomConstraint.constant = self.identityConstant
        self.view.layoutIfNeeded()
      }
    }
    check = true
  }
}
