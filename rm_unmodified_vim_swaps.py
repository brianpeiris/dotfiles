import subprocess

output = subprocess.run(["vim", "-recover"], stderr=subprocess.PIPE).stderr
output = [line.strip() for line in output.split(b"\n")]

start = 0
for line in output:
    if line.startswith(b"1."): break
    start += 1

for i in range(start, len(output), 6):
    parts = output[i:(i+6)]
    if len(parts) < 6: break
    [name, _, _, modified, _, _] = parts
    name = name.split(b" ")[4]
    modified = modified.split(b" ")[1] == b"yes"
    if not modified:
        print("deleting {}".format(name))
        subprocess.run(["rm", "/home/brianpeiris/.tmp/{}".format(name.decode("utf-8"))])
