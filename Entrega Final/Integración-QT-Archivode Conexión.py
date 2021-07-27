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
        
        
        
        database = Database(usuario,contrasena)
        cargo = database.obtener_cargo(nombre, apellido)
        id = database.obtener_id(nombre, apellido)
        print(id)
        if(cargo=='Administrador'):
            sucursal= database.obtener_sucursal(id)
            print(sucursal)
        else:
            sucursal=""
        self.acceso(cargo,nombre,apellido,sucursal,contrasena)
       
    
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
        widget.setFixedHeight(600)
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
        self.btn_mi_contrato.clicked.connect(self.mi_contrato)
        
    
    def desconectar(self):
        print("logout funciona")
        widget.setFixedWidth(500)
        widget.setFixedHeight(400)
        inicio = login()
        widget.addWidget(inicio)
        widget.setCurrentIndex(widget.currentIndex()+1)
    
    def mi_informacion(self):
        
        nombre = self.nombre_label.text()
        apellido = self.apellido_label.text()
        contrasena = self.password_label.text()
        self.ventana =  mi_info(nombre,apellido,contrasena)
       # mi_info(nombre,apellido,contrasena)
        #self.ui.setupUi(self.ventana)
        #self.ventana.exec_()
        self.ventana.show()
    
    def mi_contrato(self):
        nombre = self.nombre_label.text()
        apellido = self.apellido_label.text()
        contrasena = self.password_label.text()
        self.ventana =  mi_contrato(nombre,apellido,contrasena)
        self.ventana.show()
    
    
    def empleados(self):
       # usuario=nombre+' '+contrasena
        self.insumos_check.hide()
        self.productos_check.hide()
        self.tabla.clear()
        columnas = ("Nombre","Apellido","Direccion","Telefono","EPS","Ciudad","Fecha-Nacimiento")
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
        for registro in info:
            self.tabla.setItem(fila,0,QtWidgets.QTableWidgetItem(registro[0]))
            self.tabla.setItem(fila,1,QtWidgets.QTableWidgetItem(registro[1]))
            self.tabla.setItem(fila,2,QtWidgets.QTableWidgetItem(registro[2]))
            self.tabla.setItem(fila,3,QtWidgets.QTableWidgetItem(registro[3]))
            self.tabla.setItem(fila,4,QtWidgets.QTableWidgetItem(registro[4]))
            self.tabla.setItem(fila,5,QtWidgets.QTableWidgetItem(registro[5]))
            self.tabla.setItem(fila,6,QtWidgets.QTableWidgetItem(registro[6]))
            fila += 1
        #self.tabla.setItem(2,2,QtWidgets.QTableWidgetItem("sd"))
        self.btn_insertar.clicked.connect(self.nuevo_empleado)
        
    def nuevo_empleado(self):
        nombre = self.nombre_label.text()
        apellido = self.apellido_label.text()
        contrasena = self.password_label.text()
        self.ventana =  insertar_empleado(nombre,apellido,contrasena)
        self.ventana.show()
    
    def sucursales(self):
        self.insumos_check.hide()
        self.productos_check.hide()
        self.tabla.clear()
        columnas=("Categoria","Nombre","Ubicación","Ciudad","Administrador")
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
        self.tabla.clear()
        columnas = ("Producto","Nombre-Cliente","Apellido-Cliente","Nombre-Empleado","Apellido-Empleado","Sucursal")
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
        columnas = ("Nombre","Fecha_compra","Precio","Marca","Garantía","Estado_pago","Deuda")
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
       sql = "select insumo.nombre, insumo.cantidad ,insumo.unidad_de_medida, insumo.precio_por_unidad_de_medida,insumo.marca, insumo.fecha_de_compra,insumo.estado_de_pago,insumo.cantidad_a_pagar, insumo.iva,sucursal.nombre from insumo,sucursal,inventario where insumo.idinventario = inventario.idinventario and sucursal.idsucursal = inventario.idsucursal"
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
       self.btn_insertar.hide()
       self.btn_eliminar.hide()

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
       columnas = ("Nombre","Cargo","Salario","Contratación","Terminación")
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
        widget.setFixedWidth(870)
        widget.setFixedHeight(600)
        self.usuario_label.setText("Usuario: "+usuario)
        self.cargo_label.setText("Cargo: "+cargo+" de "+sucursal)
        self.user_label.setText(usuario)
        self.nombre_label.setText(nombre)
        self.apellido_label.setText(apellido)
        self.password_label.setText(contrasena)
        self.btn_logout.clicked.connect(self.desconectar)
        self.btn_mi_info.clicked.connect(self.mi_informacion)
        self.btn_mi_contrato.clicked.connect(self.mi_contrato)
        self.btn_domicilios.clicked.connect(self.domicilio)
        self.insumos_check.hide()
        self.productos_check.hide()
        self.btn_ventas.clicked.connect(self.ventas)
        self.btn_sucursales.clicked.connect(self.sucursales)
        self.btn_maquinaria.clicked.connect(self.maquinaria)
        self.btn_insumos.clicked.connect(self.insumos)
        self.btn_productos.clicked.connect(self.productos)
        self.btn_contratos.clicked.connect(self.contratos)
        self.btn_clientes.clicked.connect(self.clientes)
        self.btn_proveedores.clicked.connect(self.proveedores)


    def desconectar(self):
        widget.setFixedWidth(500)
        widget.setFixedHeight(400)
        print("logout funciona")
        inicio=login()
        widget.addWidget(inicio)
        widget.setCurrentIndex(widget.currentIndex()+1)
    
    def mi_informacion(self):
        
        nombre = self.nombre_label.text()
        apellido = self.apellido_label.text()
        contrasena = self.password_label.text()
        self.ventana =  mi_info(nombre,apellido,contrasena)
        self.ventana.show()
        
    def mi_contrato(self):
        nombre = self.nombre_label.text()
        apellido = self.apellido_label.text()
        contrasena = self.password_label.text()
        self.ventana =  mi_contrato(nombre,apellido,contrasena)
        self.ventana.show()


    def sucursales(self):
        self.insumos_check.hide()
        self.productos_check.hide()
        self.btn_insertar.hide()
        self.btn_eliminar.hide()
        self.btn_modificar.hide()
        self.tabla.clear()
        columnas = ("Categoria","Nombre","Ubicación","Ciudad","Administrador, Telefono")
        self.tabla.setHorizontalHeaderLabels(columnas)
        nombre = str(self.nombre_label.text())
        apellido = str( self.apellido_label.text())
        contrasena = str(self.password_label.text())
        usuario = str(nombre + " " + apellido)
        database = Database(usuario,contrasena)
        conteo = "SELECT COUNT(sucursal.nombre) FROM sucursal, empleado WHERE '{}' = concat(empleado.nombre,' ', empleado.apellido) AND empleado.idempleado = sucursal.administrador".format(usuario)
        database.cursor.execute(conteo)
        numeroregistros = database.cursor.fetchall()
        sql = "select sucursal.categoria, sucursal.nombre, sucursal.ubicacion, sucursal.ciudad, concat(empleado.nombre,' ', empleado.apellido), empleado.telefono from sucursal, empleado where empleado.idempleado = sucursal.administrador;" 
        database.cursor.execute(sql)
        info = database.cursor.fetchall()
        

        for fila in range(numeroregistros[0][0]):
            for registro in info:
                for columna in range(len(columnas)):
                    self.tabla.setItem(fila,columna,QtWidgets.QTableWidgetItem(registro[columna]))

    def ventas(self):
            self.insumos_check.show()
            self.productos_check.show()
            nombre = str(self.nombre_label.text())
            apellido = str( self.apellido_label.text())
            contrasena = str(self.password_label.text())
            usuario = str(nombre + " " + apellido)
            self.tabla.clear()
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
        self.tabla.clear()
        columnas = ("Producto","Nombre-Cliente","Apellido-Cliente","Nombre-Empleado","Apellido-Empleado","Sucursal")
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
        columnas = ("Nombre","Fecha_compra","Precio","Marca","Garantía","Estado_pago","Deuda")
        self.tabla.setHorizontalHeaderLabels(columnas)
        sql = "SELECT maquinaria_y_equipo.nombre, maquinaria_y_equipo.fecha_de_compra, maquinaria_y_equipo.precio, maquinaria_y_equipo.marca, maquinaria_y_equipo.garantia, maquinaria_y_equipo.estado_de_pago, maquinaria_y_equipo.cantidad_a_pagar FROM maquinaria_y_equipo, inventario, sucursal, empleado WHERE maquinaria_y_equipo.idInventario = inventario.idInventario AND inventario.idSucursal = sucursal.idSucursal AND sucursal.Administrador = empleado.idEmpleado AND '{}' = concat(empleado.nombre,' ', empleado.apellido)".format(usuario)
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
            self.tabla.setItem(fila,5,QtWidgets.QTableWidgetItem(registro[5]))
            self.tabla.setItem(fila,6,QtWidgets.QTableWidgetItem(str(registro[6])))
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
       sql = "select insumo.nombre, insumo.cantidad ,insumo.unidad_de_medida, insumo.precio_por_unidad_de_medida,insumo.marca, insumo.fecha_de_compra,insumo.estado_de_pago,insumo.cantidad_a_pagar, insumo.iva,sucursal.nombre from insumo,sucursal,inventario,empleado where insumo.idinventario = inventario.idinventario and sucursal.idsucursal = inventario.idsucursal AND sucursal.administrador = empleado.idempleado AND '{}' = concat(empleado.nombre,' ', empleado.apellido)".format(usuario)
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
       sql = "select producto.nombre,producto.precio,producto.fecha_de_produccion, producto.categoria,producto.fecha_de_caducidad, sucursal.nombre from producto, sucursal, empleado where producto.punto_de_fabricacion=sucursal.idsucursal AND sucursal.administrador = empleado.idempleado AND '{}' = concat(empleado.nombre,' ', empleado.apellido)".format(usuario)
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

    def clientes(self):
       self.insumos_check.hide()
       self.productos_check.hide()
       self.btn_insertar.hide()
       self.btn_eliminar.hide()

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
       columnas = ("Nombre","Apellido","Perfil")
       self.tabla.setHorizontalHeaderLabels(columnas)
       sql = "SELECT * FROM adm_clientes"
       database.cursor.execute(sql)
       info = database.cursor.fetchall()
        
       fila=0
       for registro in info:
            self.tabla.setItem(fila,0,QtWidgets.QTableWidgetItem(registro[0]))
            self.tabla.setItem(fila,1,QtWidgets.QTableWidgetItem(str(registro[1])))
            self.tabla.setItem(fila,2,QtWidgets.QTableWidgetItem(str(registro[2])))
            fila+=1    
    
    def contratos(self):
       self.insumos_check.hide()
       self.productos_check.hide()
       self.btn_insertar.hide()
       self.btn_eliminar.hide()

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
       columnas = ("Nombre","Cargo","Salario","Contratación","Terminación")
       self.tabla.setHorizontalHeaderLabels(columnas)
       sql = "SELECT * FROM adm_contratos"
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
        columnas = ("Nombre","Razón Social","Ubicación", "Categoria","Contacto","Teléfono")
        self.tabla.setHorizontalHeaderLabels(columnas)
        sql = "select * from proveedores_info"
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
        


