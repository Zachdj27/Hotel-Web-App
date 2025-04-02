import axios from "axios";

const API_URL = "http://127.0.0.1:8000"; 

export const creatClient = async (clientData) => {
    const response = await fetch(`${API_URL}/clients/`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(clientData),
    });
    if (!response.ok) {
        throw new Error("Failed to create client");
    }
    return response.json();
};
