
from hashlib import sha256

text = 'I am excited to learn about blockchain'

hash_result = sha256(text.encode())

print(hash_result.hexdigest())