## Ventana Funcionario
qtCreatorFile3="Ventana_Funcionario.ui"

Ui_MainWindow, QtBaseClass = uic.loadUiType(qtCreatorFile3)
     

class Ventana_funcionario(QtWidgets.QMainWindow, Ui_MainWindow):
    def __init__(self,nombre,apellido,cargo,contrasena):
        usuario=nombre+" "+apellido
        QtWidgets.QMainWindow.__init__(self)
        Ui_MainWindow.__init__(self)
        self.setupUi(self)  
        widget.setFixedWidth(760)
        widget.setFixedHeight(570)
        self.usuario_label.setText("Usuario: "+usuario)
        self.cargo_label.setText("Cargo: "+cargo)
        self.user_label.setText(usuario)
        self.nombre_label.setText(nombre)
        self.apellido_label.setText(apellido)
        self.password_label.setText(contrasena)
        self.btn_logout.clicked.connect(self.desconectar)
        self.btn_mi_info.clicked.connect(self.mi_informacion)
        self.btn_mi_contrato.clicked.connect(self.mi_contrato)
        
    
    def desconectar(self):
        
        widget.setFixedWidth(500)
        widget.setFixedHeight(400)
        print("logout funciona")
        inicio=login()
        widget.addWidget(inicio)
        widget.setCurrentIndex(widget.currentIndex()+1)
    
    def mi_informacion(self):
        
        nombre = self.nombre_label.text()
        apellido = self.apellido_label.text()
        contrasena = self.password_label.text()
        self.ventana =  mi_info(nombre,apellido,contrasena)
       # mi_info(nombre,apellido,contrasena)
        #self.ui.setupUi(self.ventana)
        #self.ventana.exec_()
        self.ventana.show()
        
    def mi_contrato(self):
        nombre = self.nombre_label.text()
        apellido = self.apellido_label.text()
        contrasena = self.password_label.text()
        self.ventana =  mi_contrato(nombre,apellido,contrasena)
        self.ventana.show()
        
