import { useState, useEffect } from "react";
import axios from "axios";
import './home.css';  
import MenuBar from "../components/MenuBar";
import "../components/menuBar.css"

export default function Home() {
  const [searchParams, setSearchParams] = useState({
    start_date: "",
    end_date: "",
    capacity: "",
    superficie: "",
    price: "",
    hotel_id: "", 
    pays: "",
    zone: "", 
  });

  const [rooms, setRooms] = useState([]);

  const hotels = [
    { id: 1, name: 'Elite Suites' },
    { id: 2, name: 'Budget Stay' },
    { id: 3, name: 'Green Getaways' },
    { id: 4, name: 'Royal Resorts' },
    { id: 5, name: 'Coastal Escapes' }
  ];

  const zones =[
    "London",
    "Coronado",
    "New York",
    "Mississauga",
    "Tampa",
    "Toronto",
    "Carlsbad",
    "Syracuse",
    "Playa del Carmen",
    "Ottawa",
    "Orlando",
    "Tulum",
    "Oceanside",
    "Albany",
    "Cozumel",
    "Jacksonville",
    "San Diego",
    "Cancun",
    "Miami",
    "Rochester"
  ];

  const pays= [
    "Mexico",
    "Canada",
    "USA"
  ];
  
  const [showHotelCapacities, setShowHotelCapacities] = useState(false);

  const [hotelCapacities, setHotelCapacities] = useState([]);

  const [roomsByZone, setRoomsByZone] = useState([]);

  useEffect(() => {
    async function fetchData() {
      try {
        const hotelCapacityData = await axios.get("http://127.0.0.1:8000/hotels/capacity/");
        setHotelCapacities(hotelCapacityData.data);
        
        const roomsByZoneData = await axios.get("http://127.0.0.1:8000/zones/available-rooms/");
        setRoomsByZone(roomsByZoneData.data);
      } catch (error) {
        console.error("Error fetching additional data", error);
      }
    }
    fetchData();
  }, []);


  const handleChange = (e) => {
    setSearchParams({ ...searchParams, [e.target.name]: e.target.value });
  };

  const searchRooms = async () => {
    //check if both start and end dates are selected
    if (!searchParams.start_date || !searchParams.end_date) {
      alert("Please select both start and end dates to search for rooms.");
      return;
    }
  
    setRooms([]);
    try {
      const params = { ...searchParams };
  
      //remove empty fields
      if (!params.hotel_id) {
        delete params.hotel_id;
      }
      if (!params.superficie) {
        delete params.superficie;
      }
      if (!params.capacity) {
        delete params.capacity;
      }
      if (!params.pays) {
        delete params.pays;
      }
      if (!params.zone) {
        delete params.zone;
      }
      if (!params.price) {
        delete params.price;
      }
  
      const response = await axios.get("http://127.0.0.1:8000/rooms/available/", {
        params,
      });
  
      setRooms(response.data.available_rooms);
      console.log("API Response:", response.data);
    } catch (error) {
      console.error("Error fetching rooms", error);
    }
  };
  
  return (
    <div>
      <MenuBar/>
      <div className="container">
        <h2 className="title">Search for Available Rooms</h2>
{/* Show/Hide Sections Button */}
<div className="toggle-section">
          <button onClick={() => setShowHotelCapacities(!showHotelCapacities)} className="toggle-button">
            {showHotelCapacities ? "Hide Additional Information" : "Show Additional Information"}
          </button>
        </div>

        {showHotelCapacities && (
          <>
            {/* Hotel Capacities */}
            <div className="info-box">
              <h3>Today's Hotel Capacities</h3>
              <ul>
                {hotelCapacities.map((hotel, index) => (
                  <li key={index}>
                    {hotel.name}: {hotel.capacite_total_disponible} rooms
                  </li>
                ))}
              </ul>
            </div>

            {/* Rooms Available by Zone */}
            <div className="info-box">
              <h3>Today's Rooms Available by Zone</h3>
              <ul>
                {roomsByZone.map((zone, index) => (
                  <li key={index}>
                    {zone.zone}: {zone.nombre_chambres_disponibles} available
                  </li>
                ))}
              </ul>
            </div>
          </>
        )}
        {/* Search Form */}
        <div className="form-container">
          <input 
            type="date" 
            name="start_date" 
            value={searchParams.start_date} 
            onChange={handleChange} 
            className="input-field"
          />
          <input 
            type="date" 
            name="end_date" 
            value={searchParams.end_date} 
            onChange={handleChange} 
            className="input-field"
          />
          <input 
            type="number" 
            name="capacity" 
            placeholder="Capacity" 
            value={searchParams.capacity} 
            onChange={handleChange} 
            className="input-field"
          />
          <input 
            type="number" 
            name="superficie" 
            placeholder="Superficie (m²)" 
            value={searchParams.superficie} 
            onChange={handleChange} 
            className="input-field"
          />
          <input 
            type="number" 
            name="price" 
            placeholder="Max Price ($)" 
            value={searchParams.price} 
            onChange={handleChange} 
            className="input-field"
          />

          {/* Hotel Dropdown */}
          <select 
            name="hotel_id" 
            value={searchParams.hotel_id} 
            onChange={handleChange} 
            className="input-field"
          >
            <option value="">Select a Hotel</option>
            {hotels.map((hotel) => (
              <option key={hotel.id} value={hotel.id}>
                {hotel.name}
              </option>
            ))}
          </select>

          <select 
            name="pays" 
            value={searchParams.pays} 
            onChange={handleChange} 
            className="input-field"
          >
            <option value="">Select a country</option>
            {pays.map((pays) => (
              <option>
                {pays}
              </option>
            ))}
          </select>

          <select 
            name="zone" 
            value={searchParams.zone} 
            onChange={handleChange} 
            className="input-field"
          >
            <option value="">Select a zone</option>
            {zones.map((zone) => (
              <option>
                {zone}
              </option>
            ))}
          </select>
        </div>

        <button 
          onClick={searchRooms} 
          className="search-button"
        >
          Search
        </button>
        
        <div className="available-rooms">
          <h3 className="text-lg font-semibold text-gray-800 mb-4">Available Rooms:</h3>
          {rooms.length === 0 ? (
            <p className="no-rooms">No available rooms found.</p>
          ) : (
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              {rooms.map((room) => (
                <div key={room.room_id} className="room-card">
                  <h4>Room ID: {room.room_id}</h4>
                  <p>Capacity: {room.capacite} people</p>
                  <p>Size: {room.superficie} m²</p>
                  <p>Price: ${room.prix}</p>
                  <button className="bg-green-500 text-white p-2 rounded mt-2">
                    Book
                  </button>
                </div>
              ))}
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
