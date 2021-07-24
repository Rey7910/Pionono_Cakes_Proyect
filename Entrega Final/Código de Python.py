import mysql.connector
import datetime

class Database:
    def __init__(self,nombre,apellido,contrasena):
        self.connection = mysql.connector.connect(
            host="localhost",user= usuario,
            password = contrasena, db="pionono_cakes",
            auth_plugin='mysql_native_password'
            )
        
        self.cursor = self.connection.cursor()
        print("Conexión exitosa")

    def cerrar_conexion(self):
        self.connection.close()
    
    def obtener_cargo(self):
        sql = "SELECT cargo FROM info_contratos  WHERE nombre='{}' AND apellido = '{}' ".format(nombre,apellido)
        try:
            self.cursor.execute(sql)
            cargo=self.cursor.fetchone()
            return cargo[0]
        
        except Exception as e:
            raise
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
    
    def obtener_sucursal(self,id):
        sql = "SELECT nombre FROM sucursal  WHERE administrador= {} ".format(id)
        try:
            self.cursor.execute(sql)
            sucursal=self.cursor.fetchone()
            return sucursal[0]
        
        except Exception as e:
            raise
            
    def obtener_mi_info(self,nombre,apellido):
        sql = "SELECT * FROM info_empleados WHERE nombre = '{}' and apellido = '{}'".format(nombre,apellido)
        print(sql)
        try:
            self.cursor.execute(sql)
            info = self.cursor.fetchall()
            for atributos in info:
                print("Nombre: ",atributos[0])
                print("Apellido: ",atributos[1])
                print("Direccion: ",atributos[2])
                print("Teléfono: ",atributos[3])
                print("EPS: ",atributos[4])
                print("Ciudad: ",atributos[5])
                print("Fecha de Nacimiento: ",atributos[6])
                print("-----")
        except Exception as e:
            raise
    def obtener_mi_info_contrato(self,nombre,apellido):
        sql = "select cargo, salario, fecha_contratacion, fecha_terminacion from info_contratos WHERE nombre = '{}' and apellido = '{}'".format(nombre,apellido)
        try:
            self.cursor.execute(sql)
            info = self.cursor.fetchall()
            for atributos in info:
                print("Cargo: ",atributos[0])
                print("Salario: ",atributos[1])
                print("Fecha de contratación: ",atributos[2])
                print("Fecha de Terminación: ",atributos[3])
                print("-----")
        except Exception as e:
            raise
   
    def insertar_Empleado(self,nombre, apellido,direccion,telefono,eps,ciudad,dia_nacimiento,mes_nacimiento,año_nacimiento, cargo,dia_contratacion,mes_contratacion,año_contratacion,salario,dia_terminacion,mes_terminacion,año_terminacion):
        
        fecha_nacimiento = conversor_fecha_int_str(dia_nacimiento,mes_nacimiento,año_nacimiento)
        fecha_contratacion = conversor_fecha_int_str(dia_contratacion,mes_contratacion,año_contratacion)
        fecha_terminacion = conversor_fecha_int_str(dia_terminacion,mes_terminacion,año_terminacion)
        
        sql = "select count(idempleado) from empleado where nombre = '{}' and apellido='{}'".format(nombre,apellido)
        try:
            self.cursor.execute(sql)
            conteo=self.cursor.fetchone()
            if conteo[0]>0:
                print("Nombres Repetidos")
            else:
                sql="select idcargo from cargos where nombre = '{}'".format(cargo)
                self.cursor.execute(sql)
                idcargo = self.cursor.fetchone()
                idcargo = idcargo[0]

                sql = "insert into contrato(NIT,idcargo,fecha_contratacion,salario,fecha_terminacion) values (123456789,{},'{}',{},'{}')".format(idcargo,fecha_contratacion,salario,fecha_terminacion)
                self.cursor.execute(sql)
                self.connection.commit()
                print("ingresado en contrato")
                
                sql = "select max(idcontrato) from contrato"
                self.cursor.execute(sql)
                idcontrato = self.cursor.fetchone()
                idcontrato = idcontrato[0]
                
                sql = "insert into empleado(idcontrato,nombre,apellido,direccion,telefono,eps,ciudad,fecha_de_nacimiento) values ({},'{}','{}','{}','{}','{}','{}','{}')".format(idcontrato,nombre,apellido,direccion,telefono,eps,ciudad,fecha_nacimiento)
                self.cursor.execute(sql)
                self.connection.commit()
                print("empleado registrado")
        except Exception as e:
            raise
    
    def borrar_empleados(self,nombre,apellido):
        sql="select idcontrato from empleado where nombre='{}' and apellido='{}'".format(nombre, apellido)
        try:
            self.cursor.execute(sql)
            idcontrato = self.cursor.fetchone()
            idcontrato = idcontrato[0]
            print(idcontrato)
            sql = "delete from empleado where idcontrato={}".format(idcontrato)
            self.cursor.execute(sql)
            self.connection.commit()
            print("borrado de empleado")
            sql = "delete from contrato where idcontrato={}".format(idcontrato)
            self.cursor.execute(sql)
            self.connection.commit()
            print("borrado de contrato")
            
        except:
            raise
    
    def info_empleados(self):
        sql = "select * from empleado"
        try:
            self.cursor.execute(sql)
            empleados = self.cursor.fetchall()
            for empleado in empleados:
                print("Nombre: ",empleado[2])
                print("Apellido: ",empleado[3])
                print("-----")
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


## Main

try:
    nombre = input()
    apellido = input()
    contrasena = input()
    usuario = nombre+" "+apellido
    print(usuario)
    database = Database(nombre,apellido,contrasena)
    database.info_empleados()
    cargo = database.obtener_cargo()
    print(cargo)
  
    try:
        id = database.obtener_id(nombre,apellido)
        print('id: ',id)
    except:
        print("fallo") 
    
    if cargo == 'Administrador':
        sucursal=database.obtener_sucursal(id)
        print('Sucursal: ',sucursal)
    
    print("-------")
    database.obtener_mi_info(nombre, apellido)
    database.obtener_mi_info_contrato(nombre, apellido)
    
    if cargo=='Jefe':
        try:
            database.insertar_Empleado("Reinaldo", "Toledo","Cll 26 - Bogotá","3108023456","Colsanitas","Bogotá",1,5,2002,"Jefe",1,4,2021,100000,3,11,2021)
            print("empleado registrado")
            database.borrar_empleados("Reinaldo", "Toledo")
        except:
            print("no ha sido posible el registro")
    database.cerrar_conexion()
except:
    print("Usuario o contraseña incorrectos")
    
