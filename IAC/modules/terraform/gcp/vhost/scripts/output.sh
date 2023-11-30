#!/bin/bash
# 遍历输出行并设置 GitHub Actions 输出变量

for line in `terraform_output`:
do
    key=`echo $line | awk -F= 'print $1'`
    value=`echo $line | awk -F= 'print $2'`
    echo "$key=$value" >> "$GITHUB_OUTPUT"
done
