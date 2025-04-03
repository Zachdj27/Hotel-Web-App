import React, { useState } from 'react';

const BookingsDropdown = ({ bookings }) => {
  const [showBookings, setShowBookings] = useState(false);
  
  const toggleBookings = () => {
    setShowBookings(!showBookings);
  };
  
  //format dates 
  const formatDate = (dateString) => {
    const date = new Date(dateString);
    return date.toLocaleDateString();
  };
  
  return (
    <div className="bookings-container">
      <button 
        onClick={toggleBookings} 
        className="dropdown-button"
      >
        {showBookings ? 'Hide Bookings' : 'Show Bookings'}
      </button>
      
      {showBookings && (
        <div className="info-box">
          <h3>Current Bookings</h3>
          <ul>
            {bookings.map((booking) => (
              <li key={booking.booking_id}>
                Booking #{booking.booking_id}: Room {booking.room_id} - 
                From {formatDate(booking.entry_date)} to {formatDate(booking.leaving_date)} - 
                Status: {booking.status}
              </li>
            ))}
          </ul>
        </div>
      )}
    </div>
  );
};

export default BookingsDropdown;
