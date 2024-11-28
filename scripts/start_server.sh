#!/bin/bash
#这里可替换为你自己的执行程序的文件名
APP_NAME=AAGItem-1.0-SNAPSHOT.jar
#启动项目的路径
APP_PATH=./${APP_NAME}.jar
#输出日志的路径
LOG_PATH=./${APP_NAME}.log

#使用说明，用来提示输入参数
usage(){
    echo "Usage: sh server.sh [start|stop|restart|status] || ./server.sh [start|stop|restart|status]"
    exit 1
}

#检查程序是否在运行
is_exist(){
  pid=`ps -ef|grep $APP_NAME.jar|grep -v grep|awk '{print $2}'`
  #如果不存在返回1，存在返回0
  if [ -z "${pid}" ]; then
   return 1
  else
    return 0
  fi
}

#启动方法
start(){
  is_exist
  if [ $? -eq 0 ]; then
    echo "${APP_NAME} is already running. pid=${pid}"
  else
    # 执行jar的命令,nohup表示永久运行。&表示后台运行
    # --server.port=8001 设置端口
    # nohup java -jar ${APP_PATH} --server.port=8001 >> ${LOG_PATH} 2>&1 &
    nohup java -jar ${APP_PATH} >> ${LOG_PATH} 2>&1 &
    echo "${APP_NAME} start success"
  fi
}

#停止方法
stop(){
  is_exist
  if [ $? -eq "0" ]; then
    kill -9 $pid
    echo "${APP_NAME} stop success"
  else
    echo "${APP_NAME} is not running"
  fi
}

#输出运行状态
status(){
  is_exist
  if [ $? -eq "0" ]; then
    echo "${APP_NAME} is running. Pid is ${pid}"
  else
    echo "${APP_NAME} is not running."
  fi
}

#重启
restart(){
  stop
  sleep 1
  start
  echo "${APP_NAME} restart success"
}

#根据输入参数，选择执行对应方法，不输入则执行使用说明
case "$1" in
  "start")
    start
    ;;
  "stop")
    stop
    ;;
  "status")
    status
    ;;
  "restart")
    restart
    ;;
  *)
    usage
    ;;
esac


