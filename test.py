import requests

response = requests.get("https://cd8eb82a-fbe7-467f-8f06-13e6c10bba04.mock.pstmn.io")
raw_data = response.json()
print(raw_data)