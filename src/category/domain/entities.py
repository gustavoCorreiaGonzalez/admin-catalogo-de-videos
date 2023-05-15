from datetime import datetime
from dataclasses import dataclass, field
from typing import Optional


def current_date():
    return datetime.now()


@dataclass()
class Category:
    name: str
    description: Optional[str] = None
    is_active: Optional[bool] = field(default=True)
    created_at: Optional[datetime] = field(default_factory=current_date)
