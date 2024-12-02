#!/bin/bash

# 定义JAR文件的路径
JAR_FILE_PATH="/home/ec2-user/AAGItem-1.0-SNAPSHOT.jar"

# 定义JVM选项
JAVA_OPTS="-Xms512m -Xmx1024m"

# 使用pgrep查找jar包对应的Java进程
PIDS=$(pgrep -f $JAR_FILE_PATH)

if [ -z "$PIDS" ]; then
    echo "No running $JAR_FILE_PATH process found."
else
    echo "Killing $JAR_FILE_PATH processes: $PIDS"
    kill -9 $PIDS 2>/dev/null
fi


# 检查JAR文件是否存在
if [ ! -f "$JAR_FILE_PATH" ]; then
    echo "JAR文件不存在: $JAR_FILE_PATH"
    exit 1
fi

# 启动Java应用程序
exec nohup java -jar $JAR_FILE_PATH  >  /home/ec2-user/my-project.log 2>&1 &
