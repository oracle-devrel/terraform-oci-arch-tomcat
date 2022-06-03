create database ${oci_mds_db_name};
use ${oci_mds_db_name};
GRANT ALL ON ${oci_mds_db_name}.* TO admin@"%";
CREATE TABLE todos (id bigint(20) NOT NULL AUTO_INCREMENT, title varchar(255) DEFAULT NULL, description varchar(255) DEFAULT NULL, is_done bit(1) NOT NULL, PRIMARY KEY (id)) AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci; 
select * from todos;
