#!/bin/bash

# 定义JAR文件的路径
JAR_FILE_PATH="/home/ec2-user/AAGItem-1.0-SNAPSHOT.jar"

# 定义JVM选项
JAVA_OPTS="-Xms512m -Xmx1024m"

# 检查JAR文件是否存在
if [ ! -f "$JAR_FILE_PATH" ]; then
    echo "JAR文件不存在: $JAR_FILE_PATH"
    exit 1
fi

# 启动Java应用程序
exec java $JAVA_OPTS -jar $JAR_FILE_PATH $@
