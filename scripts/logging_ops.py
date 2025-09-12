import json, urllib.request

webhook = 'https://discord.com/api/webhooks/1416043723623759968/ahUfb8Ywnx9xodMAKw4Yhm4R0axEb9tGQu57aUA54gx9KKUArBLQs8JNbPOfA9CT-8rD'

def notify_bot(content=None, embeds=None):
    if not webhook:
        print("DISCORD_WEBHOOK_URL not set; skipping Discord notify.")
        return
    payload = {"content": content, "embeds": embeds or []}
    req = urllib.request.Request(
        webhook,
        data=json.dumps(payload).encode(),
        headers={"Content-Type": "application/json"},
        method="POST",
    )
    try:
        urllib.request.urlopen(req, timeout=10)
    except Exception as e:
        print(f"[warn] Discord notify failed: {e}")
