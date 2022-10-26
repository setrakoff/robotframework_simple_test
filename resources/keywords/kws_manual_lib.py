# Keyword driven approach should be 'generic'. If you need to check some of the elements on the screen
# you do not need to know the type of them. you just need to know, 'locators'

# this implementation can be ofc done by any kind of code. Library can be class, or just plain functions.
# also, you can implement own classes  'input', 'select' etc... with their parameters, but for RF keyword
# you just want to expose 'generic' way how to do things
import json

import os
import zipfile
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
    selib.execute_javascript(
        drag_and_drop_js + "$('" + source + "').simulateDragDrop({ dropTarget: '" + target + "'});")


def drag_and_drop_by_js_only(source: str, target: str):
    builtin = BuiltIn()
    selib = builtin.get_library_instance("SeleniumLibrary")

    # load drag and drop helper
    file_path = os.path.join(os.path.dirname(__file__), '../scripts/drag_and_drop_helper.js')
    with open(file_path) as f:
        drag_and_drop_js = f.read()

    # perform drag&drop
    selib.execute_javascript(
        drag_and_drop_js + "$('" + source + "').simulateDragDrop({ dropTarget: '" + target + "'});")


def json_loads(json_str):
    """ Convert JSON to dict and return it
    Example:
    | ${dict} | JSON Loads | ${json}
    """
    dict_data = json.loads(json_str)
    print("(dict_data[0]):\n", dict_data[0])
    return dict_data[0]


def extract_files_from_zip(zip_file: str, target_dir: str):
    """ Unzip archive to pointed directory
    Example:
    | ${dict} | Extract Files From Zip | ${zip_file} | ${target_dir}
    """
    with zipfile.ZipFile(zip_file, 'r') as zip_ref:
        zip_ref.extractall(target_dir)
    print('Extract ZIP to directory \'', target_dir, '\' done.')


def archive_file_to_zip(path_to_zip: str, file_to_zip: str, zip_name: str):
    """ Zip to archive single file and paste result into pointed directory
    Example:
    | ${dict} | Archive File To Zip | ${path_to_zip} | ${file_to_zip} | ${zip_name}
    """
    with zipfile.ZipFile(zip_name, 'w', zipfile.ZIP_DEFLATED) as zipf:
        zipf.write(os.path.join(path_to_zip,file_to_zip), arcname=file_to_zip)
    print('Archiving file to ZIP \'', zip_name, '\' done.')


def archive_dir_to_zip(dir_to_zip: str, zip_name: str, target_dir: str):
    """ Zip to archive all files in directory and paste result into pointed directory
    Example:
    | ${dict} | Archive Files To Zip | ${zip_name} | ${dir_to_zip} | ${target_dir}
    """
    with zipfile.ZipFile(zip_name, 'w', zipfile.ZIP_DEFLATED) as zipf:
        zipdir(dir_to_zip, zipf, target_dir)
    print('Files archived to ZIP \'', zip_name, '\' and placed into directory \'', target_dir, '\'.')

def zipdir(path, ziph, target_dir):
    # ziph is zipfile handle
    for root, dirs, files in os.walk(path):
        for file in files:
            ziph.write(os.path.join(root, file),
                       os.path.relpath(os.path.join(root, file),
                                       os.path.join(path, '..')))