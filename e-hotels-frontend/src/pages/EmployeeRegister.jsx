import { useState } from "react";
import { useNavigate } from "react-router-dom";
import axios from "axios";
import "./auth.css";
import { hotelsData} from './constants';

export default function ClientRegister() {
  const [employeeInfo, setEmployeeInfo] = useState({
        hotel_id: "",
        nas: "",
        nom_complet: "",
        adresse: "" , 
        poste: "",
        password: ""
        });
  const [error, setError] = useState("");
  const navigate = useNavigate();

  const handleChange = (e) => {
    setEmployeeInfo({ ...employeeInfo, [e.target.name]: e.target.value });
  };

  const handleLogin = async (e) => {
    e.preventDefault();
    const formData = {
        ...employeeInfo,
        hotel_id: parseInt(employeeInfo.hotel_id)
      };
      console.log(formData);
    try {
      const response = await axios.post("http://127.0.0.1:8000/employees/login", {nas: employeeInfo.nas, password: employeeInfo.password});
      
      if (response.data.success) {
        navigate("/employee/booking"); 
      } else {
        try {
            const response = await axios.post("http://127.0.0.1:8000/employees/create-account", formData);
            if (response.data.successCreation) {
                navigate("/");
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
      <h2>Register Employee</h2>
      <form onSubmit={handleLogin}>
      <input 
        type="text" 
        name="nas"   
        placeholder="NAS (Social Security Number)" 
        value={employeeInfo.nas} 
        onChange={handleChange}
        required 
        />
        <input 
        type="text" 
        name="nom_complet"   
        placeholder="First and Last Name" 
        value={employeeInfo.nom_complet} 
        onChange={handleChange}
        required 
        />
        <input 
        type="text" 
        name="adresse"   
        placeholder="Adresse" 
        value={employeeInfo.adresse} 
        onChange={handleChange}
        required 
        />
        <input 
        type="text" 
        name="poste"   
        placeholder="Poste" 
        value={employeeInfo.poste} 
        onChange={handleChange}
        required 
        />
        <input 
        type="password" 
        name="password"   
        placeholder="Password" 
        value={employeeInfo.password} 
        onChange={handleChange}
        required 
        />
        <select 
            name="hotel_id" 
            value={employeeInfo.hotel_id} 
            onChange={handleChange} 
            className="input-field"
            required
          >
            <option value="">Select a Hotel</option>
            {hotelsData.map((hotel) => (
              <option key={hotel.hotel_id} value={hotel.hotel_id}>
                {hotel.name}
              </option>
            ))}
          </select>
        <button type="submit">Create Account</button>
      </form>
      {error && <p className="error">{error}</p>}
    </div>
  );
}
