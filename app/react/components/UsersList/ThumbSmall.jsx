import React, { PropTypes } from 'react';

const ThumbSmall = ({ userObject, handleClick }) => {
  const userUrl = `/app/users/${userObject.id}`;
  const handleProfileClick = (e) => {
    e.preventDefault();
    handleClick(userUrl);
  };


  if (!userObject) { return null; }

  return (
    <a
      href={userUrl}
      className="props-receiver-avatar"
      onClick={handleProfileClick}
    >
      <img src={userObject.avatar_url} title={userObject.name} alt="avatar" />
      <span className="props-receiver-name">{userObject.name.match(/^\w*/).toString()}</span>
    </a>
  );
};

ThumbSmall.propTypes = {
  userObject: PropTypes.shape({
    id: PropTypes.number.isRequired,
    name: PropTypes.string.isRequired,
    avatar_url: PropTypes.string.isRequired,
  }),
  handleClick: PropTypes.func,
};

export default ThumbSmall;
