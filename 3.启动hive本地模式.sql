-- 启用本地模式
set hive.exec.mode.local.auto=true;

-- 设置本地执行文件大小和任务数阈值（可选优化）
set hive.exec.mode.local.auto.input.files.max=20;
set hive.exec.mode.local.auto.inputbytes.max=134217728; -- 128MB
