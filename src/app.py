from typing import Dict


class WonderBook:
    charm: Dict[str, str] = {"patronus_charm": "Expecto Patronum"}

    @classmethod
    def patronus_charm(cls, spell: str) -> bool:
        return spell == cls.charm["patronus_charm"]
