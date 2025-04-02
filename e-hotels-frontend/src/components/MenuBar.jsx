import { useNavigate } from "react-router-dom";
export default function MenuBar() {
  const navigate = useNavigate();
  const handleLogout = () => {
    localStorage.removeItem("client_id");
    navigate("/");
  };
    return (
      <div className="menu-bar">
        <h1 className="menu-title">E-Hotels</h1>
        <div className="menu-buttons">
          <button className="menu-button">Update Acount</button>
          <button className="menu-button">Delete Acount</button>
          <button className="menu-button" onClick={handleLogout} >Sign Out</button>
        </div>
      </div>
    );
  }
  