import { useState } from "react";
import "./auth.css";

export default function EmployeeLogin() {
  const [nas, setNas] = useState("");
  const [password, setPassword] = useState("");

  const handleLogin = (e) => {
    e.preventDefault();
    console.log("Logging in Employee:", { nas, password });
  };

  return (
    <div className="auth-container">
      <h2>Employee Login</h2>
      <form onSubmit={handleLogin}>
        <input 
          type="text" 
          placeholder="NAS (Social Security Number)" 
          value={nas} 
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
      <p className="test-accounts">Test Employee Account: NAS: 123456789, Pass: test123</p>
      <p>Don't have an account? <a href="#">Create one</a></p>
    </div>
  );
}
