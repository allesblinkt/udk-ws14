### DANGER! Blender prefers to load this from the file, 
### so make sure you save this to a file every time you make
### changes...

import bpy.path
import bpy

import math

import sys, imp, os

sys.path.append(os.path.join(bpy.path.abspath("//")))   ## current directory

import argparse
import random
import time
import math

import threading
from pythonosc import dispatcher
from pythonosc import osc_server
from pythonosc.osc_server import BlockingOSCUDPServer

import bge


# Use those global variables to store and access values sent from OSC clients
osc_value_brightness = 0.0
osc_value_mouse_x = 0.0
osc_value_mouse_y = 0.0


class OscServerPtr(object):
    """ Class to hold a reference to the Osc server. If this 
        gets garbage-collected, (i.e. closing the game engine) 
        we kill the server..."""
        
    def __init__(self, server):
        self.server = server
        
    def __del__(self):
        print("## Killing OSC Server")
        self.server.shutdown()
        
        
def osc_brightness_handler(unused_addr, *args):
    """ Handles osc brightness values (1 float) """
    
    global osc_value_brightness
    
    if len(args) == 1:
        osc_value_brightness = args[0]
        
        
def osc_mouse_handler(unused_addr, *args):
    """ Handles osc mouse values (2 floats) """
    
    global osc_value_mouse_x
    global osc_value_mouse_y
    
    if len(args) == 2:
        osc_value_mouse_x = args[0]
        osc_value_mouse_y = args[1]


def doStuff(controller):
    """ Will be called on every tick. Do all manipulations here. """

    own = controller.owner
    sens = controller.sensors['Always']

    gamescene = bge.logic.getCurrentScene();
    #print(osc_value_brightness)
    #print(osc_value_mouse_x)
    
    #print(bpy.data.objects["Cube"])

    twistCube = gamescene.objects["TwistCube"]
    # twistMod = twistCube.modifiers["SimpleDeform"]
    # twistMod.angle = osc_value_brightness * math.pi
    # gamescene.objects["TwistCube"].reinstancePhysicsMesh()
    twistCube.position.x = osc_value_mouse_x * 0.01;
    twistCube.position.y = osc_value_mouse_y * 0.01;
    #bge.logic.objects["TwistCube"]



def init():
    """ Will be called on the first frame (when starting the game engine) """
    
    print("## Initializing game module")

    server_ip = '127.0.0.1'
    server_port = 12013

    # Register messages and their handlers with the dispatcher
    disp = dispatcher.Dispatcher()
    disp.map("/brightness", osc_brightness_handler)
    disp.map("/mouse", osc_mouse_handler)

    # Make server
    server = BlockingOSCUDPServer((server_ip, server_port), disp)
    print("## Serving OSC on {}".format(server.server_address))
    
    # Run the server in its own thread, so it does not block
    server_thread = threading.Thread(target=server.serve_forever)
    bge.logic.osc_server = OscServerPtr(server)    # Store reference to kill :)
    server_thread.start()
    
   
print("## Hello") 
init()

