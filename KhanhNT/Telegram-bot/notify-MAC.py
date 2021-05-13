#!/usr/bin/python3

import os
import re

def outputMAC(MAC):
    # print("Nhap MAC voi dinh dang 'xx:xx:xx:xx:xx':  ")
    # MAC = input()
    with open("/var/dhcp.leases") as f:
        data = f.read()
        # data_json = json.loads(data)
        pattern = re.compile(r"lease ([0-9.]+) {.*?hardware ethernet ([:a-f0-9]+);.*?}", re.MULTILINE | re.DOTALL)
    s = {}
    with open("/var/dhcp.leases") as f:
        for match in pattern.finditer(f.read()):
            s.update({match.group(2): match.group(1)})
    if MAC in s:
        print (s[MAC])
    else:
        print("Gia tri MAC khong thoa man")
            

def main():
    print("Nhap MAC voi dinh dang 'xx:xx:xx:xx:xx':  ")
    MAC = input()
    outputMAC(MAC)

if __name__== "__main__":
    main()