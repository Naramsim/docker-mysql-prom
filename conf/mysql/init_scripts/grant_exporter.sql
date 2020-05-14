CREATE USER 'prometheus'@'%' IDENTIFIED BY 'prometheus';
GRANT PROCESS, REPLICATION CLIENT ON *.* TO 'prometheus'@'%';
GRANT SELECT ON performance_schema.* TO 'prometheus'@'%';
