import pytest
from project.app import WonderBook


class TestWonderBook:
    @pytest.mark.parametrize("spell, effect", [("Expecto Patronum", True), ("Reducto", False)])
    def test_patronus_charm(self, spell, effect):
        spells = WonderBook()
        assert spells.patronus_charm(spell) == effect
