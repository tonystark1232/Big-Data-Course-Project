from pyhive import hive
import pymysql

# Hive 连接配置
hive_conn = hive.Connection(host='localhost', port=10000, username='hadoop', database='ai_test')
hive_cursor = hive_conn.cursor()

# 查询 Hive 中的数据
hive_cursor.execute("SELECT * FROM ads_yj_xl_gl")
rows = hive_cursor.fetchall()

# MySQL 连接配置
mysql_conn = pymysql.connect(
    host='localhost',
    port=3306,
    user='root',
    password='123456',
    database='ai_test_bi',
    charset='utf8mb4'
)
mysql_cursor = mysql_conn.cursor()

# 插入数据到 MySQL（假设 MySQL 表结构已存在且字段顺序一致）
insert_sql = """
    INSERT INTO ads_yj_xl_gl (month, price_92, sales_total, sales_growth_rate)
    VALUES (%s, %s, %s, %s)
"""

# 清空原有数据（可选）
mysql_cursor.execute("DELETE FROM ads_yj_xl_gl")

# 批量插入
mysql_cursor.executemany(insert_sql, rows)
mysql_conn.commit()

# 关闭连接
mysql_cursor.close()
mysql_conn.close()
hive_cursor.close()
hive_conn.close()

print("数据已成功从 Hive 导入到 MySQL")
