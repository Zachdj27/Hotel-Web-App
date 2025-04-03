import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import './App.css'
import SelectRole from "./pages/SelectRole";
import EmployeeLogin from "./pages/EmployeeLogin";
import ClientLogin from "./pages/ClientLogin";
import ClientBooking from "./pages/ClientBooking";
import ClientRegister from "./pages/ClientRegister";
import EmployeeBooking from "./pages/EmployeeBooking";

function App() {
  return(
    <Router>
      <Routes>
        <Route path="/" element={<SelectRole />} />
        <Route path="/employee-login" element={<EmployeeLogin />} />
        <Route path="/client-login" element={<ClientLogin />} />
        <Route path="/client/booking" element={<ClientBooking />} />
        <Route path="/client-register" element={<ClientRegister />} />
        <Route path="/employee/booking" element={<EmployeeBooking />} />
      </Routes>
    </Router>
  )
}

export default App;
