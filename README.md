# docker-compose-proxysql

```bash:terminal0
docker-compose up
```

```bash:terminal2
docker exec -it docker-compose-proxysql_mysql_1 tail -f /var/log/mysql/query.log
```
```bash:terminal2
docker exec -it docker-compose-proxysql_mysql-slave_1 tail -f /var/log/mysql/query.log
```

```bash::terminal3
mysql -h 0.0.0.0 -P 6032 -u radmin -p < ./settings.sql
# => radmin
mysql -h 0.0.0.0 -P 6033 -u sample -p
# => password

SELECT * FROM `users`;
INSERT INTO `users` (`id`,`name`) VALUES (1, 'taro');
SELECT * FROM `users`;
```

## Ref
- [オープンソースプラットフォームで ProxySQL を使用して、Amazon Aurora クラスターでの SQL の読み取りと書き込みを分割する方法 | Amazon Web Services ブログ](https://aws.amazon.com/jp/blogs/news/how-to-use-proxysql-with-open-source-platforms-to-split-sql-reads-and-writes-on-amazon-aurora-clusters/)
- [docker-composeでMaster/Slave構成のMySQLを手に入れる - Qiita](https://qiita.com/takyam/items/f13bc4a1db0433ffb958)
