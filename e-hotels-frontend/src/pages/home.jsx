import { useState } from "react";
import axios from "axios";

export default function Home() {
  const [searchParams, setSearchParams] = useState({
    start_date: "",
    end_date: "",
    capacity: "",
    superficie: "",
    price: "",
    hotel_id: ""
  });
  
  const [rooms, setRooms] = useState([]);
  
  const handleChange = (e) => {
    setSearchParams({ ...searchParams, [e.target.name]: e.target.value });
  };

  const searchRooms = async () => {
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
    <div className="p-4">
      <h2 className="text-xl font-bold mb-4">Search for Available Rooms</h2>
      <div className="grid grid-cols-2 gap-4 mb-4">
        <input type="date" name="start_date" value={searchParams.start_date} onChange={handleChange} className="border p-2" />
        <input type="date" name="end_date" value={searchParams.end_date} onChange={handleChange} className="border p-2" />
        <input type="number" name="capacity" placeholder="Capacity" value={searchParams.capacity} onChange={handleChange} className="border p-2" />
        <input type="number" name="superficie" placeholder="Superficie" value={searchParams.superficie} onChange={handleChange} className="border p-2" />
        <input type="number" name="price" placeholder="Max Price" value={searchParams.price} onChange={handleChange} className="border p-2" />
        <input type="number" name="hotel_id" placeholder="Hotel ID (optional)" value={searchParams.hotel_id} onChange={handleChange} className="border p-2" />
      </div>
      <button onClick={searchRooms} className="bg-blue-500 text-white p-2 rounded">Search</button>
      
      <div className="mt-4">
        <h3 className="text-lg font-semibold">Available Rooms:</h3>
        <ul>
          {rooms.map((room) => (
            <li key={room.room_id} className="border p-2 mb-2">
              Room ID: {room.room_id} | Capacity: {room.superficie} | Price: ${room.prix}
            </li>
          ))}
        </ul>
      </div>
    </div>
  );
}
