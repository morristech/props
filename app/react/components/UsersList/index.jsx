import React, { PropTypes } from 'react';

const UsersList = ({ users, filterUsers }) => {
  const handleQuery = (e) => {
    filterUsers(e.target.value);
  };

  return (
    <div>
      <h1>Users</h1>
      <input type="text" onChange={handleQuery} />
      {
        users.map(u => <p key={u.id}>{u.name}</p>)
      }
    </div>
  );
};

UsersList.propTypes = {
  users: PropTypes.arrayOf(PropTypes.shape({
    id: PropTypes.number,
    name: PropTypes.string,
    email: PropTypes.string,
    avatar_url: PropTypes.string,
  })),
  filterUsers: PropTypes.func,
};

export default UsersList;
