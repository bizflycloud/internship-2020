import telebot

bot = telebot.TeleBot("1828936471:AAH-5fzHIKSsgVxyKMrv26gEyAa3CmUr89s")

# handle commands, /start
@bot.message_handler(commands=['start'])
def handle_command(message):
    bot.reply_to(message, "Hello, welcome to Telegram Bot!")
    
# handle all messages, echo response back to users
@bot.message_handler(func=lambda message: True)
def handle_all_message(message):
	bot.reply_to(message, message.text)

bot.polling()
