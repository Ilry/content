import os
import zipfile
from datetime import datetime

# 获取当前时间
now_time = datetime.now()
# formatted_time = now_time.strftime("%Y-%m-%d %H:%M:%S")
formatted_time = now_time.strftime("%m-%d_%H-%M")

BASE_DIR = os.getcwd()

def gen_dir(*arg: str) -> str:
    return os.path.join(BASE_DIR, *arg)

def pack_current_directory(exclude_paths: list):
    zip_filename = f"dst_mod-lol_wp_{formatted_time}.zip"
    exclude_paths.append(gen_dir(zip_filename))
    with zipfile.ZipFile(zip_filename, 'w', zipfile.ZIP_DEFLATED) as zipf:
        for root, dirs, files in os.walk(BASE_DIR):
            # 排除指定的文件和文件夹
            dirs[:] = [d for d in dirs if os.path.join(root, d) not in exclude_paths]
            files = [f for f in files if os.path.join(root, f) not in exclude_paths]
            
            for file in files:
                file_path = os.path.join(root, file)
                arcname = os.path.relpath(file_path, start=BASE_DIR)
                zipf.write(file_path, arcname)

# 示例调用
exclude_list = [
    gen_dir('.git'),
    gen_dir('.vscode'),
    gen_dir('_temp'),
    gen_dir('DETAILS'),
    gen_dir('exported'),
    gen_dir('LSP'),
    gen_dir('pack.py'),
]
pack_current_directory(exclude_list)