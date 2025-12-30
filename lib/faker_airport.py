from robot.api.deco import keyword, library
from faker import Faker
from faker_airtravel import AirTravelProvider


@library
class FakerAirport:
    """
    A library for generating fake airport data.
    Provides keywords to generate airport objects, names, IATA codes, ICAO codes,
    airlines, and flight details using the Faker library with the AirTravelProvider.
    """

    def __init__(self) -> None:
        """Initialize the Faker instance and add the AirTravelProvider."""
        self.fake = Faker()
        self.fake.add_provider(AirTravelProvider)

    @keyword("Airport")
    def get_airport_object(self):
        """Generate a fake airport object."""
        return self.fake.airport_object()

    @keyword("Airport Name")
    def get_airport_name(self):
        """Generate a fake airport name."""
        return self.fake.airport_name()

    @keyword("Airport IATA")
    def get_airport_iata(self):
        """Generate a fake airport IATA code."""
        return self.fake.airport_iata()

    @keyword("Airport ICAO")
    def get_airport_icao(self):
        """Generate a fake airport ICAO code."""
        return self.fake.airport_icao()

    @keyword("Airport Airline")
    def get_airport_airline(self):
        """Generate a fake airport airline."""
        return self.fake.airline()

    @keyword("Airport Flight")
    def get_airport_flight(self):
        """Generate a fake airport flight from one airline to another."""
        return self.fake.flight()


if __name__ == "__main__":
    fake = FakerAirport()
    print(fake.get_airport_object())
    print(fake.get_airport_name())
    print(fake.get_airport_iata())
    print(fake.get_airport_icao())
    print(fake.get_airport_airline())
    print(fake.get_airport_flight())
