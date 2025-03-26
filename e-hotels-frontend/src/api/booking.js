import axios from "axios";

const API_URL = "http://127.0.0.1:8000"; 

//fetch available rooms based on filters
export const getAvailableRooms = async (filters) => {
    const query = new URLSearchParams(filters).toString();
    const response = await fetch(`${API_URL}/rooms/available/?${query}`);
    if (!response.ok) {
        throw new Error("Failed to fetch available rooms");
    }
    return response.json();
};


export const createBooking = async (bookingData) => {
    const response = await fetch(`${API_URL}/bookings/`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(bookingData),
    });
    if (!response.ok) {
        throw new Error("Failed to create booking");
    }
    return response.json();
};

export const updateBookingStatus = async (bookingId, status) => {
    const response = await fetch(`${API_URL}/bookings/${bookingId}/status`, {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ status }),
    });
    if (!response.ok) {
        throw new Error("Failed to update booking status");
    }
    return response.json();
};
