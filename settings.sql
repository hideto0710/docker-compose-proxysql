INSERT INTO mysql_servers (hostname, hostgroup_id, port, weight, max_connections)
VALUES ('mysql', 10, 3306, 1000, 2000);
INSERT INTO mysql_servers (hostname, hostgroup_id, port, weight, max_connections)
VALUES ('mysql-slave', 20, 3306, 1000, 2000);
LOAD MYSQL SERVERS TO RUNTIME;

INSERT INTO mysql_replication_hostgroups (writer_hostgroup, reader_hostgroup, comment, check_type)
VALUES (10, 20, 'aws-aurora', 'innodb_read_only');
INSERT INTO mysql_query_rules (rule_id, active, match_digest, destination_hostgroup, apply)
VALUES (50, 1, '^SELECT.*FOR UPDATE$', 10, 1), (51, 1, '^SELECT', 20, 1);
LOAD MYSQL QUERY RULES TO RUNTIME;

INSERT INTO mysql_users (username, password, active, default_hostgroup, default_schema, transaction_persistent)
VALUES ('sample', 'password', 1, 10, 'sample', 1);
LOAD MYSQL USERS TO RUNTIME;

UPDATE global_variables SET variable_value='sample' WHERE variable_name='mysql-monitor_username';
UPDATE global_variables SET variable_value='password' WHERE variable_name='mysql-monitor_password';
UPDATE global_variables SET variable_value='5.7' WHERE variable_name='mysql-server_version';
UPDATE global_variables SET variable_value='2000' WHERE variable_name IN ('mysql-monitor_connect_interval', 'mysql-monitor_ping_interval', 'mysql-monitor_read_only_interval');
LOAD MYSQL VARIABLES TO RUNTIME;
