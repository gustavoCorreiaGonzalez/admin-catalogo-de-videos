import unittest
from datetime import datetime

from category.domain.entities import Category


class TestCategory(unittest.TestCase):
    def test_construtor(self):
        category = Category("Movie", "some description", True, datetime.now())
        self.assertEqual(category.name, "Movie")
        self.assertEqual(category.description, "some description")
        self.assertEqual(category.is_active, True)
        self.assertIsInstance(category.created_at, datetime)