## Ventana Domiciliario    
qtCreatorFile5="Ventana_Domiciliario.ui"

Ui_MainWindow, QtBaseClass = uic.loadUiType(qtCreatorFile5)
     

class Ventana_domiciliario(QtWidgets.QMainWindow, Ui_MainWindow):
    def __init__(self,nombre,apellido,cargo,contrasena):
        usuario=nombre+" "+apellido
        QtWidgets.QMainWindow.__init__(self)
        Ui_MainWindow.__init__(self)
        self.setupUi(self)  
        widget.setFixedWidth(790)
        widget.setFixedHeight(580)
        self.usuario_label.setText("Usuario: "+usuario)
        self.cargo_label.setText("Cargo: "+cargo)
        self.user_label.setText(usuario)
        self.nombre_label.setText(nombre)
        self.apellido_label.setText(apellido)
        self.password_label.setText(contrasena)
        self.btn_logout.clicked.connect(self.desconectar)
        self.btn_mi_info.clicked.connect(self.mi_informacion)
        self.btn_mi_contrato.clicked.connect(self.mi_contrato)
    
    def desconectar(self):
        widget.setFixedWidth(500)
        widget.setFixedHeight(400)
        print("logout funciona")
        inicio=login()
        widget.addWidget(inicio)
        widget.setCurrentIndex(widget.currentIndex()+1)
    
    def mi_informacion(self):
        
        nombre = self.nombre_label.text()
        apellido = self.apellido_label.text()
        contrasena = self.password_label.text()
        
        self.ventana =  mi_info(nombre,apellido,contrasena)
        self.ventana.show()
        
    def mi_contrato(self):
        nombre = self.nombre_label.text()
        apellido = self.apellido_label.text()
        contrasena = self.password_label.text()
        self.ventana =  mi_contrato(nombre,apellido,contrasena)
        self.ventana.show()
        


