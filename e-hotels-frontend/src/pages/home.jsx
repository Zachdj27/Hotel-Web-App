import { useState } from "react";
import axios from "axios";
import './home.css';  

export default function Home() {
  const [searchParams, setSearchParams] = useState({
    start_date: "",
    end_date: "",
    capacity: "",
    superficie: "",
    price: "",
    hotel_name: ""  
  });

  const [rooms, setRooms] = useState([]);

  const hotels = [
    { id: 1, name: 'Elite Suites' },
    { id: 2, name: 'Budget Stay' },
    { id: 3, name: 'Green Getaways' },
    { id: 4, name: 'Royal Resorts' },
    { id: 5, name: 'Coastal Escapes' }
  ];

  const handleChange = (e) => {
    setSearchParams({ ...searchParams, [e.target.name]: e.target.value });
  };

  const searchRooms = async () => {
    setRooms([]);
    try {
      const response = await axios.get("http://127.0.0.1:8000/rooms/available/", {
        params: searchParams
      });
      setRooms(response.data.available_rooms);
      console.log("API Response:", response.data);
    } catch (error) {
      console.error("Error fetching rooms", error);
    }
  };

  return (
    <div className="container">
      <h2 className="title">Search for Available Rooms</h2>

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
          name="hotel_name" 
          value={searchParams.hotel_name} 
          onChange={handleChange} 
          className="input-field"
        >
          <option value="">Select a Hotel</option>
          {hotels.map((hotel) => (
            <option key={hotel.id} value={hotel.name}>
              {hotel.name}
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
  );
}
