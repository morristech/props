import { combineReducers } from 'redux';
import props from './props';
import user from './user';
import users from './users';
import usersFilter from './users-filter';

const rootReducer = combineReducers({
  props,
  user,
  users,
  usersFilter,
});

export default rootReducer;
