
import unittest
from unittest.mock import Mock, patch, call

import attr

from types import SimpleNamespace


class Test(unittest.TestCase):

    def test_first(self):
        self.assertEqual('foo'.upper(), 'FOO')
if __name__ == '__main__':
    unittest.main()
