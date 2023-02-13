from mysql.connector.pooling import MySQLConnectionPool
from mysql.connector import Error

dbconfig = {
    "database": "little_lemon_db",
    "user": "root",
    "password": ""
}


def make_query(table = '', fields = ['*'], where_condition = '', order_by = '', limit = ''):
    
    where_condition_c = " where {}".format(where_condition) if where_condition != '' else ''
    order_by_c = " order by {}".format(order_by) if order_by != '' else ''
    limit_c = " limit {}".format(limit) if limit != '' else ''
    fields_c = ', '.join(map(str, fields))
    
    return "SELECT {} from {} {} {} {}".format(fields_c, table, where_condition_c, order_by_c, limit_c)
    

try:
    pool = MySQLConnectionPool(pool_name = "pool_b", pool_size=2, **dbconfig)
    print("Conectado, realizando peticiones")

    print("+-----------------------------+")

    connection = pool.get_connection()

    if connection.is_connected:
        cursor = connection.cursor()
        
        print("################")
        print("Primer sentencia: ")
        cursor.execute(
            make_query("employees", ['EmployeeID', 'Name'], 'Role = "Manager"')
        )
        data = cursor.fetchall()
        
        print("El manager {} de Little Lemon tiene el id: {}".format(data[0][1], data[0][0]))

        print("################")
        print("Segunda sentencia: ")
        cursor.execute(
            make_query('employees', ['Name', 'Role', 'Annual_Salary'], '', 'Annual_Salary desc', 1)
        )
        data = cursor.fetchall()        
        print("El {} {} es el que gana mas: {}".format(data[0][1], data[0][0], data[0][2]))

        print("################")
        print("Tercer sentencia: ")
        cursor.execute(
            make_query('bookings', ['count(*)'], ' hour(BookingSlot) between 18 and 20 ')
        )
        data = cursor.fetchall()        
        print("Hubo {} reservas entre las 18 y 20 horas hoy.".format(data[0][0]))

        print("################")
        print("Cuarta sentencia: ")
        cursor.execute(
            make_query(
                'bookings', 
                ['concat(GuestFirstName, " ", GuestLastName)', 'BookingID', 'BookingSlot'], 
                '', 'BookingSlot asc')
        )
        data = cursor.fetchall()        
        for i in range(len(data)):
            print("Cliente {} con id {} esperando desde las {}.".format(data[i][0], data[i][1], data[i][2]))

        print("################")
        print("Quinta tarea, llamar procedimiento BasicSalesReport: ")

        cursor.callproc('BasicSalesReport')
        res = next(cursor.stored_results())

        data = res.fetchall()

        print("Hubo {} ventas generando {} pesos, promedio: {}, venta minima: {}, maxima: {}"
            .format(data[0][0], data[0][1], data[0][2], data[0][3], data[0][4]))





    else:
        print("No se puede establecer conexión")
            
    connection.close()

except Error as e:
    print("Error: {} -> {}".format(e.errno, e.msg))