# PROJECT MYSQL

Date Created: Aug 27, 2020 2:25 PM
Status: Done 🙌

[MYSQL Replication Brief](https://www.notion.so/MYSQL-Replication-Brief-9e78fe3087a94f61b3de0f1cd16aef6e)

[MySQL Cluster](PROJECT%20MYSQL%2059fed12e5c414cd1bdf37a725a701529/MySQL%20Cluster%201960fd9257014e0d81965aeabed85aa3.md)

# Docs

[MySQL :: MySQL 8.0 Reference Manual :: 17 Replication](https://dev.mysql.com/doc/refman/8.0/en/replication.html)

[Sync two MySQL databases in two different locations](https://dba.stackexchange.com/questions/65351/sync-two-mysql-databases-in-two-different-locations)

[MySQL :: MySQL Workbench Manual :: 9.5.1 Database Synchronization](https://dev.mysql.com/doc/workbench/en/wb-database-synchronization.html)

[How To Set Up Master Slave Replication in MySQL | DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-set-up-master-slave-replication-in-mysql)

[How to Configure MySQL 8.0 Master Slave Replication on Ubuntu 18.04 | ComputingForGeeks](https://computingforgeeks.com/how-to-configure-mysql-8-0-master-slave-replication-on-ubuntu-18-04/)

[MySQL Replication for High Availability - Tutorial](https://severalnines.com/resources/database-management-tutorials/mysql-replication-high-availability-tutorial)

[MySQL: chained replication M1>S1>S2 - Supportex.NET blog](https://supportex.net/blog/2011/11/mysql-chained-replication-m1s1s2/)

[MySQL 5.7 multi-source replication](https://www.percona.com/blog/2013/10/02/mysql-5-7-multi-source-replication/)

[What is the difference between binlog-do-db and replicate-do-db?](https://stackoverflow.com/questions/44431961/what-is-the-difference-between-binlog-do-db-and-replicate-do-db)

[MySQL Circular Replication](https://icicimov.github.io/blog/high-availability/database/MySQL-Circular-Replication/)

[MySQL :: MySQL 5.7 Reference Manual :: 21 MySQL NDB Cluster 7.5 and NDB Cluster 7.6](https://dev.mysql.com/doc/refman/5.7/en/mysql-cluster.html)

[Establish Semi-Synchronous Replication](http://mysql.wingtiplabs.com/documentation/sem40sk7/establish-semi-synchronous-replication.html)

---

[How To Create a Multi-Node MySQL Cluster on Ubuntu 18.04 | DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-create-a-multi-node-mysql-cluster-on-ubuntu-18-04)

[MySQL :: MySQL NDB Cluster 7.5 :: 5.3 NDB Cluster Configuration Files](https://dev.mysql.com/doc/mysql-cluster-excerpt/5.7/en/mysql-cluster-config-file.html)

[MySQL :: MySQL NDB Cluster 7.5 :: 5.3.1 NDB Cluster Configuration: Basic Example](https://dev.mysql.com/doc/mysql-cluster-excerpt/5.7/en/mysql-cluster-config-example.html#mysql-cluster-config-ini-sections)

```bash
apt-get -f install -o Dpkg::Options::="--force-overwrite"
apt-get purge mysql\*
rm -rf /var/lib/mysql
rm -rf /etc/mysql
dpkg -l | grep -i mysql
apt-get clean
updatedb

sudo apt-get purge xxx
```