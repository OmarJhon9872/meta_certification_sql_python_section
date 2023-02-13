#Import required modules
from mysql.connector.pooling import MySQLConnectionPool
from mysql.connector import Error
import mysql.connector as connector

#Make configuration data
dbconfig = {
    "database": "little_lemon_db",
    "user": "root",
    "password": ""
}

#Try except block 
try:
    
    #Invitados
    guests = [
        {"table_number": 8, "first_name": "Anees", "last_name": "Java", "booking_time": "18:00", "employeeID": 6},
        {"table_number": 5, "first_name": "Bald", "last_name": "Vin", "booking_time": "19:00", "employeeID": 6},
        {"table_number": 12, "first_name": "Jay", "last_name": "Kon", "booking_time": "19:30", "employeeID": 6}, 
    ]
    #Se crea la conexion
    pool = MySQLConnectionPool(pool_name = "pool_b", pool_size=2, **dbconfig)
    
    print("Conectado, realizando peticiones")
    print("El tamaño del pool inicial es: {}".format(pool.pool_size))

    #Recorrer a los invitados
    for guest in guests:
        try:
            #Obtener conexion por empleado y mostrar datos
            guest_connected = pool.get_connection()            
            print("Table Number {}, First Name {}, Last Name {}, Booking Time {}, EmployeeID {} se conecto."
                  .format(guest["table_number"], guest["first_name"], guest["last_name"], guest["booking_time"], guest["employeeID"]))
        except:        
            #En caso de errar generar una nueva conexion
            print("Ya no hay conexiones libres, creando una.")
            
            connection = connector.connect(user=dbconfig["user"],password=dbconfig["password"])
            pool.add_connection(cnx=connection)
            user_connected = pool.get_connection()
            
            print("Extra connection: Table Number {}, First Name {}, Last Name {}, Booking Time {}, EmployeeID {} se conecto."
                  .format(guest["table_number"], guest["first_name"], guest["last_name"], guest["booking_time"], guest["employeeID"]))

    print("El tamaño del pool quedo en: {}".format(pool.pool_size))
    #Cerrar la conexion
    connection.close()

except Error as e:
    print("Error: {} -> {}".format(e.errno, e.msg))