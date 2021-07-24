import sys
from PyQt5 import uic, QtWidgets
from PyQt5.QtWidgets import QDialog, QApplication

import mysql.connector

qtCreatorFile = "login.ui" # Nombre del archivo aquí.

Ui_MainWindow, QtBaseClass = uic.loadUiType(qtCreatorFile)




class login(QtWidgets.QMainWindow, Ui_MainWindow):
    def __init__(self):
        QtWidgets.QMainWindow.__init__(self)
        Ui_MainWindow.__init__(self)
        self.setupUi(self)
        
        ## Botones
        self.btn_login.clicked.connect(self.conectar)
        
    
    def conectar(self):
        self.input_contrasena.setEchoMode(QtWidgets.QLineEdit.Password)
        nombre = self.input_nombre.text()
        apellido = self.input_apellido.text()
        contrasena = self.input_contrasena.text()
        print(contrasena)
        usuario = nombre+' '+apellido
        print(usuario)
        
        try:
            database = Database(usuario,contrasena)
            cargo= database.obtener_cargo(nombre, apellido)
            id = database.obtener_id(nombre, apellido)
            print(id)
            if(cargo=='Administrador'):
                sucursal= database.obtener_sucursal(id)
                print(sucursal)
            self.acceso(cargo)
        except:
            self.indicador_error.setText("Usuario o Contraseña Incorrectos")
    
    def acceso(self,cargo):
        print("Accedido")
        if cargo=='Jefe':
            ventana_principal = Ventana_jefe()
            widget.addWidget(ventana_principal)
            widget.setCurrentIndex(widget.currentIndex()+1)
        elif cargo=='Administrador':
            ventana_principal = Ventana_admin()
            widget.addWidget(ventana_principal)
            widget.setCurrentIndex(widget.currentIndex()+1)
        elif cargo == 'Funcionario':
            ventana_principal = Ventana_funcionario()
            widget.addWidget(ventana_principal)
            widget.setCurrentIndex(widget.currentIndex()+1)
        elif cargo == 'Domiciliario':
            ventana_principal = Ventana_domiciliario()
            widget.addWidget(ventana_principal)
            widget.setCurrentIndex(widget.currentIndex()+1)
        
##### Ventana JEFE 
qtCreatorFile2="Ventana_jefe.ui"

Ui_MainWindow, QtBaseClass = uic.loadUiType(qtCreatorFile2)
     

class Ventana_jefe(QtWidgets.QMainWindow, Ui_MainWindow):
    def __init__(self):
        QtWidgets.QMainWindow.__init__(self)
        Ui_MainWindow.__init__(self)
        self.setupUi(self)        


## Ventana Administrador
qtCreatorFile3="Ventana_Administrador.ui"

Ui_MainWindow, QtBaseClass = uic.loadUiType(qtCreatorFile3)
     

class Ventana_admin(QtWidgets.QMainWindow, Ui_MainWindow):
    def __init__(self):
        QtWidgets.QMainWindow.__init__(self)
        Ui_MainWindow.__init__(self)
        self.setupUi(self)  

## Ventana Funcionario
qtCreatorFile3="Ventana_Funcionario.ui"

Ui_MainWindow, QtBaseClass = uic.loadUiType(qtCreatorFile3)
     

class Ventana_funcionario(QtWidgets.QMainWindow, Ui_MainWindow):
    def __init__(self):
        QtWidgets.QMainWindow.__init__(self)
        Ui_MainWindow.__init__(self)
        self.setupUi(self)  
        
        
## Ventana Domiciliario    
qtCreatorFile5="Ventana_Domiciliario.ui"

Ui_MainWindow, QtBaseClass = uic.loadUiType(qtCreatorFile5)
     

class Ventana_domiciliario(QtWidgets.QMainWindow, Ui_MainWindow):
    def __init__(self):
        QtWidgets.QMainWindow.__init__(self)
        Ui_MainWindow.__init__(self)
        self.setupUi(self)  


## Conexión y Funciones sobre la base de Datos

class Database:
    def __init__(self,usuario,contrasena):
        self.connection = mysql.connector.connect(
            host="localhost",user= usuario,
            password = contrasena, db="pionono_cakes",
            auth_plugin='mysql_native_password'
            )
        
        self.cursor = self.connection.cursor()
        print("Conexión exitosa")
    
    
    def cerrar_conexion(self):
        self.connection.close()
    
    
    
    
    def obtener_id(self,nombre,apellido):
        sql = "obtener_id"
        parametros =(nombre,apellido)
        try:
            self.cursor.callproc(sql, parametros)
            for result in self.cursor.stored_results():
                id = result.fetchone()
            return id[0] 
        except Exception as e:
            raise
    
    
    
    def obtener_cargo(self,nombre,apellido):
        sql = "SELECT cargo FROM info_contratos  WHERE nombre='{}' AND apellido = '{}' ".format(nombre,apellido)
        try:
            self.cursor.execute(sql)
            cargo=self.cursor.fetchone()
            return cargo[0]
        except Exception as e:
            raise
    
    
    def obtener_sucursal(self,id):
        sql = "SELECT nombre FROM sucursal  WHERE administrador= {} ".format(id)
        try:
            self.cursor.execute(sql)
            sucursal=self.cursor.fetchone()
            return sucursal[0]
        
        except Exception as e:
            raise





if __name__ == "__main__":
    app =  QtWidgets.QApplication(sys.argv)
    widget=QtWidgets.QStackedWidget()
    principal = login()
    widget.addWidget(principal)
    
    widget.show()
    sys.exit(app.exec_())
