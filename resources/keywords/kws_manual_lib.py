# Keyword driven approach should be 'generic'. If you need to check some of the elements on the screen
# you do not need to know the type of them. you just need to know, 'locators'

# this implementation can be ofc done by any kind of code. Library can be class, or just plain functions.
# also, you can implement own classes  'input', 'select' etc... with their parameters, but for RF keyword
# you just want to expose 'generic' way how to do things
import json

import os
from robot.libraries.BuiltIn import BuiltIn
from pathlib import Path


def drag_and_drop_by_js(source: str, target: str):
    builtin = BuiltIn()
    selib = builtin.get_library_instance("SeleniumLibrary")
    file_path = os.path.join(os.getcwd(), './resources/scripts/jquery_load_helper.js')
    # load jQuery helper
    with open(file_path) as f:
        load_jquery_js = f.read()

    # load drag and drop helper
    file_path = os.path.join(os.getcwd(), './resources/scripts/drag_and_drop_helper.js')
    with open(file_path) as f:
        drag_and_drop_js = f.read()

    # load jQuery
    selib.execute_async_javascript(load_jquery_js)
    print('load jQuery done')

    # perform drag&drop
    selib.execute_javascript(drag_and_drop_js + "$('" + source + "').simulateDragDrop({ dropTarget: '" + target + "'});")

def drag_and_drop_by_js_only(source: str, target: str):
    builtin = BuiltIn()
    selib = builtin.get_library_instance("SeleniumLibrary")

    # load drag and drop helper
    file_path = os.path.join(os.path.dirname(__file__), '../scripts/drag_and_drop_helper.js')
    with open(file_path) as f:
        drag_and_drop_js = f.read()

    # perform drag&drop
    selib.execute_javascript(drag_and_drop_js + "$('" + source + "').simulateDragDrop({ dropTarget: '" + target + "'});")




