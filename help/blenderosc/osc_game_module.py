### DANGER! Blender prefers to load this from the file, 
### so make sure you save this to a file every time you make
### changes...


import bpy.path
import sys, imp, os

sys.path.append(os.path.join(bpy.path.abspath("//")))

import argparse
import random
import time
import math

import threading
from pythonosc import dispatcher
from pythonosc import osc_server
from pythonosc.osc_server import ForkingOSCUDPServer

import bge


class OscServerPtr(object):
    """ Class to hold a reference to the Osc server. If this 
        gets garbage-collected, (i.e. closing the game engine) 
        we kill the server..."""
    def __init__(self, server):
        self.server = server
        
    def __del__(self):
        print("Killing Osc Server")
        self.server.shutdown()

def main():
    
    # Not sure what do  here...

    cont = bge.logic.getCurrentController()
    own = cont.owner

    sens = cont.sensors['Always']
    actu = cont.actuators['Motion']

    if sens.positive:
        cont.activate(actu)
    else:
        cont.deactivate(actu)


def init():
    print("Module initialization")
    
    def print_test_handler(addr, args, testvalue):
        # TODO: write OSC value somewhere (variable)...
        print("[{0}] ~ {1}".format(args[0], testvalue))

    server_ip = '127.0.0.1'
    server_port = 12001

    disp = dispatcher.Dispatcher()
    disp.map("/debug", print)
    disp.map("/test", print_test_handler, "Test")

    server = ForkingOSCUDPServer((server_ip, server_port), disp)
    print("Serving on {}".format(server.server_address))
    
    server_thread = threading.Thread(target=server.serve_forever)
    bge.logic.osc_server = OscServerPtr(server)
    server_thread.start()
    
    
init()    
main()

print("Started module")