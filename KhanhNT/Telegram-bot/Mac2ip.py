from telegram import Update
from telegram.ext import Updater, CommandHandler, CallbackContext
import re


def start(update: Update, context: CallbackContext) -> None:
    update.message.reply_text('Nhap MAC theo cu phap: /mac2ip [MAC address]')
    update.message.reply_text('Nhap IP theo cu phap: /ip2mac [IP address]')


def mac2ip(update, context):
    MAC = str(context.args[0])
    IP = outputIP(MAC)
    if not IP:
        update.message.reply_text("Gia tri MAC khong thoa man")
    else:
        update.message.reply_text("IP cua MAC: " + str(IP) )
    # except (IndexError, ValueError):
    #   update.message.reply_text("There is not enough number")
        

def outputIP(MAC):
    with open("/var/dhcp.leases") as f:
        data = f.read()
        # data_json = json.loads(data)
        pattern = re.compile(r"lease ([0-9.]+) {.*?hardware ethernet ([:a-f0-9]+);.*?}", re.MULTILINE | re.DOTALL)
    s = {}
    with open("/var/dhcp.leases") as f:
        for match in pattern.finditer(f.read()):
            s.update({match.group(2): match.group(1)})
    if MAC in s:
        result = s[MAC]
    else: 
        result = None
    return result

def ip2mac(update, context):
    IP = str(context.args[0])
    MAC = outputMAC(IP)
    if not MAC:
        update.message.reply_text("Gia tri IP khong thoa man")
    else:
        update.message.reply_text("MAC cua IP: " + str(MAC) )


def outputMAC(IP):
    with open("/var/dhcp.leases") as f:
        data = f.read()
        # data_json = json.loads(data)
        pattern = re.compile(r"lease ([0-9.]+) {.*?hardware ethernet ([:a-f0-9]+);.*?}", re.MULTILINE | re.DOTALL)
    s = {}
    with open("/var/dhcp.leases") as f:
        for match in pattern.finditer(f.read()):
            s.update({match.group(1): match.group(2)})
    if IP in s:
        result = s[IP]
    else: 
        result = None
    return result


def main():
    updater = Updater('1785107806:AAHZsulRFwsb3q8XEJxcQIcXg57jSaKCt8I')
    dp = updater.dispatcher
    dp.add_handler(CommandHandler("start", start))
    dp.add_handler(CommandHandler("mac2ip", mac2ip))
    dp.add_handler(CommandHandler("ip2mac", ip2mac))
    updater.start_polling()
    updater.idle()

if __name__ == '__main__':
    main()