import { connect } from 'react-redux';
import { values } from 'lodash';
import UsersList from '../../components/UsersList';
import { setUsersQuery } from '../../actions/users';

const getFilteredUsers = (users, query) => (
  values(users).filter(u => u.name.toLowerCase().match(query.toLowerCase()))
);

const mapStateToProps = state => ({
  users: getFilteredUsers(state.users, state.usersQuery),
});

const mapDispatchToProps = dispatch => ({
  filterUsers: (query) => {
    dispatch(setUsersQuery(query));
  },
});

export default connect(
  mapStateToProps,
  mapDispatchToProps,
)(UsersList);
