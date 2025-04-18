import { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import axios from "axios";
import './clientBooking.css';  
import MenuBar from "../components/MenuBar";
import "../components/menuBar.css"
import { chains, zones, pays, classements } from './constants';

export default function ClientBooking() {
  const navigate = useNavigate();
  const [clientId, setClientId] = useState(null);
  const bookingStatus = "Réservé";
  const [searchParams, setSearchParams] = useState({
    start_date: "",
    end_date: "",
    capacity: "",
    superficie: "",
    price: "",
    chain_id: "", 
    pays: "",
    zone: "", 
    classement: ""
  });

  const [rooms, setRooms] = useState([]);
  
  const [showHotelCapacities, setShowHotelCapacities] = useState(false);

  const [hotelCapacities, setHotelCapacities] = useState([]);

  const [roomsByZone, setRoomsByZone] = useState([]);

  useEffect(() => {
    const storedClientId = localStorage.getItem("client_id");
    if (storedClientId) {
      setClientId(storedClientId);
    }

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
      if (!params.chain_id) {
        delete params.chain_id;
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
      if (!params.classement) {
        delete params.classement;
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

  const bookRoom = async (roomId) => {
    if (!clientId) {
      alert("You must be logged in to book a room.");
      return;
    }

    try {
      const response = await axios.post("http://127.0.0.1:8000/bookings", {
        client_id: clientId,
        room_id: roomId,
        entry_date: new Date(searchParams.start_date).toISOString().split('T')[0],
        leaving_date: new Date(searchParams.end_date).toISOString().split('T')[0],
        status: bookingStatus
      });

      if (response.data.successBooking) {
        alert("Room booked successfully!");

        
        setRooms(rooms.filter(room => room.id !== roomId));
      } else {
        alert("Booking failed.");
      }
    } catch (error) {
      console.error("Error booking room", error);
    }
  };
  
  const handleSignOut = () => {
    localStorage.removeItem("client_id");
    navigate("/");
  };

  const handleUpdate = () => {
    navigate("/client-update");
  };
  
  const deleteAccount = async (clientId) => {
    try {
      const response = await axios.delete(`http://127.0.0.1:8000/clients/${clientId}`);
      
      if (response.data.success) {
        alert("Account deleted successfully");
        // Use the same sign out function
        handleSignOut();
      } else {
        alert("Failed to delete account");
      }
    } catch (error) {
      console.error("Error deleting account", error);
      alert("Error deleting account");
    }
  };

  return (
    <div>
      <MenuBar
        clientId={clientId} 
        onDeleteAccount={deleteAccount} 
        onSignOut={handleSignOut}
        handleUpdate={handleUpdate}/>
      <div className="container">
        <h2 className="title">Search for Available Rooms</h2>
{/* Show/Hide Sections Button */}
<div className="toggle-section">
          <button onClick={() => setShowHotelCapacities(!showHotelCapacities)} className="toggle-button">
            {showHotelCapacities ? "Hide Hotel Capacities" : "Show Hotel Capacities"}
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
            name="chain_id" 
            value={searchParams.chain_id} 
            onChange={handleChange} 
            className="input-field"
          >
            <option value="">Select a Hotel Chain</option>
            {chains.map((chain) => (
              <option key={chain.id} value={chain.id}>
                {chain.name}
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

          <select 
            name="classement" 
            value={searchParams.classement}
            onChange={handleChange} 
            className="input-field"
          >
            <option value="">Select a Hotel Rating</option>
            {classements.map((classement) => (
              <option>
                {classement}
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
                  <h2>Hotel: {room.hotel_name}</h2>
                  <h3>Hotel Chain: {chains.find(chain => chain.id === room.chain_id)?.name || 'Unknown'}</h3>
                  <h4>Room ID: {room.room_id}</h4>
                  <p>Capacity: {room.capacite} people</p>
                  <p>Size: {room.superficie} m²</p>
                  <p>Price: ${room.prix}</p>
                  <p>Rating: {room.classement}</p>
                  <p>Pays: {room.pays}</p>
                  <p>Zone: {room.zone}</p>
                  <button className="bg-green-500 text-white p-2 rounded mt-2" onClick={() => bookRoom(room.room_id)}>
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
