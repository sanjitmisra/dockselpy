import logging
import datetime
import time
import os

from pyvirtualdisplay import Display
from selenium import webdriver

logging.basicConfig(filename='execution.log')
logging.getLogger().setLevel(logging.INFO)

BASE_URL = 'https://www.amazon.in'


def chrome_test():
    # display = Display(visible=0, size=(800, 600))
    # display.start()
    raw_timestamp_start = time.time()
    formatted_timestamp = datetime.datetime.fromtimestamp(raw_timestamp_start).strftime('%Y-%m-%d %H:%M:%S')
    logging.info('Test started at: %s', formatted_timestamp)
    chrome_options = webdriver.ChromeOptions()
    chrome_options.add_argument('--headless')

    chrome_options.add_experimental_option('prefs', {
        'download.default_directory': os.getcwd(),
        'download.prompt_for_download': False,
    })

    browser = webdriver.Chrome(chrome_options=chrome_options)
    logging.info('Initialized chrome browser..')

    browser.get('https://www.amazon.in/')
    logging.info('Accessed %s ..', BASE_URL)

    logging.info('Page Title: %s', browser.title)

    browser.quit()
    raw_timestamp_end = time.time()
    formatted_timestamp = datetime.datetime.fromtimestamp(raw_timestamp_end).strftime('%Y-%m-%d %H:%M:%S')
    logging.info('Test completed at: %s', formatted_timestamp)
    # display.stop()


if __name__ == '__main__':
    chrome_test()
