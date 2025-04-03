import React, { useState } from "react";
import axios from "axios";

const BookingsDropdown = ({ bookings, onUpdate }) => {
  const [showBookings, setShowBookings] = useState(false);

  const toggleBookings = () => {
    setShowBookings(!showBookings);
  };

  const formatDate = (dateString) => {
    const date = new Date(dateString);
    return date.toLocaleDateString();
  };

  const updateBookingStatus = async (bookingId, newStatus) => {
    try {
      console.log(`Updating booking #${bookingId} to ${newStatus}`);
      await axios.put(`http://127.0.0.1:8000/bookings/${bookingId}/status`, {
        status: newStatus,
      });
      console.log(`Booking #${bookingId} updated successfully`);
      alert(`Booking #${bookingId} updated successfully to ${newStatus}`);
      onUpdate(); //refresh bookings list
    } catch (error) {
      console.error("Error updating booking status", error);
      alert("Failed to update booking status.");
    }
  };

  return (
    <div className="bookings-container">
      <button onClick={toggleBookings} className="dropdown-button">
        {showBookings ? "Hide Bookings" : "Show Bookings"}
      </button>

      {showBookings && (
        <div className="bookings-grid">
          {bookings.length === 0 ? (
            <p>No bookings available.</p>
          ) : (
            bookings.map((booking) => (
              <div key={booking.booking_id} className="booking-card">
                <h3>Booking #{booking.booking_id}</h3>
                <p>
                  <strong>Room:</strong> {booking.room_id}
                </p>
                <p>
                  <strong>Dates:</strong> {formatDate(booking.entry_date)} -{" "}
                  {formatDate(booking.leaving_date)}
                </p>
                <p>
                  <strong>Status:</strong> {booking.status}
                </p>
                <p>
                  <strong>Client SIN:</strong> {booking.client}
                </p>

                {/* Show buttons only if status is "Réservé" */}
                {booking.status === "Réservé" && (
                  <div className="button-group">
                    <button
                      className="confirm-button"
                      onClick={() => updateBookingStatus(booking.booking_id, "Confirmé")}
                    >
                      Confirm
                    </button>
                    <button
                      className="cancel-button"
                      onClick={() => updateBookingStatus(booking.booking_id, "Annulé")}
                    >
                      Cancel
                    </button>
                  </div>
                )}
              </div>
            ))
          )}
        </div>
      )}
    </div>
  );
};

export default BookingsDropdown;
