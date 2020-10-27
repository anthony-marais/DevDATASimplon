transaction1 = {
  'amount': '30',
  'sender': 'Alice',
  'receiver': 'Bob'}
transaction2 = { 
  'amount': '200',
  'sender': 'Bob',
  'receiver': 'Alice'}
transaction3 = { 
  'amount': '300',
  'sender': 'Alice',
  'receiver': 'Timothy' }
transaction4 = { 
  'amount': '300',
  'sender': 'Rodrigo',
  'receiver': 'Thomas' }
transaction5 = { 
  'amount': '200',
  'sender': 'Timothy',
  'receiver': 'Thomas' }
transaction6 = { 
  'amount': '400',
  'sender': 'Tiffany',
  'receiver': 'Xavier' }

my_transaction = {
  'amount':'10',
  'sender':'Anthony',
  'receiver':'Tiffany'}

mempool = [transaction1, transaction2, transaction3, transaction4, transaction5, transaction6, my_transaction]


block_transactions = [transaction1, transaction2, transaction3]





from hashlib import sha256

text = 'I am excited to learn about blockchain'

hash_result = sha256(text.encode())

print(hash_result.hexdigest())






