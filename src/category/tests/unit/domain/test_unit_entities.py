import unittest
from dataclasses import FrozenInstanceError, is_dataclass
from datetime import datetime

from category.domain.entities import Category


class TestCategory(unittest.TestCase):
    def test_if_is_a_dataclass(self):
        self.assertTrue(is_dataclass(Category))

    def test_if_created_at_is_generated_in_constructor(self):
        category_first = Category(name="Movie")
        category_second = Category(name="Movie")

        self.assertNotEqual(
            category_first.created_at,
            category_second.created_at,
        )

    def test_default_field_construtor(self):
        category = Category(name="Movie")

        self.assertEqual(category.description, None)
        self.assertEqual(category.is_active, True)

    def test_complete_construtor(self):
        # Triple AAA
        # Arrange
        data = {
            "name": "Movie",
            "description": "some description",
            "is_active": True,
            "created_at": datetime.now(),
        }
        # Act
        category = Category(**data)
        # Assert
        self.assertEqual(category.name, "Movie")
        self.assertEqual(category.description, "some description")
        self.assertEqual(category.is_active, True)
        self.assertIsInstance(category.created_at, datetime)

    def test_is_immutable(self):
        with self.assertRaises(FrozenInstanceError):
            value_object = Category(name="Teste")
            value_object.name = "Fake Name"