# Ventana de mi información
class mi_info(QtWidgets.QWidget):#,Ui_MainWindow ):
    def __init__(self,nombre,apellido,contrasena):
        QtWidgets.QWidget.__init__(self)
        uic.loadUi("info.ui",self)
        #Ui_MainWindow.__init__(self)
        #self.setupUi(self)
        usuario = nombre+' '+apellido
        
        database=Database(usuario,contrasena)
        
        sql = "SELECT * FROM info_empleados WHERE nombre = '{}' and apellido = '{}'".format(nombre,apellido)
        
        database.cursor.execute(sql)
        info = database.cursor.fetchall()
        for atributos in info:
            self.nombre_label.setText("Nombre: "+atributos[0])
            self.apellido_label.setText("Apellido: "+atributos[1])
            self.direccion_label.setText("Direccion: "+atributos[2])
            self.telefono_label.setText("Teléfono: "+atributos[3])
            self.eps_label.setText("EPS: "+atributos[4])
            self.ciudad_label.setText("Ciudad: "+atributos[5])
            self.fecha_label.setText("Fecha de Nacimiento: "+atributos[6])


## Ventana de Mi Contrato
class mi_contrato(QtWidgets.QWidget):#,Ui_MainWindow ):
    def __init__(self,nombre,apellido,contrasena):
        QtWidgets.QWidget.__init__(self)
        uic.loadUi("contrato.ui",self)
        #Ui_MainWindow.__init__(self)
        #self.setupUi(self)
        usuario = nombre+' '+apellido
        
        database=Database(usuario,contrasena)
        
        sql = "SELECT * FROM info_contratos WHERE nombre = '{}' and apellido = '{}'".format(nombre,apellido)
        
        database.cursor.execute(sql)
        info = database.cursor.fetchall()
        for atributos in info:
            self.cargo_label.setText("Cargo: "+atributos[2])
            self.salario_label.setText("Salario: "+str(atributos[3]))
            self.contratacion_label.setText("Fecha de Contratación: "+atributos[4])
            self.terminacion_label.setText("Fecha de Terminación: "+atributos[5])
            
        
