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
            else:
                sucursal=""
            self.acceso(cargo,nombre,apellido,sucursal,contrasena)
        except:
            self.indicador_error.setText("Usuario o Contraseña Incorrectos")
            self.input_nombre.setText("")
            self.input_apellido.setText("")
            self.input_contrasena.setText("")
    
    def acceso(self,cargo,nombre,apellido,sucursal,contrasena):
        print("Accedido")
        if cargo=='Jefe':
            ventana_principal = Ventana_jefe(nombre,apellido,cargo,contrasena)
            widget.addWidget(ventana_principal)
            print("---")
            widget.setCurrentIndex(widget.currentIndex()+1)
        elif cargo=='Administrador':
            ventana_principal = Ventana_admin(nombre,apellido,cargo,sucursal,contrasena)
            widget.addWidget(ventana_principal)
            widget.setCurrentIndex(widget.currentIndex()+1)
        elif cargo == 'Funcionario':
            ventana_principal = Ventana_funcionario(nombre,apellido,cargo,contrasena)
            widget.addWidget(ventana_principal)
            widget.setCurrentIndex(widget.currentIndex()+1)
        elif cargo == 'Domiciliario':
            ventana_principal = Ventana_domiciliario(nombre,apellido,cargo,contrasena)
            widget.addWidget(ventana_principal)
            widget.setCurrentIndex(widget.currentIndex()+1)
        
##### Ventana JEFE 
qtCreatorFile2="Ventana_jefe.ui"

Ui_MainWindow, QtBaseClass = uic.loadUiType(qtCreatorFile2)
     

