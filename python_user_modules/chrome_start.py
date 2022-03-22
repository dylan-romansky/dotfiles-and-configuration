#!/usr/bin/env python3

from selenium import webdriver
from selenium.webdriver.chrome.options import Options

chromedriver = '/home/dromansk/builds/chromedriver/pkg/chromedriver/usr/bin/chromedriver'

def chrome_start():
	options = Options()
	options.add_experimental_option("excludeSwitches", ['enable-automation'])
	options.add_experimental_option("useAutomationExtension", [False])
	options.add_argument('--user-data-dir=/home/dromansk/.config/google-chrome/')
	return webdriver.Chrome(chromedriver, options=options)