## Ventana de Insertar empleado   

class insertar_empleado(QtWidgets.QWidget):#,Ui_MainWindow ):
    def __init__(self,nombre,apellido,contrasena):
        QtWidgets.QWidget.__init__(self)
        uic.loadUi("insertar_empleado.ui",self)

        usuario = nombre+' '+apellido
        self.usuario_label.setText(usuario)
        self.contrasena_label.setText(contrasena)
        self.insertar.clicked.connect(self.insercion)
        
    def insercion(self):
        dia_nacimiento = int(self.dia_nac.text())
        mes_nacimiento = int(self.mes_nac.text())
        
        
        dia_contratacion = int(self.dia_contratacion.text())
        mes_contratacion = int(self.mes_contratacion.text())
        
        
        dia_terminacion = int(self.dia_terminacion.text())
        mes_terminacion = int(self.mes_terminacion.text())

        try:
            nombre=str(self.nombre_label.text())
            apellido=str(self.apellido_label.text())
            direccion = str(self.direccion_label.text())
            telefono = str(self.telefono_label.text())
            eps = str(self.eps_label.text())
            ciudad = str(self.ciudad_label.text())
            cargo = str(self.cargo_label.text())
            salario = int(self.salario_label.text())
            salario = str(salario)
            año_contratacion = int(self.ano_contratacion.text())
            año_nacimiento = int(self.ano_nac.text())
            año_terminacion = int(self.ano_terminacion.text())
            permiso = cargo
            if(dia_nacimiento>0 and dia_contratacion>0 and  dia_terminacion >0 and mes_terminacion>0 and mes_contratacion > 0 and dia_nacimiento <=31 and dia_contratacion<=31 and dia_terminacion<=31 and mes_nacimiento <=12 and mes_contratacion<=12 and mes_terminacion<=12 and año_nacimiento>1950 and  año_contratacion>1950 and año_terminacion>1950 and año_nacimiento<2050 and año_contratacion<2050 and año_terminacion < 2050 and nombre!='' and apellido!='' and direccion!='' and telefono!='' and eps!='' and ciudad!='' and cargo!='' and salario!=''):
            
                fecha_nacimiento = conversor_fecha_int_str(dia_nacimiento,mes_nacimiento,año_nacimiento)
                fecha_contratacion = conversor_fecha_int_str(dia_contratacion,mes_contratacion,año_contratacion)
                fecha_terminacion = conversor_fecha_int_str(dia_terminacion,mes_terminacion,año_terminacion)
                usuario = self.usuario_label.text()
                contrasena = self.contrasena_label.text()
                database=Database(usuario,contrasena)
                sql = "select count(idempleado) from empleado where nombre = '{}' and apellido='{}'".format(nombre,apellido)
                
                database.cursor.execute(sql)
                conteo = database.cursor.fetchone()
                if conteo[0]>0:
                        self.error_label.setText("Existe un Usuario con este Nombre")
                
                elif(cargo!='Administrador' and cargo != 'Funcionario' and cargo != 'Domiciliario' and cargo != 'Jefe'):
                    self.error_label.setText("El cargo Suministrado no es válido")
                    print(cargo)
                else:
                        sql="select idcargo from cargos where nombre = '{}'".format(cargo)
                        database.cursor.execute(sql)
                        idcargo = database.cursor.fetchone()
                        idcargo = idcargo[0]
        
                        sql = "insert into contrato(NIT,idcargo,fecha_contratacion,salario,fecha_terminacion) values (123456789,{},'{}',{},'{}')".format(idcargo,fecha_contratacion,salario,fecha_terminacion)
                        database.cursor.execute(sql)
                        database.connection.commit()
                        print("ingresado en contrato")
                        
                        sql = "select max(idcontrato) from contrato"
                        database.cursor.execute(sql)
                        idcontrato = database.cursor.fetchone()
                        idcontrato = idcontrato[0]
                        
                        sql = "insert into empleado(idcontrato,nombre,apellido,direccion,telefono,eps,ciudad,fecha_de_nacimiento) values ({},'{}','{}','{}','{}','{}','{}','{}')".format(idcontrato,nombre,apellido,direccion,telefono,eps,ciudad,fecha_nacimiento)
                        database.cursor.execute(sql)
                        database.connection.commit()
                        print("empleado registrado")
                        
                    
                        self.error_label.setText("Empleado Registrado Exitosamente")
                        
                        
                        
            else: 
                self.error_label.setText("Datos Invalidos")
        except:
            self.error_label.setText("Datos Invalidos")



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