class Ventana_jefe(QtWidgets.QMainWindow, Ui_MainWindow):
    
    def __init__(self,nombre,apellido,cargo,contrasena):
        usuario=nombre+" "+apellido
        widget.setFixedWidth(900)
        widget.setFixedHeight(550)
        QtWidgets.QMainWindow.__init__(self)
        Ui_MainWindow.__init__(self)
        self.setupUi(self)   
        self.usuario_label.setText("Usuario: "+usuario)
        self.cargo_label.setText("Cargo: "+cargo)
        self.user_label.setText(usuario)
        self.nombre_label.setText(nombre)
        self.apellido_label.setText(apellido)
        self.password_label.setText(contrasena)
        self.btn_logout.clicked.connect(self.desconectar)
        nombre = self.nombre_label.text()
        apellido = self.apellido_label.text()
        contrasena = self.password_label.text()
        print(nombre)
        print(contrasena)
        print(apellido)
        
        self.insumos_check.hide()
        self.productos_check.hide()
        self.btn_empleados.clicked.connect(self.empleados)
        self.btn_sucursales.clicked.connect(self.sucursales)
        self.btn_ventas.clicked.connect(self.ventas)
        self.btn_domicilios.clicked.connect(self.domicilio)
        self.btn_maquinaria.clicked.connect(self.maquinaria)
        self.btn_insumos.clicked.connect(self.insumos)
        self.btn_productos.clicked.connect(self.productos)
        self.btn_proveedores.clicked.connect(self.proveedores)
        self.btn_mi_info.clicked.connect(self.mi_informacion)
        self.btn_contratos.clicked.connect(self.contratos)
        
    
    def desconectar(self):
        print("logout funciona")
        widget.setFixedWidth(500)
        widget.setFixedHeight(400)
        inicio=login()
        widget.addWidget(inicio)
        widget.setCurrentIndex(widget.currentIndex()+1)
    
    def mi_informacion(self):
        
        nombre = self.nombre_label.text()
        apellido = self.apellido_label.text()
        contrasena = self.password_label.text()
        self.ventana = QtWidgets.QMainWindow()
        self.ui = mi_info(nombre,apellido,contrasena)
        self.ui.setupUi(self.ventana)
        self.ventana.show()
    
    def empleados(self):
       # usuario=nombre+' '+contrasena
        self.insumos_check.hide()
        self.productos_check.hide()
        self.tabla.clear()
        columnas=("Nombre","Apellido","Direccion","Telefono","EPS","Ciudad","Fecha-Nacimiento"," ","")
        self.tabla.setHorizontalHeaderLabels(columnas)
        nombre = str(self.nombre_label.text())
        apellido = str( self.apellido_label.text())
        contrasena = str(self.password_label.text())
        usuario = str(nombre + " "+apellido)
        print(nombre)
        print(contrasena)
        print(apellido)
        print(usuario)
        database = Database(usuario,contrasena)
        sql = "select * from info_empleados" 
        database.cursor.execute(sql)
        info = database.cursor.fetchall()
        
        fila=0
        #columna=0
        for registro in info:
            self.tabla.setItem(fila,0,QtWidgets.QTableWidgetItem(registro[0]))
            self.tabla.setItem(fila,1,QtWidgets.QTableWidgetItem(registro[1]))
            self.tabla.setItem(fila,2,QtWidgets.QTableWidgetItem(registro[2]))
            self.tabla.setItem(fila,3,QtWidgets.QTableWidgetItem(registro[3]))
            self.tabla.setItem(fila,4,QtWidgets.QTableWidgetItem(registro[4]))
            self.tabla.setItem(fila,5,QtWidgets.QTableWidgetItem(registro[5]))
            self.tabla.setItem(fila,6,QtWidgets.QTableWidgetItem(registro[6]))
            fila+=1
        #self.tabla.setItem(2,2,QtWidgets.QTableWidgetItem("sd"))
        
        
    
    def sucursales(self):
        self.insumos_check.hide()
        self.productos_check.hide()
        self.tabla.clear()
        columnas=("Categoria","Nombre","Ubicación","Ciudad","Administrador"," "," ")
        self.tabla.setHorizontalHeaderLabels(columnas)
        nombre = str(self.nombre_label.text())
        apellido = str( self.apellido_label.text())
        contrasena = str(self.password_label.text())
        usuario = str(nombre + " "+apellido)
        print(nombre)
        print(contrasena)
        print(apellido)
        print(usuario)
        database = Database(usuario,contrasena)
        sql = "select sucursal.categoria, sucursal.nombre, sucursal.ubicacion, sucursal.ciudad, concat(empleado.nombre,' ', empleado.apellido) from sucursal, empleado where empleado.idempleado = sucursal.administrador" 
        database.cursor.execute(sql)
        info = database.cursor.fetchall()
        
        fila=0
        #columna=0
        for registro in info:
            self.tabla.setItem(fila,0,QtWidgets.QTableWidgetItem(registro[0]))
            self.tabla.setItem(fila,1,QtWidgets.QTableWidgetItem(registro[1]))
            self.tabla.setItem(fila,2,QtWidgets.QTableWidgetItem(registro[2]))
            self.tabla.setItem(fila,3,QtWidgets.QTableWidgetItem(registro[3]))
            self.tabla.setItem(fila,4,QtWidgets.QTableWidgetItem(registro[4]))
            
            fila+=1
        #self.tabla.setItem(2,2,QtWidgets.QTableWidgetItem("sd"))
    
    def ventas(self):
        self.insumos_check.show()
        self.productos_check.show()
        nombre = str(self.nombre_label.text())
        apellido = str( self.apellido_label.text())
        contrasena = str(self.password_label.text())
        usuario = str(nombre + " "+apellido)
        print(nombre)
        print(contrasena)
        print(apellido)
        print(usuario)
        database = Database(usuario,contrasena)
        self.tabla.clear()
      #  columnas = ("Producto","Cliente","Empleado","Sucursal","Fecha")
     #   self.tabla.setHorizontalHeaderLabels(columnas)
        
        
        self.insumos_check.stateChanged.connect(self.ventas_insumos)
        self.productos_check.stateChanged.connect(self.ventas_productos)
        
    
    
    def ventas_insumos(self):
       
        nombre = str(self.nombre_label.text())
        apellido = str( self.apellido_label.text())
        contrasena = str(self.password_label.text())
        usuario = str(nombre + " "+apellido)
        print(nombre)
        print(contrasena)
        print(apellido)
        print(usuario)
        database = Database(usuario,contrasena)
        self.tabla.clear()
        columnas = ("Insumo","Cliente","Empleado","Sucursal","Fecha")
        self.tabla.setHorizontalHeaderLabels(columnas)
        sql = "select insumo.nombre, concat(cliente.nombre,' ',cliente.apellido) , concat(empleado.nombre,' ',empleado.apellido), sucursal.nombre, venta.fecha from cliente,empleado,venta,sucursal,insumo,venta_insumos where cliente.idcliente = venta.idcliente and empleado.idempleado = venta.idempleado and venta_insumos.idinsumo = insumo.idinsumo and venta_insumos.idventa = venta.idventa and venta.idsucursal=sucursal.idsucursal;"
        database.cursor.execute(sql)
        info = database.cursor.fetchall()
        fila=0
        #columna=0
        for registro in info:
            self.tabla.setItem(fila,0,QtWidgets.QTableWidgetItem(registro[0]))
            self.tabla.setItem(fila,1,QtWidgets.QTableWidgetItem(registro[1]))
            self.tabla.setItem(fila,2,QtWidgets.QTableWidgetItem(registro[2]))
            self.tabla.setItem(fila,3,QtWidgets.QTableWidgetItem(registro[3]))
            self.tabla.setItem(fila,4,QtWidgets.QTableWidgetItem(registro[4]))
            
            fila+=1
        
    def ventas_productos(self):
       
        nombre = str(self.nombre_label.text())
        apellido = str( self.apellido_label.text())
        contrasena = str(self.password_label.text())
        usuario = str(nombre + " "+apellido)
        print(nombre)
        print(contrasena)
        print(apellido)
        print(usuario)
        database = Database(usuario,contrasena)
        self.tabla.clear()
        columnas = ("Producto","Cliente","Empleado","Sucursal","Fecha")
        self.tabla.setHorizontalHeaderLabels(columnas)
        sql = "select producto.nombre, concat(cliente.nombre,' ',cliente.apellido) , concat(empleado.nombre,' ',empleado.apellido), sucursal.nombre, venta.fecha from cliente,empleado,venta,sucursal,producto,venta_productos where cliente.idcliente = venta.idcliente and empleado.idempleado = venta.idempleado and venta_productos.idproducto = producto.idproducto and venta_productos.idventa = venta.idventa and venta.idsucursal=sucursal.idsucursal;"
        database.cursor.execute(sql)
        info = database.cursor.fetchall()
        fila=0
        #columna=0
        for registro in info:
            self.tabla.setItem(fila,0,QtWidgets.QTableWidgetItem(registro[0]))
            self.tabla.setItem(fila,1,QtWidgets.QTableWidgetItem(registro[1]))
            self.tabla.setItem(fila,2,QtWidgets.QTableWidgetItem(registro[2]))
            self.tabla.setItem(fila,3,QtWidgets.QTableWidgetItem(registro[3]))
            self.tabla.setItem(fila,4,QtWidgets.QTableWidgetItem(registro[4]))
            
            fila+=1
    
    def domicilio(self):
        self.insumos_check.show()
        self.productos_check.show()
        nombre = str(self.nombre_label.text())
        apellido = str( self.apellido_label.text())
        contrasena = str(self.password_label.text())
        usuario = str(nombre + " "+apellido)
        print(nombre)
        print(contrasena)
        print(apellido)
        print(usuario)
        database = Database(usuario,contrasena)
        self.tabla.clear()
        columnas = ("Producto","Nombre-Cliente","Apellido-Cliente","Nombre-Empleado","Apellido-Empleado","Sucursal"," ")
        self.tabla.setHorizontalHeaderLabels(columnas)
        self.insumos_check.stateChanged.connect(self.domicilios_insumos)
        self.productos_check.stateChanged.connect(self.domicilios_productos)
    
    def domicilios_insumos(self):
        nombre = str(self.nombre_label.text())
        apellido = str( self.apellido_label.text())
        contrasena = str(self.password_label.text())
        usuario = str(nombre + " "+apellido)
        print(nombre)
        print(contrasena)
        print(apellido)
        print(usuario)
        database = Database(usuario,contrasena)
        self.tabla.clear()
        columnas = ("Insumo","Cliente","Domiciliario","Dirección")
        self.tabla.setHorizontalHeaderLabels(columnas)
        sql = "select insumo.nombre, concat(cliente.nombre,' ',cliente.apellido) , concat(empleado.nombre,' ',empleado.apellido), domicilio.direccion_entrega  from domicilio,empleado,venta,cliente,venta_insumos,insumo where domicilio.idventa = venta.idventa and cliente.idcliente = domicilio.idcliente and empleado.idempleado = domicilio.idempleado and venta_insumos.idventa = domicilio.idventa and insumo.idinsumo = venta_insumos.idinsumo;"
        database.cursor.execute(sql)
        info = database.cursor.fetchall()
        fila=0
        #columna=0
        for registro in info:
            self.tabla.setItem(fila,0,QtWidgets.QTableWidgetItem(registro[0]))
            self.tabla.setItem(fila,1,QtWidgets.QTableWidgetItem(registro[1]))
            self.tabla.setItem(fila,2,QtWidgets.QTableWidgetItem(registro[2]))
            self.tabla.setItem(fila,3,QtWidgets.QTableWidgetItem(registro[3]))
            
            fila+=1
    
    def domicilios_productos(self):
        nombre = str(self.nombre_label.text())
        apellido = str( self.apellido_label.text())
        contrasena = str(self.password_label.text())
        usuario = str(nombre + " "+apellido)
        print(nombre)
        print(contrasena)
        print(apellido)
        print(usuario)
        database = Database(usuario,contrasena)
        self.tabla.clear()
        columnas = ("Producto","Cliente","Domiciliario","Dirección")
        self.tabla.setHorizontalHeaderLabels(columnas)
        sql = "select producto.nombre, concat(cliente.nombre,' ',cliente.apellido) , concat(empleado.nombre,' ',empleado.apellido), domicilio.direccion_entrega  from domicilio,empleado,venta,cliente,venta_productos,producto where domicilio.idventa = venta.idventa and cliente.idcliente = domicilio.idcliente and empleado.idempleado = domicilio.idempleado and venta_productos.idventa = domicilio.idventa and producto.idproducto = venta_productos.idproducto;"
        database.cursor.execute(sql)
        info = database.cursor.fetchall()
        fila=0
        #columna=0
        for registro in info:
            self.tabla.setItem(fila,0,QtWidgets.QTableWidgetItem(registro[0]))
            self.tabla.setItem(fila,1,QtWidgets.QTableWidgetItem(registro[1]))
            self.tabla.setItem(fila,2,QtWidgets.QTableWidgetItem(registro[2]))
            self.tabla.setItem(fila,3,QtWidgets.QTableWidgetItem(registro[3]))
            
            fila+=1
        
    def maquinaria(self):
        self.insumos_check.hide()
        self.productos_check.hide()
        nombre = str(self.nombre_label.text())
        apellido = str( self.apellido_label.text())
        contrasena = str(self.password_label.text())
        usuario = str(nombre + " "+apellido)
        print(nombre)
        print(contrasena)
        print(apellido)
        print(usuario)
        database = Database(usuario,contrasena)
        self.tabla.clear()
        columnas = ("Nombre","Fecha_compra","Precio","Marca","Garantía","Estado_pago","Deuda","","")
        self.tabla.setHorizontalHeaderLabels(columnas)
        sql = "select nombre, fecha_de_compra, precio, marca, garantia, estado_de_pago, cantidad_a_pagar from maquinaria_y_equipo"
        database.cursor.execute(sql)
        info = database.cursor.fetchall()
        
        fila=0
        #columna=0
        for registro in info:
            self.tabla.setItem(fila,0,QtWidgets.QTableWidgetItem(registro[0]))
            self.tabla.setItem(fila,1,QtWidgets.QTableWidgetItem(registro[1]))
            self.tabla.setItem(fila,2,QtWidgets.QTableWidgetItem(str(registro[2])))
            self.tabla.setItem(fila,3,QtWidgets.QTableWidgetItem(registro[3]))
            self.tabla.setItem(fila,4,QtWidgets.QTableWidgetItem(registro[4]))
            self.tabla.setItem(fila,5,QtWidgets.QTableWidgetItem(registro[5]))
            
            fila+=1
        
        
    def insumos(self):
       self.insumos_check.hide()
       self.productos_check.hide()
       nombre = str(self.nombre_label.text())
       apellido = str( self.apellido_label.text())
       contrasena = str(self.password_label.text())
       usuario = str(nombre + " "+apellido)
       print(nombre)
       print(contrasena)
       print(apellido)
       print(usuario)
       database = Database(usuario,contrasena)
       self.tabla.clear()
       columnas = ("Nombre","Cantidad","Unidad_medida","Precio_unidad","Marca","Fecha","Estado_pago","Deuda","IVA","Sucursal")
       self.tabla.setHorizontalHeaderLabels(columnas)
       sql = "select insumo.nombre, insumo.cantidad ,insumo.unidad_de_medida, insumo.precio_por_unidad_de_medida,insumo.marca, insumo.fecha_de_compra,insumo.estado_de_pago,insumo.cantidad_a_pagar, insumo.iva,sucursal.nombre from insumo,sucursal,inventario where insumo.idinventario = inventario.idinventario and sucursal.idsucursal = inventario.idsucursal ;"
       database.cursor.execute(sql)
       info = database.cursor.fetchall()
        
       fila=0
        #columna=0
       for registro in info:
            self.tabla.setItem(fila,0,QtWidgets.QTableWidgetItem(registro[0]))
            self.tabla.setItem(fila,1,QtWidgets.QTableWidgetItem(str(registro[1])))
            self.tabla.setItem(fila,2,QtWidgets.QTableWidgetItem(str(registro[2])))
            self.tabla.setItem(fila,3,QtWidgets.QTableWidgetItem(str(registro[3])))
            self.tabla.setItem(fila,4,QtWidgets.QTableWidgetItem(registro[4]))
            self.tabla.setItem(fila,5,QtWidgets.QTableWidgetItem(registro[5]))
            self.tabla.setItem(fila,6,QtWidgets.QTableWidgetItem(registro[6]))
            self.tabla.setItem(fila,7,QtWidgets.QTableWidgetItem(str(registro[7])))
            self.tabla.setItem(fila,8,QtWidgets.QTableWidgetItem(str(registro[8])))
            self.tabla.setItem(fila,9,QtWidgets.QTableWidgetItem(registro[9]))
            fila+=1
        
    def productos(self):
       self.insumos_check.hide()
       self.productos_check.hide()
       nombre = str(self.nombre_label.text())
       apellido = str( self.apellido_label.text())
       contrasena = str(self.password_label.text())
       usuario = str(nombre + " "+apellido)
       print(nombre)
       print(contrasena)
       print(apellido)
       print(usuario)
       database = Database(usuario,contrasena)
       self.tabla.clear()
       columnas = ("Nombre","Precio","Producción","Categoria","Caducidad","Punto-Fabricación","","","")
       self.tabla.setHorizontalHeaderLabels(columnas)
       sql = "select producto.nombre,producto.precio,producto.fecha_de_produccion, producto.categoria,producto.fecha_de_caducidad, sucursal.nombre from producto,sucursal where producto.punto_de_fabricacion=sucursal.idsucursal;"
       database.cursor.execute(sql)
       info = database.cursor.fetchall()
        
       fila=0
        #columna=0
       for registro in info:
            self.tabla.setItem(fila,0,QtWidgets.QTableWidgetItem(registro[0]))
            self.tabla.setItem(fila,1,QtWidgets.QTableWidgetItem(str(registro[1])))
            self.tabla.setItem(fila,2,QtWidgets.QTableWidgetItem(str(registro[2])))
            self.tabla.setItem(fila,3,QtWidgets.QTableWidgetItem(str(registro[3])))
            self.tabla.setItem(fila,4,QtWidgets.QTableWidgetItem(registro[4]))
            self.tabla.setItem(fila,5,QtWidgets.QTableWidgetItem(registro[5]))
            fila+=1
    def contratos(self):
       self.insumos_check.hide()
       self.productos_check.hide()
       nombre = str(self.nombre_label.text())
       apellido = str( self.apellido_label.text())
       contrasena = str(self.password_label.text())
       usuario = str(nombre + " "+apellido)
       print(nombre)
       print(contrasena)
       print(apellido)
       print(usuario)
       database = Database(usuario,contrasena)
       self.tabla.clear()
       columnas = ("Nombre","Cargo","Salario","Contratación","Terminación","","","")
       self.tabla.setHorizontalHeaderLabels(columnas)
       sql = "select concat(empleado.nombre,' ',empleado.apellido), cargos.nombre, contrato.salario, contrato.fecha_contratacion, contrato.fecha_terminacion from contrato, empleado, cargos where contrato.idcontrato=empleado.idcontrato and contrato.idcargo = cargos.idcargo;"
       database.cursor.execute(sql)
       info = database.cursor.fetchall()
        
       fila=0
        #columna=0
       for registro in info:
            self.tabla.setItem(fila,0,QtWidgets.QTableWidgetItem(registro[0]))
            self.tabla.setItem(fila,1,QtWidgets.QTableWidgetItem(str(registro[1])))
            self.tabla.setItem(fila,2,QtWidgets.QTableWidgetItem(str(registro[2])))
            self.tabla.setItem(fila,3,QtWidgets.QTableWidgetItem(str(registro[3])))
            self.tabla.setItem(fila,4,QtWidgets.QTableWidgetItem(registro[4]))
            fila+=1
       
        
    def proveedores(self): 
        self.insumos_check.hide()
        self.productos_check.hide()
        self.tabla.clear()
        nombre = str(self.nombre_label.text())
        apellido = str( self.apellido_label.text())
        contrasena = str(self.password_label.text())
        usuario = str(nombre + " "+apellido)
        print(nombre)
        print(contrasena)
        print(apellido)
        print(usuario)
        database = Database(usuario,contrasena)
        self.tabla.clear()
        columnas = ("NIT","Nombre","Razón Social","Ubicación","Contacto","Teléfono","Categoria","Negociación","Email")
        self.tabla.setHorizontalHeaderLabels(columnas)
        sql = "select * from proveedor"
        database.cursor.execute(sql)
        info = database.cursor.fetchall()
        
        fila=0
        #columna=0
        for registro in info:
            self.tabla.setItem(fila,0,QtWidgets.QTableWidgetItem(registro[0]))
            self.tabla.setItem(fila,1,QtWidgets.QTableWidgetItem(str(registro[1])))
            self.tabla.setItem(fila,2,QtWidgets.QTableWidgetItem(str(registro[2])))
            self.tabla.setItem(fila,3,QtWidgets.QTableWidgetItem(str(registro[3])))
            self.tabla.setItem(fila,4,QtWidgets.QTableWidgetItem(registro[4]))
            self.tabla.setItem(fila,5,QtWidgets.QTableWidgetItem(registro[5]))
            self.tabla.setItem(fila,6,QtWidgets.QTableWidgetItem(registro[6]))
            self.tabla.setItem(fila,7,QtWidgets.QTableWidgetItem(registro[7]))
            self.tabla.setItem(fila,8,QtWidgets.QTableWidgetItem(registro[8]))
            fila+=1
        
        
        


