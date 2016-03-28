import React, { PropTypes } from 'react';
import isEmpty from 'lodash/isempty';

import UserThumb from '../user/thumb';

export default class UsersList extends React.Component {
  static get propTypes() {
    return {
      users: PropTypes.array,
      usersFilter: PropTypes.string,
      onFilter: PropTypes.func.isRequired,
    };
  }

  renderUsers(users, usersFilter) {
    if (isEmpty(users)) {
      if (isEmpty(usersFilter)) {
        return (<div className="loading" />);
      }
      return null;
    }

    return users.map(user =>
      <UserThumb key={user.id} id={user.id} avatarUrl={user.avatar_url} name={user.name} />
    );
  }

  render() {
    const { users, usersFilter, onFilter } = this.props;

    return (
      <div>
        <div className="page-header">
          <h1>Users</h1>
          <form>
            <input
              onChange={(e) => { onFilter(e.target.value); }}
              autoFocus
              tabIndex="1"
              type="text"
              placeholder="Filter users by name"
            />
          </form>
        </div>

        <div className="row">
          <div className="users">
            {this.renderUsers(users, usersFilter)}
          </div>
        </div>

      </div>
    );
  }
}
