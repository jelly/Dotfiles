import zarafa
import MAPI
from MAPI.Util import *
from MAPI.Tags import *

server = zarafa.Server()
bob = server.user('bob')
alice = server.user('alice')