## Ventana Administrador
qtCreatorFile3="Ventana_Administrador.ui"

Ui_MainWindow, QtBaseClass = uic.loadUiType(qtCreatorFile3)
     

class Ventana_admin(QtWidgets.QMainWindow, Ui_MainWindow):
    def __init__(self,nombre,apellido,cargo,sucursal,contrasena):
        usuario=nombre+" "+apellido
        QtWidgets.QMainWindow.__init__(self)
        Ui_MainWindow.__init__(self)
        self.setupUi(self)  
        self.usuario_label.setText("Usuario: "+usuario)
        self.cargo_label.setText("Cargo: "+cargo+" de "+sucursal)
        self.btn_logout.clicked.connect(self.desconectar)
    
    def desconectar(self):
        widget.setFixedWidth(700)
        widget.setFixedHeight(400)
        print("logout funciona")
        inicio=login()
        widget.addWidget(inicio)
        widget.setCurrentIndex(widget.currentIndex()+1)

## Ventana Funcionario
qtCreatorFile3="Ventana_Funcionario.ui"

Ui_MainWindow, QtBaseClass = uic.loadUiType(qtCreatorFile3)
     

class Ventana_funcionario(QtWidgets.QMainWindow, Ui_MainWindow):
    def __init__(self,nombre,apellido,cargo,contrasena):
        usuario=nombre+" "+apellido
        QtWidgets.QMainWindow.__init__(self)
        Ui_MainWindow.__init__(self)
        self.setupUi(self)  
        self.usuario_label.setText(usuario)
        self.cargo_label.setText("Cargo: "+cargo)
        self.btn_logout.clicked.connect(self.desconectar)
        
    
    def desconectar(self):
        widget.setFixedWidth(500)
        widget.setFixedHeight(400)
        print("logout funciona")
        inicio=login()
        widget.addWidget(inicio)
        widget.setCurrentIndex(widget.currentIndex()+1)
        
