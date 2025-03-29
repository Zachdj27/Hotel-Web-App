import axios from "axios";

const API_URL = "http://127.0.0.1:8000"; 

export const getHotelCapacity = async () => {
    const response = await fetch(`${API_URL}/hotels/capacity/`, {
        method: "GET",
        headers: { "Content-Type": "application/json" },
    });
    if (!response.ok) {
        throw new Error("Failed to get hotel capacities");
    }
    return response.json();
};

export const getHotelCapacityByZone = async () => {
    const response = await fetch(`${API_URL}/zones/available-rooms/`, {
        method: "GET",
        headers: { "Content-Type": "application/json" },
    });
    if (!response.ok) {
        throw new Error("Failed to get open hotel rooms by zone");
    }
    return response.json();
};

