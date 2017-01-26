import { combineReducers } from 'redux';
import { routerReducer } from 'react-router-redux';
import props from './props';
import propsPagination from './props-pagination';
import user from './user';
import users from './users';

const rootReducer = combineReducers({
  props,
  propsPagination,
  users,
  user,
  routing: routerReducer,
});

export default rootReducer;
