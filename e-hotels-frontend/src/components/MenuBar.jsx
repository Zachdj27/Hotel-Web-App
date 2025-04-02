export default function MenuBar() {
    return (
      <div className="menu-bar">
        <h1 className="menu-title">E-Hotels</h1>
        <div className="menu-buttons">
          <button className="menu-button">Update Acount</button>
          <button className="menu-button">Delete Acount</button>
          <a className="menu-button" href="/">Sign Out</a>
        </div>
      </div>
    );
  }
  