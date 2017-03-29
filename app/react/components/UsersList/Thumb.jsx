import React, { PropTypes } from 'react';

const Thumb = ({ id, name, avatarUrl, handleClick }) => {
  const handleProfileClick = () => {
    const userUrl = `/app/users/${id}`;
    handleClick(userUrl);
  };

  return (
    <div className="col-xs-6 col-sm-3 col-md-2">
      <a className="thumbnail user-card" onClick={handleProfileClick}>
        <img src={avatarUrl} alt="avatar" />
        <div className="caption">
          {name}
        </div>
      </a>
    </div>
  );
};

Thumb.propTypes = {
  id: PropTypes.number,
  name: PropTypes.string,
  avatarUrl: PropTypes.string,
  handleClick: PropTypes.func,
};

export default Thumb;
