export default function MenuBar({ clientId, onDeleteAccount, onSignOut, handleUpdate }) {
  const handleDeleteAccount = () => {
    if (window.confirm("Are you sure you want to delete your account? This action cannot be undone.")) {
      onDeleteAccount(clientId);
    }
  };
  
  return (
    <div className="menu-bar">
      <h1 className="menu-title">E-Hotels</h1>
      <div className="menu-buttons">
        <button className="menu-button" onClick={handleUpdate}>Update Account</button>
        <button className="menu-button" onClick={handleDeleteAccount}>Delete Account</button>
        <button className="menu-button" onClick={onSignOut}>Sign Out</button>
      </div>
    </div>
  );
}
