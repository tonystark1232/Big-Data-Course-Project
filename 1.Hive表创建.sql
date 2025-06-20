drop database ai_test cascade ;
create database ai_test;

CREATE TABLE IF NOT EXISTS public_charging_pile (
  dt STRING COMMENT '时间，格式为YYYY-MM-DD',
  cq INT COMMENT '重庆公共类充电桩数量(台)',
  bj INT COMMENT '北京公共类充电桩数量(台)',
  gd INT COMMENT '广东公共类充电桩数量(台)',
  sh INT COMMENT '上海公共类充电桩数量(台)',
  zj INT COMMENT '浙江公共类充电桩数量(台)',
  ah INT COMMENT '安徽公共类充电桩数量(台)',
  tj INT COMMENT '天津公共类充电桩数量(台)',
  sc INT COMMENT '四川公共类充电桩数量(台)',
  sd INT COMMENT '山东公共类充电桩数量(台)',
  js INT COMMENT '江苏公共类充电桩数量(台)',
  dc_national INT COMMENT '全国直流充电桩数量(台)',
  ac_national INT COMMENT '全国交流充电桩数量(台)'
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
TBLPROPERTIES ('skip.header.line.count'='1');
 
 
CREATE TABLE IF NOT EXISTS gasoline_price (
  dt STRING COMMENT '时间，格式为YYYY年MM月',
  price_98 DECIMAL(12,10) COMMENT '98#汽油全国零售价格(元/升)',
  price_95 DECIMAL(12,10) COMMENT '95#汽油全国零售价格(元/升)',
  price_92 DECIMAL(12,10) COMMENT '92#汽油全国零售价格(元/升)'
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
TBLPROPERTIES ('skip.header.line.count'='1');
 
 
CREATE TABLE IF NOT EXISTS new_energy_vehicle (
  dt STRING COMMENT '时间，格式为YYYY年MM月',
  production_total DECIMAL(10,2) COMMENT '新能源汽车产量(万辆)',
  sales_total DECIMAL(10,2) COMMENT '新能源汽车销量(万辆)',
  production_ev DECIMAL(10,2) COMMENT '纯电动汽车产量(万辆)',
  sales_ev DECIMAL(10,2) COMMENT '纯电动汽车销量(万辆)',
  production_phev DECIMAL(10,2) COMMENT '插电式混合动力汽车产量(万辆)',
  sales_phev DECIMAL(10,2) COMMENT '插电式混合动力汽车销量(万辆)'
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
TBLPROPERTIES ('skip.header.line.count'='1');
 