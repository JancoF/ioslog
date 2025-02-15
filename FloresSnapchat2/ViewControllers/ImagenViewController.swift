//
//  ImagenViewController.swift
//  FloresSnapchat2
//
//  Created by Noe Flores on 28/05/24.
//

import UIKit
import FirebaseStorage

class ImagenViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker = UIImagePickerController();
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descripcionTextField: UITextField!
    @IBOutlet weak var elegirContactoBoton: UIButton!
    
    @IBAction func camaraTapped(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func elegirContactoTapped(_ sender: Any) {
        self.elegirContactoBoton.isEnabled = false
        let imagenesFolder = Storage.storage().reference().child("imagenes")
        let imagenData = imageView.image?.jpegData(compressionQuality: 0.50)
        let cargarImagen = imagenesFolder.child("\(NSUUID().uuidString).jpg").putData(imagenData!, metadata: nil) { (metadata, error) in
            if error != nil {
                self.mostrarAlerta(titulo: "Error", mensaje:"Se un produjo error al subir la imagen . verifique su cioneccion a internet y vuelve a intentalo ", accion: "Aceptar")
                print("Ocurrio un error al subir imagen: \(error!)")
            }else{
                self.performSegue(withIdentifier: "seleccionarContactoSegue", sender: nil)

            }
        }
        let alertaCarga = UIAlertController(title: "Cargando Imagen ...", message: "0%", preferredStyle: .alert)
        let progresoCarga: UIProgressView = UIProgressView(progressViewStyle: .default)
        cargarImagen.observe(.progress) { (snapshot) in
            let porcentaje = Double(snapshot.progress!.completedUnitCount) / Double(snapshot.progress!.totalUnitCount)
            print(porcentaje)
            progresoCarga.setProgress(Float(porcentaje), animated: true)
            progresoCarga.frame = CGRect(x: 10, y: 70, width: 250, height: 0)
            alertaCarga.message = String(round(porcentaje*100.0)) + " %"
            if porcentaje>=1.0 {
                alertaCarga.dismiss(animated: true, completion: nil)
            }
        }
        let btnOK = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alertaCarga.addAction(btnOK)
        alertaCarga.view.addSubview(progresoCarga)
        present(alertaCarga, animated: true, completion: nil)
        
    }
    
    /**
     
     let alerta = UIAlertController(title: titulo, message: "Se un produjo error al subir la imagen . verifique su cioneccion a internet y vuelve a intentalo ", accion: "Aceptar")
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        elegirContactoBoton.isEnabled = false

        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
       let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
       imageView.image = image
       imageView.backgroundColor = UIColor.clear
       elegirContactoBoton.isEnabled = true
       imagePicker.dismiss(animated: true, completion: nil)
    }
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       let imagenesFolder = Storage.storage().reference().child("imagenes")
       let imagenData = imageView.image?.jpegData(compressionQuality: 0.50)
       imagenesFolder.child("imagenes.jpg").putData(imagenData!, metadata: nil) { (metadata, error) in
           if error != nil {
               print("Ocurrio un error al subir imagen: \(error!)")
           }
       }
    }*/
    func mostrarAlerta(titulo: String, mensaje: String, accion : String){
        let alerta = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        let bntCANCELOK = UIAlertAction(title: accion, style: .default, handler: nil)
        
        alerta.addAction(bntCANCELOK)
        present(alerta, animated: true, completion: nil)
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
