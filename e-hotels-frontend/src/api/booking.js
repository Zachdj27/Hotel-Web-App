import axios from "axios";

const API_URL = "http://127.0.0.1:8000"; 

export const fetchAvailableRooms = async (filters) => {
  const response = await axios.get(`${API_URL}/rooms/available/`, { params: filters });
  return response.data;
};

export const createBooking = async (bookingData) => {
  const response = await axios.post(`${API_URL}/bookings/`, bookingData);
  return response.data;
};