## Conversores

def conversor_fecha_int_str(dia,mes,año):
    if(dia>0 and dia<=31 and mes>0 and mes<=12 and año>1999 and año<2040):
        if(dia<10):
            dia = str(dia)
            if(dia[0]!='0'):
                dia='0'+str(dia)
        if(mes<10):
            mes = str(mes)
            if(mes[0]!='0'):
                mes='0'+str(mes)
                
    fecha=str(dia)+"-"+str(mes)+"-"+str(año)
    return fecha


def conversor_dia_str_int(fecha):
    if(fecha[2]=='-' and fecha[5]=='-'):
        dia = int(fecha[0]+fecha[1])
    
    return dia

def conversor_mes_str_int(fecha):
    if(fecha[2]=='-' and fecha[5]=='-'):
        mes = int(fecha[3]+fecha[4])
    
    return mes

def conversor_año_str_int(fecha):
    if(fecha[2]=='-' and fecha[5]=='-'):
        año = int(fecha[6]+fecha[7]+fecha[8]+fecha[9])
    
    return año

if __name__ == "__main__":
    app =  QtWidgets.QApplication(sys.argv)
    widget=QtWidgets.QStackedWidget()
    principal = login()
    widget.addWidget(principal)
    widget.setFixedWidth(500)
    widget.setFixedHeight(400)
    widget.show()
    sys.exit(app.exec_())
