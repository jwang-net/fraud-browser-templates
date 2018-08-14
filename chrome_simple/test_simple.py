import unittest
from selenium import webdriver


class TestExample(unittest.TestCase):
    def setUp(self):
        chrome_options = webdriver.ChromeOptions()
        chrome_options.add_argument('--no-sandbox')
        chrome_options.add_argument('--headless')
        chrome_options.add_argument('--disable-gpu')
        self.driver = webdriver.Chrome(chrome_options=chrome_options)
        self.driver.implicitly_wait(10)

    def tearDown(self):
        self.driver.quit()

    def test_1(self):
        try:
            self.driver.get('http://github.com')
        except:
            self.fail()


if __name__ == '__main__':
    suite = unittest.TestLoader().loadTestsFromTestCase(TestExample)
    unittest.TextTestRunner(verbosity=2).run(suite)