## Ventana Domiciliario    
qtCreatorFile5="Ventana_Domiciliario.ui"

Ui_MainWindow, QtBaseClass = uic.loadUiType(qtCreatorFile5)
     

class Ventana_domiciliario(QtWidgets.QMainWindow, Ui_MainWindow):
    def __init__(self,nombre,apellido,cargo,contrasena):
        usuario=nombre+" "+apellido
        QtWidgets.QMainWindow.__init__(self)
        Ui_MainWindow.__init__(self)
        self.setupUi(self)  
        self.usuario_label.setText("Usuario: "+usuario)
        self.cargo_label.setText("Cargo: "+cargo)
        self.btn_logout.clicked.connect(self.desconectar)
    
    def desconectar(self):
        widget.setFixedWidth(500)
        widget.setFixedHeight(400)
        print("logout funciona")
        inicio=login()
        widget.addWidget(inicio)
        widget.setCurrentIndex(widget.currentIndex()+1)
        

## Ventana de Mi información   
qtCreatorFile5="mi_info.ui"

Ui_MainWindow, QtBaseClass = uic.loadUiType(qtCreatorFile5)


class mi_info(QtWidgets.QMainWindow,Ui_MainWindow ):
    def __init__(self,nombre,apellido,contrasena):
        QtWidgets.QMainWindow.__init__(self)
        Ui_MainWindow.__init__(self)
        self.setupUi(self)
        usuario = contrasena+' '+apellido
        
        database=Database("Jeisson Clavijo","12345")
        
        sql = "SELECT * FROM info_empleados WHERE nombre = '{}' and apellido = '{}'".format(nombre,apellido)
        
        database.cursor.execute(sql)
        info = database.cursor.fetchall()
        for atributos in info:
            self.nombre_label.setText("Nombre: "+atributos[0])
            self.apellido_label.setText("Apellido: "+atributos[1])
            self.direccion_label.setText("Direccion: d"+atributos[2])
            self.telefono_label.setText("Teléfono: "+atributos[3])
            self.eps_label.setText("EPS: "+atributos[4])
            self.ciudad_label.setText("Ciudad: "+atributos[5])
            self.fecha_label.setText("Fecha de Nacimiento: "+atributos[6])



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
    widget.setFixedWidth(500)
    widget.setFixedHeight(400)
    widget.show()
    sys.exit(app.exec_())
