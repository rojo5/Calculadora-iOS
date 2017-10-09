//
//  ViewController.swift
//  Calculadora
//
//  Created by CETYS on 26/9/17.
//  Copyright © 2017 CETYS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pantalla: UILabel!
    @IBOutlet weak var miniPantalla: UILabel!
    
    //DECLARACION DE VARIABLES
    var elUsuarioEstaEnMedioDeLaEscrituraDeNumero : Bool = false
    var imposible : Bool = false
    var operando1 : Double = 0
    var operando2 : Double = 0
    var operacion : String = ""
    var boton : UIButton = UIButton()
    
    //Se llama a esta funcion cuando le das al boton "="
    @IBAction func enterPulsado() {
        let numero : NSString = pantalla.text! as NSString
        operando2 = numero.doubleValue
        
        let resultado = realizaOperacion()
        
        //Vuelve a poner el boton original del boton
        boton.backgroundColor = UIColor(red: 255/255, green: 47/255, blue: 34/255, alpha: 1.0)
        
        pantalla.text = String (format: "%g", resultado)
        
    }
    
    
    @IBAction func operacionPulsada(_ sender: UIButton) {
        let numero : NSString = pantalla.text! as NSString
        operando1 = numero.doubleValue
        
        //Cambio el color del boton al pulsarlo
        boton = sender
        boton.backgroundColor = UIColor.orange
        //Guardo la operacion pulsada
        operacion = sender.currentTitle!
        miniPantalla.text = pantalla.text
            //pongo un 0 en la pantalla para poner el 2 operando
        pantalla.text = "0"
        elUsuarioEstaEnMedioDeLaEscrituraDeNumero = false
    }
    
    //Funciones en las quer solo se realiza con un solo operando
    @IBAction func operacionDeSoloUnOperando(_ sender: UIButton) {
        let numero : NSString = pantalla.text! as NSString
        operando1 = numero.doubleValue
        
         operacion = sender.currentTitle!
        
       
        
        if imposible == false{
            pantalla.text = String (format: "%g", realizaOperacionDeUnSoloOperando())
            
        }
        else{
            pantalla.text = "No se puede dividir entre 0"
            imposible = false
        }
        
        
        miniPantalla.text = ""
        elUsuarioEstaEnMedioDeLaEscrituraDeNumero = false

        
    }
    @IBAction func borrar(_ sender: UIButton) {
        pantalla.text = "0"
        elUsuarioEstaEnMedioDeLaEscrituraDeNumero = false

    }
    
    @IBAction func cambiaSigno(_ sender: UIButton) {
        
        let aux = pantalla.text
        
        
        if aux?.range(of: "-") == nil  {
            pantalla.text = "-" + aux!
        }
        else {
            print("Paso por aqui")
            let index = aux?.index((aux?.startIndex)!, offsetBy: 1)
            
            pantalla.text = aux?.substring(from: index!)
        }
        
    }
    
    @IBAction func numeroPulsado(_ sender: UIButton) {
        let digito : String! = sender.currentTitle
       
        if elUsuarioEstaEnMedioDeLaEscrituraDeNumero{
            pantalla.text = pantalla.text! + digito
        }
        else{
            pantalla.text = digito
            elUsuarioEstaEnMedioDeLaEscrituraDeNumero = true
        }
        
        
        print(digito)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func realizaOperacionDeUnSoloOperando() -> Double {
        var resultado : Double = 0
        
        if operacion == "√" {
            resultado = sqrt(operando1)
        }
        else if operacion == "cos(x)"{
            if operando1 == 90{
                resultado = 0
            }
            else{
                resultado = cos(operando1 * M_PI / 180)
            }
            
        }
        else if operacion == "sin(x)"{
            if operando1 == 180 || operando1 == 360{
                resultado = 0
            }
            else{
                resultado = sin(operando1 * M_PI / 180)
            }
            
        }
        else if operacion == "tan(x)"{
            if operando1 == 90{
                imposible = true
            }
            else if operando1 == 180 || operando1 == 360{
                resultado = 0
            }
            else{
             resultado = tan(operando1 * M_PI / 180)
            }
            
        }
        else if operacion == "X²"{
            resultado = operando1 * operando1
        }
        
        return resultado
    }
    
    
    func realizaOperacion() -> Double{
        var resultado : Double = 0
        // codigo para la suma
        if operacion == "+"{
            resultado = operando1 + operando2
        }
        else if operacion == "-"{
            resultado = operando1 - operando2
        }
        else if operacion == "x"{
            resultado = operando1 * operando2
        }
        else if operacion == "÷"{
            resultado = operando1 / operando2
        }
        
        elUsuarioEstaEnMedioDeLaEscrituraDeNumero = false
        return resultado
    }

}

