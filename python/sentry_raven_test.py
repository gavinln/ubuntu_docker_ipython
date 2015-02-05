


from raven import Client

client = Client('http://33667a3c1ef74c1bb554d05a51a5058b:08b0037d9f144834a294526dbf25d792@sentry.vagrant.com:8080/2')

# record a simple message
client.captureMessage('hello world!')

# capture an exception
try:
    1 / 0
except ZeroDivisionError:
    client.captureException()
