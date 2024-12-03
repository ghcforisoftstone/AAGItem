#!/bin/bash

# 检查JDK是否安装
if [ -z "$(command -v java)" ]; then
    echo "JDK未安装，开始安装..."

    # 这里替换为你的JDK安装命令
    sudo dnf install java-1.8.0-amazon-corretto-devel

    # 等待JDK安装完成
    echo "正在等待JDK安装完成..."
    sleep 60  # 假设JDK安装需要30秒，可以根据实际情况调整这个时间

    # 后续命令
    echo "JDK安装完成，继续执行后续命令..."

    sudo java -version

    # 检查安装是否成功
    if [ -z "$(command -v java)" ]; then
        echo "JDK安装失败，脚本停止执行。"
        exit 1
    fi

    echo "JDK安装成功。"
else
    echo "JDK已安装。"
fi

# 定义JAR文件的路径
JAR_FILE_PATH="/home/ec2-user/AAGItem-1.0-SNAPSHOT.jar"

# 定义日志文件的路径
LOG_FILE_PATH="/home/ec2-user/my-project.log"

# 检查文件是否存在
if [ ! -e "$LOG_FILE_PATH" ]; then
    # 文件不存在，创建文件
    touch "$LOG_FILE_PATH"
    echo "文件已创建：$LOG_FILE_PATH"
else
    echo "文件已存在：$LOG_FILE_PATH"
fi


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
exec nohup java -jar $JAR_FILE_PATH  >  $LOG_FILE_PATH 2>&1 &
