import { useState } from "react";
import { useNavigate } from "react-router-dom";
import axios from "axios";
import "./auth.css";

export default function ClientLogin() {
  const [NAS, setNas] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");
  const navigate = useNavigate();

  const handleLogin = async (e) => {
    e.preventDefault();
    
    try {
      const response = await axios.post("http://127.0.0.1:8000/clients/login", { NAS: NAS, password: password });
      
      if (response.data.success) {
        navigate("/client/booking"); 
      } else {
        setError("Invalid account information. Please try again.");
      }
    } catch (error) {
      console.error("Login failed", error);
      setError("Error logging in. Check NAS.");
    }
  };

  return (
    <div className="auth-container">
      <h2>Client Login</h2>
      <form onSubmit={handleLogin}>
        <input 
          type="number" 
          placeholder="NAS (Social Security Number)" 
          value={NAS} 
          onChange={(e) => setNas(e.target.value)}
          required 
        />
        <input 
          type="password" 
          placeholder="Password" 
          value={password} 
          onChange={(e) => setPassword(e.target.value)}
          required 
        />
        <button type="submit">Login</button>
      </form>
      {error && <p className="error">{error}</p>}
      <p className="test-accounts">Test Client Account: NAS: 300355345, Mot de Passe: Password</p>
      <p>Don't have an account? <a href="/client-register">Create one</a></p>
    </div>
  );
}
