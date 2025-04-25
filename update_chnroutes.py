import urllib.request

REMOTE_URL = "https://raw.githubusercontent.com/misakaio/chnroutes2/refs/heads/master/chnroutes.txt"

with urllib.request.urlopen(REMOTE_URL) as f:
    # Read all lines at once
    lines = [line.decode("utf-8").strip() for line in f.readlines()]

    # Remove empty lines and comments, and add a comma at the end
    lines = [l for l in lines if l and not l.startswith("#")]
    # lines = [l + "," for l in lines[:-1]] + [lines[-1]]

# wb for force linux newline \n
with open("chnroutes.nft", "wb") as f:
    f.write(b"add element inet myrouter CHNROUTES {\n")
    f.write(",\n".join(lines).encode())
    f.write(b"\n}\n")
