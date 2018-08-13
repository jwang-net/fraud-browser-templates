import unittest
from selenium import webdriver


class TestTemplate(unittest.TestCase):
    """Include test cases on a given url"""

    def setUp(self):
        """Start web driver"""
        chrome_options = webdriver.ChromeOptions()
        chrome_options.add_argument('--no-sandbox')
        chrome_options.add_argument('--headless')
        chrome_options.add_argument('--disable-gpu')
        self.driver = webdriver.Chrome(chrome_options=chrome_options)
        self.driver.implicitly_wait(10)

    def tearDown(self):
        """Stop web driver"""
        self.driver.quit()

    def test_case_1(self):
        """Find and click top-right button"""
        try:
            self.driver.get('http://github.com')
        except:
            self.fail()


if __name__ == '__main__':
    suite = unittest.TestLoader().loadTestsFromTestCase(TestTemplate)
    unittest.TextTestRunner(verbosity=2).run(suite)
