import React, { PropTypes } from 'react';

const User = ({ userObject }) => {
  if (!userObject) { return null; }

  return (
    <a className="props-receiver-avatar" href={`#users/${userObject.id}`}>
      <img src={userObject.avatar_url} title={userObject.name} alt="avatar" />
      <span className="props-receiver-name">{userObject.name.match(/^\w*/).toString()}</span>
    </a>
  );
};

User.propTypes = {
  userObject: PropTypes.shape({
    id: PropTypes.number.isRequired,
    name: PropTypes.string.isRequired,
    avatar_url: PropTypes.string.isRequired,
  }),
};

export default User;
