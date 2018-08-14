import logging
import unittest
from selenium import webdriver


logging.getLogger().setLevel(logging.INFO)
URL = 'http://www.github.com/'


def chrome_example():
    chrome_options = webdriver.ChromeOptions()
    chrome_options.add_argument('--no-sandbox')
    chrome_options.add_argument('--headless')
    chrome_options.add_argument('--disable-gpu')
    browser = webdriver.Chrome(chrome_options=chrome_options)
    browser.implicitly_wait(10)

    logging.info('Prepared chrome browser..')

    browser.get(URL)
    logging.info('Accessed %s ..', URL)
    logging.info('Page title: %s', browser.title)

    browser.quit()


if __name__ == '__main__':
    chrome_example()
