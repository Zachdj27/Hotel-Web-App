import { useState, useEffect } from "react";
import axios from "axios";
import { useNavigate } from "react-router-dom";
import MenuBar from "../components/MenuBar";
import "../components/menuBar.css";
import "./clientBooking.css"; 

export default function EmployeeUpdate() {
  const navigate = useNavigate();
  const [employeeId, setEmployeeId] = useState("");
  const [employeeData, setEmployeeData] = useState({
    nas: "",
    nom_complet: "",
    adresse: "",
    poste: "",
    password: ""
  });

  useEffect(() => {
    const storedId = localStorage.getItem("employee_id");
    if (storedId) {
      setEmployeeId(storedId);
      fetchEmployeeData(storedId);
    }
  }, []);

  const fetchEmployeeData = async (id) => {
    try {
      const response = await axios.get(`http://127.0.0.1:8000/employees/get-employee/${id}`);
      if (response.data) {
        // Exclude hotel_id from the form state
        const { hotel_id, ...rest } = response.data;
        setEmployeeData(rest);
      }
    } catch (error) {
      console.error("Failed to fetch employee data", error);
    }
  };

  const handleChange = (e) => {
    setEmployeeData({
      ...employeeData,
      [e.target.name]: e.target.value
    });
  };

  const handleUpdate = async () => {
    try {
      const response = await axios.put(`http://127.0.0.1:8000/employees/update/${employeeId}`, employeeData);
      if (response.data.success) {
        alert("Information updated successfully.");
        navigate("/employee/booking");
      } else {
        alert("Failed to update.");
      }
    } catch (error) {
      console.error("Update failed", error);
      alert("An error occurred while updating.");
    }
  };

  const handleSignOut = () => {
    localStorage.removeItem("employee_id");
    navigate("/");
  };

  const deleteAccount = async (id) => {
    try {
      const response = await axios.delete(`http://127.0.0.1:8000/employees/${id}`);
      if (response.data.success) {
        alert("Account deleted.");
        handleSignOut();
      } else {
        alert("Deletion failed.");
      }
    } catch (error) {
      console.error("Delete failed", error);
    }
  };

  return (
    <div>
      <MenuBar clientId={employeeId} onDeleteAccount={deleteAccount} onSignOut={handleSignOut}/>
      <div className="container">
        <h2 className="title">Update Your Information</h2>
        <div className="form-container">
          <input
            type="text"
            name="nas"
            value={employeeData.nas}
            onChange={handleChange}
            placeholder="NAS"
            className="input-field"
          />
          <input
            type="text"
            name="nom_complet"
            value={employeeData.nom_complet}
            onChange={handleChange}
            placeholder="Full Name"
            className="input-field"
          />
          <input
            type="text"
            name="adresse"
            value={employeeData.adresse}
            onChange={handleChange}
            placeholder="Address"
            className="input-field"
          />
          <input
            type="text"
            name="poste"
            value={employeeData.poste}
            onChange={handleChange}
            placeholder="Position"
            className="input-field"
          />
          <input
            type="password"
            name="password"
            value={employeeData.password}
            onChange={handleChange}
            placeholder="Password"
            className="input-field"
          />
        </div>
        <button onClick={handleUpdate} className="search-button">
          Update Info
        </button>
      </div>
    </div>
  );
}
