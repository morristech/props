import { combineReducers } from 'redux';
import { routerReducer } from 'react-router-redux'
import props from './props';
import user from './user';
import users from './users';

const rootReducer = combineReducers({
  props,
  users,
  user,
  routing: routerReducer,
});

export default rootReducer;
