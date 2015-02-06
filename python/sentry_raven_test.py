


from raven import Client

client = Client('http://b5f1269c9bf9467cbb862e39dc0431a1:8ac493396936480694e4c25b8c3fdc91@sentry.ipython.com/2')

# record a simple message
client.captureMessage('hello world!')

# capture an exception
try:
    1 / 0
except ZeroDivisionError:
    client.captureException()
