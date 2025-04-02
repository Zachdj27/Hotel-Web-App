import { useState } from "react";
import { useNavigate } from "react-router-dom";
import axios from "axios";
import "./auth.css";

export default function ClientRegister() {
  const [clientInfo, setclientInfo] = useState({
        NAS: "",
        nom_complet: "",
        adresse: "",
        password: "",   
        });
  const [error, setError] = useState("");
  const navigate = useNavigate();

  const handleChange = (e) => {
    setclientInfo({ ...clientInfo, [e.target.name]: e.target.value });
  };

  const handleLogin = async (e) => {
    e.preventDefault();
    
    try {
      const response = await axios.post("http://127.0.0.1:8000/clients/login", {NAS: clientInfo.NAS, password: clientInfo.password});
      
      if (response.data.success) {
        navigate("/client/booking"); 
      } else {
        try {
            const response = await axios.post("http://127.0.0.1:8000/clients/create-account", clientInfo);
            if (response.data.successCreation) {
                navigate("/client/booking");
            } else {
                setError("Invalid account information. Please try again.");
            }
        } catch{
            console.error("Account Creation Failed", error);
        }
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
        type="text" 
        name="NAS"   
        placeholder="NAS (Social Security Number)" 
        value={clientInfo.NAS} 
        onChange={handleChange}
        required 
        />
        <input 
        type="text" 
        name="nom_complet"   
        placeholder="First and Last Name" 
        value={clientInfo.nom_complet} 
        onChange={handleChange}
        required 
        />
        <input 
        type="text" 
        name="adresse"   
        placeholder="Adresse" 
        value={clientInfo.adresse} 
        onChange={handleChange}
        required 
        />
        <input 
        type="password" 
        name="password"   
        placeholder="Password" 
        value={clientInfo.password} 
        onChange={handleChange}
        required 
        />
        <button type="submit">Create Account</button>
      </form>
      {error && <p className="error">{error}</p>}
    </div>
  );
}
