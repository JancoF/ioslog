//
//  ViewController.swift
//  FloresSnapchat
//
//  Created by Noe Flores on 20/05/24.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import SwiftUI


class iniciarSesionViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    
   
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func iniciarSesionTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password:  passwordTextField.text!){(user, error) in
            print("Intentando iniciar sesion")
            if error != nil{
                print("Se presento el siguiente error: (error)")
                Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                print("Intentando crear un usuario")
                if error != nil{
                print("Se presento el siguiente error al crear el usuario: (error!)")
                }else{
                print("El usuario fue creado exitosamente")
                    Database.database().reference().child("usuarios").child(user!.user.uid).child("email").setValue(user!.user.email)
                    self.performSegue(withIdentifier: "iniciarsesionsegue", sender:nil)
                    
                    let alerta = UIAlertController(title: "Creacion de Usuario", message: "Usuario: (self.emailTextField.text!) se creo correctamente.", preferredStyle: .alert)
                    let btnOK = UIAlertAction(title: "Aceptar", style: .default, handler: { (UIAlertAction) in
                    self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
                    })
                    alerta.addAction(btnOK)
                    self.present(alerta, animated: true, completion: nil)
                }
                })
            }else{
                print("Inicio de sesion exitoso")
                self.performSegue(withIdentifier: "iniciarsesionsegue", sender:nil)

                
            }
        }
    }
    
    
    @IBAction func iniciarSesionConGoogleTapped(_ sender: Any) {
//        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
//        let config = GIDConfiguration(clientID: clientID)
//        GIDSignIn.sharedInstance().signIn(with: config, presenting: self) { user, error in
//            if let error = error {
//                print("Error al iniciar sesión con Google: \(error.localizedDescription)")
//                return
//            }
//
//            guard let authentication = user?.authentication else {
//                print("No se pudo obtener la autenticación de Google")
//                return
//            }
//
//            let credentials = GoogleAuthProvider.credential(withIDToken: authentication.idToken!, accessToken: authentication.accessToken)
//
//            Auth.auth().signIn(with: credentials) { (authResult, error) in
//                if let error = error {
//                    print("Error al iniciar sesión con Firebase: \(error.localizedDescription)")
//                    return
//                }
//
//                print("Inicio de sesión con Google exitoso")
//
//            }
//            let firebaseAuth = Auth.auth()
//            do {
//              try firebaseAuth.signOut()
//            } catch let signOutError as NSError {
//              print("Error signing out: %@", signOutError)
//            }
//        }
    }

}

