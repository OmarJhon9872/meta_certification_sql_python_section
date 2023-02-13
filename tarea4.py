from mysql.connector.pooling import MySQLConnectionPool
from mysql.connector import Error
import mysql.connector as connector

dbconfig = {
    "database": "little_lemon_db",
    "user": "root",
    "password": ""
}

try:

    pool = MySQLConnectionPool(pool_name = "pool_b", pool_size=2, **dbconfig)
    
    print("Conectado, realizando peticiones")


    try:
        conn = pool.get_connection()
        if conn.is_connected:
            cursor = conn.cursor(buffered = True)

            cursor.execute("""
                SELECT b.BookingSlot, concat(b.GuestFirstName, " ", b.GuestLastName), e.Name, e.Role from bookings b left join employees e on b.EmployeeID = e.EmployeeID limit 3
            """)

            data = cursor.fetchall()

            for i in range(len(data)):
                print("{} {} Asignado al {} {}".format(data[i][0], data[i][1], data[i][3], data[i][2]))

    except:        
        print("Ya no hay conexiones libres.")
        
        
    conn.close()

except Error as e:
    print("Error: {} -> {}".format(e.errno, e.msg))