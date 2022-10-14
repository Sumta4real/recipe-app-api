"""
Simple Test
"""
from django.test import SimpleTestCase

from . import calc

class CalcTest(SimpleTestCase):
    """Test the calc module"""

    def test_add_numbers(self):
        """test adding numbers together"""
        res = calc.add(5,6)

        self.assertEqual(res,11)

    def test_subtract_numbers(self):
        """test subtracting numbers"""
        res = calc.subtract(5,15)

        self.assertEqual(res,10)