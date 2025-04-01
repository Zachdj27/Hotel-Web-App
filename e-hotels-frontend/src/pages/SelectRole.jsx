import { useNavigate } from "react-router-dom";
import "./auth.css";

export default function SelectRole() {
  const navigate = useNavigate();

  return (
    <div className="auth-container">
      <h2>Select Your Role</h2>
      <button onClick={() => navigate("/client-login")}>Client</button>
      <button onClick={() => navigate("/employee-login")}>Employee</button>
    </div>
  );
}
