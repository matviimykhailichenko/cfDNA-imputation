from discord import SyncWebhook


def notify_bot(msg: str,
               url: str ='https://discord.com/api/webhooks/1416043723623759968/ahUfb8Ywnx9xodMAKw4Yhm4R0axEb9tGQu57aUA54gx9KKUArBLQs8JNbPOfA9CT-8rD'):
    if len(msg) > 2000:
        msg = f"{msg[:1993]} [...]"

    webhook = SyncWebhook.from_url(url)
    webhook.send(content=msg)