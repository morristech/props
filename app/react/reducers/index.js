import { combineReducers } from 'redux';
import props from './props';
import user from './user';
import users from './users';

const rootReducer = combineReducers({
  props,
  users,
  user,
});

export default rootReducer;
