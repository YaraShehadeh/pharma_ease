from pydantic import BaseModel, Field, validator

class Location(BaseModel):
    longitude: str
    latitude: str

    @validator('longitude')
    def validate_longitude(cls, value):
        value = float(value)
        if not (35 <= value <= 37):
            raise ValueError('The longitude must be between 35 and 37')
        return value

    @validator('latitude')
    def validate_latitude(cls, value):
        value = float(value)
        if not (29 <= value <= 33):
            raise ValueError('The latitude must be between 29 and 33')
        return value

