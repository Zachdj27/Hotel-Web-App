import { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import axios from "axios";
import './clientBooking.css';  
import MenuBar from "../components/MenuBar";
import "../components/menuBar.css";

export default function ClientUpdate() {
  const navigate = useNavigate();
  const [clientId, setClientId] = useState(null);
  const [loading, setLoading] = useState(true);
  const [success, setSuccess] = useState("");
  const [error, setError] = useState("");
  
  const [clientInfo, setClientInfo] = useState({
    nom_complet: "",
    adresse: "",
    password: "",
    NAS: ""
  });
  
  const [confirmPassword, setConfirmPassword] = useState("");

  useEffect(() => {
    const storedClientId = localStorage.getItem("client_id");
    console.log(storedClientId);
    if (!storedClientId) {
      navigate("/");
      return;
    }
    
    setClientId(storedClientId);
    
    const fetchClientData = async () => {
      try {
        const response = await axios.get(`http://127.0.0.1:8000/clients/get-client/${storedClientId}`);

        setClientInfo({
          nom_complet: response.data.nom_complet,
          adresse: response.data.adresse,
          password: "",
          NAS: response.data.NAS || ""
        });
        setLoading(false);
      } catch (error) {
        console.error("Error fetching client data", error);
        setError("Could not load your profile information. Please try again.");
        setLoading(false);
      }
    };

    fetchClientData();
  }, [navigate]);

  const handleChange = (e) => {
    setClientInfo({ ...clientInfo, [e.target.name]: e.target.value });
  };

  const handleConfirmPasswordChange = (e) => {
    setConfirmPassword(e.target.value);
  };

  const handleUpdate = async (e) => {
    e.preventDefault();
    setError("");
    setSuccess("");


    if (clientInfo.password) {
      if (clientInfo.password.length < 6) {
        setError("Password must be at least 6 characters long");
        return;
      }
      
      if (clientInfo.password !== confirmPassword) {
        setError("Passwords do not match");
        return;
      }
    }

    // Create payload with only the fields to update
    const updatePayload = {};
    if (clientInfo.nom_complet) updatePayload.nom_complet = clientInfo.nom_complet;
    if (clientInfo.adresse) updatePayload.adresse = clientInfo.adresse;
    if (clientInfo.password) updatePayload.password = clientInfo.password;

    // Don't proceed if nothing to update
    if (Object.keys(updatePayload).length === 0) {
      setError("No changes to update");
      return;
    }

    setLoading(true);
    try {
      const response = await axios.put(
        `http://127.0.0.1:8000/clients/update/${clientId}`,
        updatePayload
      );
      
      if (response.data.success) {
        setSuccess("Your profile has been updated successfully!");
        // Clear password fields after successful update
        setClientInfo({
          ...clientInfo,
          password: ""
        });
        setConfirmPassword("");
        alert("Information updated successfully.");
        navigate("/client/booking");
      } else {
        setError("Failed to update profile. Please try again.");
      }
    } catch (error) {
      console.error("Update failed", error);
      setError(error.response?.data?.detail || "Error updating profile. Please try again.");
    } finally {
      setLoading(false);
    }
  };
  
  const handleSignOut = () => {
    localStorage.removeItem("client_id");
    navigate("/");
  };
  
  const deleteAccount = async (clientId) => {
    try {
      const response = await axios.delete(`http://127.0.0.1:8000/clients/${clientId}`);
      
      if (response.data.success) {
        alert("Account deleted successfully");

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
      />
      
      <div className="container">
        <h2 className="title">Update Your Profile</h2>
        
        {loading && <p className="loading">Loading your profile information...</p>}
        
        {!loading && (
          <div className="profile-container">
            <form onSubmit={handleUpdate} className="form-container">
              <div className="form-group">
                <label htmlFor="nas">Social Security Number (NAS)</label>
                <input
                  type="text"
                  id="nas"
                  name="NAS"
                  value={clientInfo.NAS}
                  className="input-field"
                  disabled  // NAS should not be editable
                />
                <small>NAS cannot be changed</small>
              </div>
              
              <div className="form-group">
                <label htmlFor="nom_complet">Full Name</label>
                <input
                  type="text"
                  id="nom_complet"
                  name="nom_complet"
                  placeholder="Full Name"
                  value={clientInfo.nom_complet}
                  onChange={handleChange}
                  className="input-field"
                  required
                />
              </div>
              
              <div className="form-group">
                <label htmlFor="adresse">Address</label>
                <input
                  type="text"
                  id="adresse"
                  name="adresse"
                  placeholder="Address"
                  value={clientInfo.adresse}
                  onChange={handleChange}
                  className="input-field"
                  required
                />
              </div>
              
              <div className="form-group">
                <label htmlFor="password">New Password (leave blank to keep current)</label>
                <input
                  type="password"
                  id="password"
                  name="password"
                  placeholder="New Password"
                  value={clientInfo.password}
                  onChange={handleChange}
                  className="input-field"
                />
                <small>Password must be at least 6 characters</small>
              </div>
              
              <div className="form-group">
                <label htmlFor="confirm-password">Confirm New Password</label>
                <input
                  type="password"
                  id="confirm-password"
                  name="confirm-password"
                  placeholder="Confirm New Password"
                  value={confirmPassword}
                  onChange={handleConfirmPasswordChange}
                  className="input-field"
                  disabled={!clientInfo.password}
                />
              </div>
              
              <div className="button-container">
                <button 
                  type="submit" 
                  className="update-button"
                  disabled={loading}
                >
                  {loading ? "Updating..." : "Update Profile"}
                </button>
                
                <button 
                  type="button" 
                  className="cancel-button"
                  onClick={() => navigate("/client/booking")}
                >
                  Cancel
                </button>
              </div>
            </form>
            
            {error && <p className="error-message">{error}</p>}
            {success && <p className="success-message">{success}</p>}
          </div>
        )}
      </div>
    </div>
  );
}
