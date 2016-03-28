import React, { PropTypes } from 'react';
import { connect } from 'react-redux';

import { fetchUsers, setUsersFilter } from '../../actions/index.js';
import UsersList from './list';

class UsersContainer extends React.Component {
  static get propTypes() {
    return {
      dispatch: PropTypes.func.isRequired,
      users: PropTypes.array,
      usersFilter: PropTypes.string,
      onFilter: PropTypes.func.isRequired,
    };
  }

  componentDidMount() {
    const { dispatch } = this.props;
    dispatch(fetchUsers());
  }

  render() {
    const { users, usersFilter, onFilter } = this.props;

    return (
      <UsersList { ...{ users, usersFilter, onFilter }} />
    );
  }
}

const mapStateToProps = (state) => {
  const { usersFilter, users } = state;
  return {
    users: users.filter(user => user.name.toLowerCase().match(usersFilter.toLowerCase())),
    usersFilter,
  };
};

const mapDispatchToProps = (dispatch) => ({
  onFilter: (filter) => { dispatch(setUsersFilter(filter)); },
  dispatch,
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(UsersContainer);
