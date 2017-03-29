import React, { PropTypes } from 'react';

const ThumbSmall = ({ userObject, handleClick }) => {
  const handleProfileClick = () => {
    const userUrl = `/app/users/${userObject.id}`;
    handleClick(userUrl);
  };


  if (!userObject) { return null; }

  return (
    <a className="props-receiver-avatar" onClick={handleProfileClick}>
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
