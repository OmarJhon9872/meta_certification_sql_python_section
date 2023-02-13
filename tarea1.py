from mysql.connector.pooling import MySQLConnectionPool
from mysql.connector import Error

dbconfig = {
    "database": "little_lemon_db",
    "user": "root",
    "password": ""
}

try:
    pool = MySQLConnectionPool(pool_name = "pool_b", pool_size=2, **dbconfig)

    conn = pool.get_connection()

    if conn.is_connected:
        print("Conectado")
    else:
        print("Fallo al establecer la conexión")

    conn.close()

except Error as e:
    print("Error: {} -> {}".format(e.errno, e.msg))