import React, { PropTypes } from 'react';

const Thumb = ({ id, name, avatarUrl }) => {
  const userUrl = `#users/${id}`;
  return (
    <div className="col-xs-6 col-sm-3 col-md-2">
      <a className="thumbnail user-card" href={userUrl}>
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
};

export default Thumb;
