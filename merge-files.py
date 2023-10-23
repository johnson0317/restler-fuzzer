import os
def get_filename(path, match):
    all_files = os.listdir(path)
    for file in all_files:
        if match in file:
            print(f'The file name under {path} is {file}')
            return file
    return 'Nothing found'
print("Executing Python script")
filename = get_filename('/Fuzz/RestlerResults/', 'experiment')
with open(f'/Fuzz/RestlerResults/{filename}/logs/main.txt', 'a') as file:
    file.write("\n\n=====================The requests are listed below==========================\n\n")
    request_file = get_filename(f'/Fuzz/RestlerResults/{filename}/logs/', 'network.testing')
    with open(f'/Fuzz/RestlerResults/{filename}/logs/{request_file}', 'r') as myfile:
        for line in myfile.readlines():
            file.write(line)
            file.write('\n')
print("Finish Python script execution")