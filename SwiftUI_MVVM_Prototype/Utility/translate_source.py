import os
import re
from googletrans import Translator, LANGUAGES

def extract_and_translate_japanese_strings(file_path, translator):
    japanese_strings = []
    new_lines = []

    try:
        with open(file_path, 'r', encoding='utf-8') as file:
            lines = file.readlines()
    except Exception as e:
        raise Exception(f"Error reading file {file_path}: {e}")

    japanese_regex = re.compile(r'[\u3040-\u30FF\u4E00-\u9FFF\uFF66-\uFF9F]+')

    for line_num, line in enumerate(lines, start=1):
        matches = japanese_regex.findall(line)
        if matches:
            for match in matches:
                try:
                    translated = translator.translate(match, src='ja', dest='en').text
                    print(f"{file_path}:{line_num}: {match} -> {translated}")
                    line = line.replace(match, f"{match}/{translated}")
                except Exception as e:
                    print(f"Error translating {match}: {e}")
        new_lines.append(line)

    try: 
        with open(file_path, 'w', encoding='utf-8') as file:
            file.writelines(new_lines)
    except Exception as e:
        raise Exception(f"Error writing file {file_path}: {e}")

def main():
    # Directory containing your Swift source files
    source_directory = "/Users/giauhuynh/Desktop/karasta-ios"
    translator = Translator()

    for root, _, files in os.walk(source_directory):
        for file in files:
            if file.endswith(".swift") or file.endswith(".storyboard") or file.endswith(".xib") or file.endswith(".strings"):
                file_path = os.path.join(root, file)
                # print(f"{file_path}")
                try:
                    extract_and_translate_japanese_strings(file_path, translator)
                except Exception as e:
                    print(f"Error...: {file_path}: {e}")
                    continue

if __name__ == "__main__":
    main()



"""
translate_source.py là script dùng để dịch tất cả text Japanese trong source code thành English.
Ví dụ:
- Text gốc: 
"カメラ"
- Text sau khi chạy script:
"カメラ/camera"

*** HOW TO USE ***
1. Cài đặt python, pip, googletrans
* python
- Cài đặt:
brew install python 
- Xác nhận đã cài đặt: 
python3 --version

* pip
- Cài đặt:
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py
- Xác nhận đã cài đặt:
pip3 --version

* googletrans
- Cài đặt: 
pip3 install googletrans==4.0.0-rc1
- Xác nhận đã cài đặt:
pip3 list
=> nếu trong danh sách có googletrans là đã cài thành công.

2. Sửa đường dẫn đến source code
- Tìm và sửa dòng sau: 
source_directory = "/Users/giauhuynh/Desktop/karasta-ios"
thay bằng đường dẫn source code của bạn.

3. Đổi điều kiện tìm file
- Tìm và sửa dòng sau:
if file.endswith(".swift") or file.endswith(".storyboard") or file.endswith(".xib"):
thay thành các extension (hoặc tên file) như ".java", ".kt", ".xml", ".php", ".js"...

4. Run script
- Mở Terminal và run:
python3 duong-dan-den-file-translate_source.py
ví dụ: python3 ~/Downloads/translate_source.py

"""



 
































