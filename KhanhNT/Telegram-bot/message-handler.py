from telegram import Update
from telegram.ext import Updater, CommandHandler, CallbackContext

def sum(update, context):
    try:
        number1 = int(context.args[0])
        print(context)
        number2 = int(context.args[1])
        result = number1 + number2
        update.message.reply_text("The sum is: " + str(result))
    except (IndexError, ValueError):
        update.message.reply_text("There is not enough number")

def main():
    updater = Updater('1828936471:AAH-5fzHIKSsgVxyKMrv26gEyAa3CmUr89s')
    dp = updater.dispatcher
    dp.add_handler(CommandHandler("sum", sum))
    updater.start_polling()
    updater.idle()

if __name__ == '__main__':
    main()