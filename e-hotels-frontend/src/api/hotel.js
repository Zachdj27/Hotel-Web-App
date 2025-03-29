import axios from "axios";

const API_URL = "http://127.0.0.1:8000"; 

export const getHotelCapacity = async () => {
    const response = await fetch(`${API_URL}/hotels/capacity/`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(bookingData),
    });
    if (!response.ok) {
        throw new Error("Failed to create booking");
    }
    return response.json();
};

