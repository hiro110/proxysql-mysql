STOP SLAVE;
CHANGE MASTER TO
    MASTER_HOST='mysql-master',
    MASTER_USER='app',
    MASTER_PASSWORD='nXpxX2QBHHwwtbUTWLVRvg6QTiT5reC2',
    MASTER_LOG_FILE='mysql-bin.000001',
    MASTER_LOG_POS=0;
START SLAVE;