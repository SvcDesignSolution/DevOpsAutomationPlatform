import json
import subprocess

# 执行 terraform output 命令
terraform_output = subprocess.check_output(['terraform', 'output'], text=True)

# 将 Terraform 输出按行拆分
output_lines = terraform_output.strip().split('\n')

# 遍历输出行并设置 GitHub Actions 输出变量

for line in output_lines:
    key = line.split('=', 0)
    value = line.split('=', 1)
    print(f"::set-output name={key}::{value}")
